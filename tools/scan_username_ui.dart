import 'dart:io';

import 'package:path/path.dart' as p;

const List<String> _excludedSegments = <String>[
  'auth',
  'login',
  'signin',
  'register',
  'onboarding',
  'session',
  'generated',
];

List<String> get usernameUiExcludedSegments =>
    List<String>.unmodifiable(_excludedSegments);

const List<String> _reportedExclusions = <String>[
  'lib/auth/**',
  '**/login*',
  '**/signin*',
  '**/register*',
  '**/onboarding*',
  '**/session*',
  'lib/generated/**',
];

List<String> get usernameUiReportedExclusions =>
    List<String>.unmodifiable(_reportedExclusions);

const List<String> _keywordTokens = <String>[
  'displayname',
  'display_name',
  'display name',
  'username',
  'user name',
  'userid',
  'user id',
  'sendername',
  'authorname',
];

const List<String> _uiHints = <String>[
  'Text(',
  'ListTile',
  'AppBar',
  'CircleAvatar',
  'UserAvatar',
  'Avatar',
  'Chip(',
  'Tooltip',
  'SearchDelegate',
  'TextField',
  'TextFormField',
  'labelText',
  'hintText',
  'title:',
  'subtitle:',
];

class UiMatch {
  UiMatch({
    required this.relativePath,
    required this.line,
    required this.snippet,
    required this.category,
  });

  final String relativePath;
  final int line;
  final String snippet;
  final String category;
}

class UsernameUiScanner {
  UsernameUiScanner({
    required this.projectRoot,
    required this.libDir,
  });

  final Directory projectRoot;
  final Directory libDir;

  List<UiMatch> scan() {
    if (!libDir.existsSync()) {
      throw StateError('Missing lib directory at ${libDir.path}');
    }

    final List<UiMatch> matches = <UiMatch>[];
    final String rootPath = projectRoot.path;

    for (final FileSystemEntity entity
        in libDir.listSync(recursive: true, followLinks: false)) {
      if (entity is! File || !entity.path.endsWith('.dart')) {
        continue;
      }

      final String relativePath = p.relative(entity.path, from: rootPath);
      if (_isExcluded(relativePath)) {
        continue;
      }

      final bool isUiFile = _isUiFile(relativePath);
      final List<String> lines = entity.readAsLinesSync();

      for (int index = 0; index < lines.length; index++) {
        final String line = lines[index];
        final String trimmed = line.trim();
        if (trimmed.startsWith('//')) {
          continue;
        }

        if (!_containsKeyword(trimmed)) {
          continue;
        }

        final bool isUiContext =
            _containsUiHint(trimmed) || _looksLikeUiLine(trimmed, isUiFile);
        if (!isUiContext) {
          continue;
        }

        matches.add(
          UiMatch(
            relativePath: relativePath,
            line: index + 1,
            snippet: _shorten(trimmed),
            category: _categoryFor(relativePath),
          ),
        );
      }
    }

    matches.sort((UiMatch a, UiMatch b) {
      final int pathCompare = a.relativePath.compareTo(b.relativePath);
      if (pathCompare != 0) {
        return pathCompare;
      }
      return a.line.compareTo(b.line);
    });

    return matches;
  }

  bool _isExcluded(String relativePath) {
    final String lowerPath = relativePath.toLowerCase();
    return _excludedSegments.any((String segment) => lowerPath.contains(segment));
  }

  bool _isUiFile(String relativePath) {
    return relativePath.contains('pages/') ||
        relativePath.contains('widgets/') ||
        relativePath.contains('presentation/') ||
        relativePath.contains('utils/');
  }

  bool _containsKeyword(String line) {
    final String lower = line.toLowerCase();
    return _keywordTokens.any((String token) => lower.contains(token));
  }

  bool _containsUiHint(String line) {
    return _uiHints.any((String hint) => line.contains(hint));
  }

  bool _looksLikeUiLine(String line, bool isUiFile) {
    final String lower = line.toLowerCase();
    final bool hasDisplayToken = lower.contains('displayname') ||
        lower.contains('display name') ||
        lower.contains('username') ||
        lower.contains('user name') ||
        lower.contains('user id');

    if (!isUiFile || !hasDisplayToken) {
      return false;
    }

    final bool hasAssignment =
        line.contains(':') || line.contains('=>') || line.contains('=');
    final bool isDeclaration = lower.startsWith('class ') ||
        lower.startsWith('import ') ||
        lower.startsWith('export ') ||
        lower.startsWith('typedef ') ||
        lower.startsWith('final string') ||
        lower.startsWith('late final string') ||
        lower.startsWith('string get');

    return hasAssignment && !isDeclaration;
  }

  String _categoryFor(String relativePath) {
    final String lower = relativePath.toLowerCase();
    if (lower.contains('profile')) {
      return 'Profil';
    }
    if (lower.contains('search')) {
      return 'Arama';
    }
    if (lower.contains('chat_list') ||
        lower.contains('chat_details') ||
        lower.contains('chat_profile_info') ||
        lower.contains('room_header') ||
        lower.contains('chat/events')) {
      return 'Oda Başlığı/Mesaj';
    }
    return 'Diğer';
  }
}

class ReportBuilder {
  ReportBuilder({required this.excludedGlobs});

  final List<String> excludedGlobs;

  String build(List<UiMatch> matches) {
    final StringBuffer buffer = StringBuffer();
    final Map<String, Set<String>> categoryCounts = <String, Set<String>>{};
    final Map<String, List<UiMatch>> grouped = <String, List<UiMatch>>{};

    for (final UiMatch match in matches) {
      categoryCounts.putIfAbsent(match.category, () => <String>{}).add(match.relativePath);
      grouped.putIfAbsent(match.relativePath, () => <UiMatch>[]).add(match);
    }

    final int totalFiles = grouped.keys.length;

    buffer.writeln('# Username / Display Name UI Kullanımları');
    buffer.writeln();
    buffer.writeln('## Harita görünümü');
    buffer.writeln('| Kategori | Dosya sayısı |');
    buffer.writeln('| --- | --- |');
    const List<String> orderedCategories = <String>[
      'Profil',
      'Arama',
      'Oda Başlığı/Mesaj',
      'Diğer',
    ];

    for (final String category in orderedCategories) {
      final int count = categoryCounts[category]?.length ?? 0;
      buffer.writeln('| $category | $count |');
    }
    buffer.writeln('| Toplam | $totalFiles |');
    buffer.writeln();
    buffer.writeln('Toplam bulunan dosya: $totalFiles');
    buffer.writeln();

    buffer.writeln('## Detaylar');

    for (final MapEntry<String, List<UiMatch>> entry in grouped.entries) {
      final String path = entry.key;
      final String category = entry.value.first.category;
      buffer.writeln('### `$path` (Kategori: $category)');
      for (final UiMatch match in entry.value) {
        buffer.writeln(
            '- Satır ${match.line}: `${match.snippet}` — kullanıcı adı/görünen ad UI render; auth/login akışı değil.');
      }
      buffer.writeln();
    }

    buffer.writeln('## Hariç Tutulanlar');
    for (final String glob in excludedGlobs) {
      buffer.writeln('- `$glob`');
    }

    return buffer.toString();
  }
}

String _shorten(String line) {
  const int maxLength = 140;
  if (line.length <= maxLength) {
    return line;
  }
  return '${line.substring(0, maxLength)}…';
}

void main(List<String> arguments) {
  final Directory projectRoot = Directory.current;
  final Directory libDir = Directory(p.join(projectRoot.path, 'lib'));
  final String outputPath = arguments.isNotEmpty
      ? arguments.first
      : p.join(projectRoot.path, 'reports/username_ui_usages.md');

  final UsernameUiScanner scanner =
      UsernameUiScanner(projectRoot: projectRoot, libDir: libDir);
  final List<UiMatch> matches = scanner.scan();
  final ReportBuilder builder =
      ReportBuilder(excludedGlobs: usernameUiReportedExclusions);
  final String report = builder.build(matches);

  final File outputFile = File(outputPath)..createSync(recursive: true);
  outputFile.writeAsStringSync(report);
  // ignore: avoid_print
  print('Report written to ${p.relative(outputPath, from: projectRoot.path)}');
}
