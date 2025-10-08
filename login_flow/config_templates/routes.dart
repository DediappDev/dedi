/// Navigation Routes Configuration Template
/// Based on: lib/config/routes.dart
///
/// This file defines all the navigation routes for your Matrix chat application.
/// It includes authentication flow, chat screens, and settings pages.

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:matrix/matrix.dart';

// Import your screens here
// import 'package:yourapp/screens/auth/phone_input_page.dart';
// import 'package:yourapp/screens/auth/otp_verify_page.dart';
// import 'package:yourapp/screens/chat/chat_list_page.dart';
// import 'package:yourapp/screens/chat/chat_page.dart';
// import 'package:yourapp/widgets/matrix_provider.dart';

abstract class AppRoutes {
  // =======================
  // ROUTE GUARDS
  // =======================

  /// Redirect to login if user is not authenticated
  static FutureOr<String?> loggedInRedirect(
    BuildContext context,
    GoRouterState state,
  ) {
    // Check if any Matrix client is logged in
    try {
      final matrixProvider = MatrixProvider.of(context);
      final isLoggedIn = matrixProvider.clients.any((client) => client.isLogged());
      return isLoggedIn ? '/rooms' : null;
    } catch (e) {
      return null; // Allow navigation if Matrix provider not available
    }
  }

  /// Redirect to chat list if user is already authenticated
  static FutureOr<String?> loggedOutRedirect(
    BuildContext context,
    GoRouterState state,
  ) {
    try {
      final matrixProvider = MatrixProvider.of(context);
      final isLoggedIn = matrixProvider.clients.any((client) => client.isLogged());
      return isLoggedIn ? null : '/auth/phone';
    } catch (e) {
      return '/auth/phone'; // Redirect to login if error
    }
  }

  /// Check if specific room access is allowed
  static FutureOr<String?> roomAccessRedirect(
    BuildContext context,
    GoRouterState state,
  ) {
    final roomId = state.pathParameters['roomId'];
    if (roomId == null) return '/rooms';

    try {
      final matrixProvider = MatrixProvider.of(context);
      final client = matrixProvider.client;
      if (client == null) return '/auth/phone';

      final room = client.getRoomById(roomId);
      if (room == null) return '/rooms'; // Room not found

      return null; // Allow access
    } catch (e) {
      return '/rooms';
    }
  }

  // =======================
  // MAIN ROUTER CONFIGURATION
  // =======================

  static final GoRouter router = GoRouter(
    initialLocation: '/auth/phone',
    debugLogDiagnostics: true,
    routes: routes,
    errorBuilder: (context, state) => ErrorPage(error: state.error),
    redirect: (context, state) {
      // Global redirect logic can be added here
      return null;
    },
  );

  // =======================
  // ROUTE DEFINITIONS
  // =======================

  static final List<RouteBase> routes = [
    // Root route
    GoRoute(
      path: '/',
      redirect: (context, state) => '/auth/phone',
    ),

    // Authentication routes
    GoRoute(
      path: '/auth',
      redirect: (context, state) => '/auth/phone',
      routes: [
        // Phone input screen
        GoRoute(
          path: '/phone',
          name: 'phone-input',
          pageBuilder: (context, state) => defaultPageBuilder(
            context,
            state,
            const PhoneInputPage(),
          ),
          redirect: loggedInRedirect,
        ),

        // OTP verification screen
        GoRoute(
          path: '/otp',
          name: 'otp-verify',
          pageBuilder: (context, state) {
            final extra = state.extra as Map<String, dynamic>?;
            final phoneNumber = state.uri.queryParameters['phone'] ??
                               extra?['phoneNumber'] ?? '';
            final devOtp = state.uri.queryParameters['dev_otp'] ??
                          extra?['devOtp'];

            return defaultPageBuilder(
              context,
              state,
              OtpVerifyPage(
                phoneNumber: phoneNumber,
                devOtp: devOtp,
              ),
            );
          },
          redirect: loggedInRedirect,
        ),

        // Login success screen (optional)
        GoRoute(
          path: '/success',
          name: 'login-success',
          pageBuilder: (context, state) => defaultPageBuilder(
            context,
            state,
            const LoginSuccessPage(),
          ),
        ),
      ],
    ),

    // Main app shell with chat functionality
    ShellRoute(
      pageBuilder: (context, state, child) => noTransitionPageBuilder(
        context,
        state,
        _buildAppShell(context, state, child),
      ),
      routes: [
        // Chat list and rooms
        GoRoute(
          path: '/rooms',
          name: 'chat-list',
          pageBuilder: (context, state) => defaultPageBuilder(
            context,
            state,
            _buildChatListPage(context, state),
          ),
          redirect: loggedOutRedirect,
          routes: [
            // Individual chat room
            GoRoute(
              path: '/:roomId',
              name: 'chat-room',
              pageBuilder: (context, state) {
                final roomId = state.pathParameters['roomId']!;
                final eventId = state.uri.queryParameters['event'];
                final shareItems = state.extra as List<ShareItem>?;

                return defaultPageBuilder(
                  context,
                  state,
                  ChatPage(
                    roomId: roomId,
                    eventId: eventId,
                    shareItems: shareItems,
                  ),
                );
              },
              redirect: roomAccessRedirect,
              routes: [
                // Chat room details
                GoRoute(
                  path: '/details',
                  name: 'chat-details',
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    state,
                    ChatDetailsPage(
                      roomId: state.pathParameters['roomId']!,
                    ),
                  ),
                  routes: [
                    // Room members
                    GoRoute(
                      path: '/members',
                      name: 'chat-members',
                      pageBuilder: (context, state) => defaultPageBuilder(
                        context,
                        state,
                        ChatMembersPage(
                          roomId: state.pathParameters['roomId']!,
                        ),
                      ),
                    ),
                    // Room settings
                    GoRoute(
                      path: '/settings',
                      name: 'chat-settings',
                      pageBuilder: (context, state) => defaultPageBuilder(
                        context,
                        state,
                        ChatSettingsPage(
                          roomId: state.pathParameters['roomId']!,
                        ),
                      ),
                    ),
                  ],
                ),

                // Chat search
                GoRoute(
                  path: '/search',
                  name: 'chat-search',
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    state,
                    ChatSearchPage(
                      roomId: state.pathParameters['roomId']!,
                    ),
                  ),
                ),
              ],
            ),

            // Create new chat/group
            GoRoute(
              path: '/new',
              redirect: (context, state) => '/rooms/new/private',
              routes: [
                GoRoute(
                  path: '/private',
                  name: 'new-private-chat',
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    state,
                    const NewPrivateChatPage(),
                  ),
                ),
                GoRoute(
                  path: '/group',
                  name: 'new-group',
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    state,
                    const NewGroupPage(),
                  ),
                ),
                GoRoute(
                  path: '/space',
                  name: 'new-space',
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    state,
                    const NewSpacePage(),
                  ),
                ),
              ],
            ),

            // Archive
            GoRoute(
              path: '/archive',
              name: 'archive',
              pageBuilder: (context, state) => defaultPageBuilder(
                context,
                state,
                const ArchivePage(),
              ),
              routes: [
                GoRoute(
                  path: '/:roomId',
                  name: 'archived-chat',
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    state,
                    ChatPage(
                      roomId: state.pathParameters['roomId']!,
                      eventId: state.uri.queryParameters['event'],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),

        // Settings section
        GoRoute(
          path: '/settings',
          name: 'settings',
          pageBuilder: (context, state) => defaultPageBuilder(
            context,
            state,
            _buildSettingsPage(context, state),
          ),
          redirect: loggedOutRedirect,
          routes: [
            // User profile settings
            GoRoute(
              path: '/profile',
              name: 'settings-profile',
              pageBuilder: (context, state) => defaultPageBuilder(
                context,
                state,
                const ProfileSettingsPage(),
              ),
            ),

            // Notification settings
            GoRoute(
              path: '/notifications',
              name: 'settings-notifications',
              pageBuilder: (context, state) => defaultPageBuilder(
                context,
                state,
                const NotificationSettingsPage(),
              ),
            ),

            // Privacy and security
            GoRoute(
              path: '/security',
              name: 'settings-security',
              pageBuilder: (context, state) => defaultPageBuilder(
                context,
                state,
                const SecuritySettingsPage(),
              ),
              routes: [
                GoRoute(
                  path: '/devices',
                  name: 'settings-devices',
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    state,
                    const DeviceSettingsPage(),
                  ),
                ),
                GoRoute(
                  path: '/backup',
                  name: 'settings-backup',
                  pageBuilder: (context, state) => defaultPageBuilder(
                    context,
                    state,
                    const BackupSettingsPage(),
                  ),
                ),
              ],
            ),

            // Appearance settings
            GoRoute(
              path: '/appearance',
              name: 'settings-appearance',
              pageBuilder: (context, state) => defaultPageBuilder(
                context,
                state,
                const AppearanceSettingsPage(),
              ),
            ),

            // Chat settings
            GoRoute(
              path: '/chat',
              name: 'settings-chat',
              pageBuilder: (context, state) => defaultPageBuilder(
                context,
                state,
                const ChatSettingsPage(),
              ),
            ),

            // About/help
            GoRoute(
              path: '/about',
              name: 'settings-about',
              pageBuilder: (context, state) => defaultPageBuilder(
                context,
                state,
                const AboutPage(),
              ),
            ),
          ],
        ),
      ],
    ),

    // Standalone pages
    GoRoute(
      path: '/image-viewer',
      name: 'image-viewer',
      pageBuilder: (context, state) {
        final extra = state.extra as Map<String, dynamic>;
        return fullscreenPageBuilder(
          context,
          state,
          ImageViewerPage(
            imageUrl: extra['imageUrl'],
            heroTag: extra['heroTag'],
          ),
        );
      },
    ),

    // Deep link handlers
    GoRoute(
      path: '/join/:roomAlias',
      name: 'join-room',
      redirect: (context, state) {
        final roomAlias = state.pathParameters['roomAlias']!;
        // Handle room join logic here
        return '/rooms'; // Redirect after processing
      },
    ),

    // Error and loading pages
    GoRoute(
      path: '/loading',
      name: 'loading',
      pageBuilder: (context, state) => defaultPageBuilder(
        context,
        state,
        const LoadingPage(),
      ),
    ),

    GoRoute(
      path: '/error',
      name: 'error',
      pageBuilder: (context, state) => defaultPageBuilder(
        context,
        state,
        ErrorPage(error: state.extra as Exception?),
      ),
    ),
  ];

  // =======================
  // PAGE BUILDERS
  // =======================

  /// Default page builder with transition animation
  static Page<T> defaultPageBuilder<T extends Object?>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      restorationId: state.pageKey.value,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return SlideTransition(
          position: animation.drive(
            Tween(begin: const Offset(1.0, 0.0), end: Offset.zero).chain(
              CurveTween(curve: Curves.easeInOut),
            ),
          ),
          child: child,
        );
      },
    );
  }

  /// No transition page builder for shell routes
  static Page<T> noTransitionPageBuilder<T extends Object?>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return NoTransitionPage<T>(
      key: state.pageKey,
      restorationId: state.pageKey.value,
      child: child,
    );
  }

  /// Fullscreen page builder for modals
  static Page<T> fullscreenPageBuilder<T extends Object?>(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return CustomTransitionPage<T>(
      key: state.pageKey,
      restorationId: state.pageKey.value,
      child: child,
      opaque: false,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: animation,
          child: child,
        );
      },
    );
  }

  // =======================
  // LAYOUT BUILDERS
  // =======================

  /// Build app shell with responsive layout
  static Widget _buildAppShell(
    BuildContext context,
    GoRouterState state,
    Widget child,
  ) {
    return ResponsiveLayout(
      mobileLayout: MobileAppShell(child: child),
      tabletLayout: TabletAppShell(child: child),
      desktopLayout: DesktopAppShell(child: child),
    );
  }

  /// Build chat list page with responsive layout
  static Widget _buildChatListPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return ResponsiveLayout(
      mobileLayout: const ChatListPage(),
      tabletLayout: const TwoColumnChatLayout(),
      desktopLayout: const ThreeColumnChatLayout(),
    );
  }

  /// Build settings page with responsive layout
  static Widget _buildSettingsPage(
    BuildContext context,
    GoRouterState state,
  ) {
    return ResponsiveLayout(
      mobileLayout: const SettingsPage(),
      tabletLayout: const TwoColumnSettingsLayout(),
      desktopLayout: const TwoColumnSettingsLayout(),
    );
  }

  // =======================
  // NAVIGATION HELPERS
  // =======================

  /// Navigate to chat room
  static void goToRoom(BuildContext context, String roomId, {String? eventId}) {
    final location = '/rooms/$roomId${eventId != null ? '?event=$eventId' : ''}';
    context.go(location);
  }

  /// Navigate to new private chat
  static void goToNewPrivateChat(BuildContext context) {
    context.go('/rooms/new/private');
  }

  /// Navigate to settings
  static void goToSettings(BuildContext context, {String? section}) {
    final location = section != null ? '/settings/$section' : '/settings';
    context.go(location);
  }

  /// Navigate to login
  static void goToLogin(BuildContext context) {
    context.go('/auth/phone');
  }

  /// Navigate to OTP verification
  static void goToOtpVerification(
    BuildContext context,
    String phoneNumber, {
    String? devOtp,
  }) {
    context.go('/auth/otp?phone=$phoneNumber${devOtp != null ? '&dev_otp=$devOtp' : ''}');
  }

  // =======================
  // ROUTE INFORMATION
  // =======================

  /// Check if current route is in authentication flow
  static bool isAuthRoute(String location) {
    return location.startsWith('/auth/');
  }

  /// Check if current route is a chat room
  static bool isChatRoute(String location) {
    return RegExp(r'^/rooms/[^/]+$').hasMatch(location);
  }

  /// Check if current route is settings
  static bool isSettingsRoute(String location) {
    return location.startsWith('/settings');
  }

  /// Get room ID from current location
  static String? getRoomIdFromLocation(String location) {
    final match = RegExp(r'^/rooms/([^/]+)').firstMatch(location);
    return match?.group(1);
  }
}

// =======================
// CUSTOM PAGE TYPES
// =======================

/// Custom transition page with configurable transitions
class CustomTransitionPage<T> extends Page<T> {
  final Widget child;
  final bool opaque;
  final RouteTransitionsBuilder? transitionsBuilder;

  const CustomTransitionPage({
    required this.child,
    this.opaque = true,
    this.transitionsBuilder,
    super.key,
    super.name,
    super.arguments,
    super.restorationId,
  });

  @override
  Route<T> createRoute(BuildContext context) {
    return PageRouteBuilder<T>(
      settings: this,
      opaque: opaque,
      pageBuilder: (context, animation, secondaryAnimation) => child,
      transitionsBuilder: transitionsBuilder ??
          (context, animation, secondaryAnimation, child) => child,
    );
  }
}

// =======================
// PLACEHOLDER PAGES
// =======================

/// Error page for navigation errors
class ErrorPage extends StatelessWidget {
  final Exception? error;

  const ErrorPage({super.key, this.error});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Error')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            const Text('Something went wrong'),
            if (error != null) ...[
              const SizedBox(height: 8),
              Text(
                error.toString(),
                style: Theme.of(context).textTheme.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => context.go('/'),
              child: const Text('Go Home'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Loading page for async operations
class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

// =======================
// ROUTE EXTENSIONS
// =======================

extension GoRouterExtension on GoRouter {
  /// Get current location
  String get location {
    final RouteMatch lastMatch = routerDelegate.currentConfiguration.last;
    final RouteMatchList matchList = lastMatch is ImperativeRouteMatch
        ? lastMatch.matches
        : routerDelegate.currentConfiguration;
    return matchList.uri.toString();
  }

  /// Check if can pop
  bool get canPop => routerDelegate.canPop();
}

extension BuildContextExtension on BuildContext {
  /// Get current route location
  String get currentLocation => GoRouter.of(this).location;

  /// Check if can go back
  bool get canPop => GoRouter.of(this).canPop();
}