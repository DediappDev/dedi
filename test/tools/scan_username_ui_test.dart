import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:path/path.dart' as p;

import '../../tools/scan_username_ui.dart';

void main() {
  test('scanner finds UI matches and skips auth/login files', () {
    final Directory fixtureRoot = Directory('test/fixtures/scan_username_ui');
    final UsernameUiScanner scanner = UsernameUiScanner(
      projectRoot: fixtureRoot,
      libDir: Directory(p.join(fixtureRoot.path, 'lib')),
    );

    final List<UiMatch> matches = scanner.scan();
    final Set<String> paths = matches.map((UiMatch match) => match.relativePath).toSet();

    expect(paths, contains('lib/pages/profile/profile_view.dart'));
    expect(paths, contains('lib/pages/search/search_view.dart'));
    expect(paths.where((String path) => path.contains('auth')).isEmpty, isTrue);
  });

  test('report builder emits summary and exclusions', () {
    final List<UiMatch> matches = <UiMatch>[
      UiMatch(
        relativePath: 'lib/pages/profile/profile_view.dart',
        line: 10,
        snippet: 'Text(displayName)',
        category: 'Profil',
      ),
      UiMatch(
        relativePath: 'lib/pages/search/search_view.dart',
        line: 8,
        snippet: 'ListTile(title: Text(username),',
        category: 'Arama',
      ),
    ];

    final ReportBuilder builder =
        ReportBuilder(excludedGlobs: usernameUiReportedExclusions);
    final String report = builder.build(matches);

    expect(report, contains('Harita görünümü'));
    expect(report, contains('Hariç Tutulanlar'));
    expect(report, contains('auth'));
    expect(report, contains('profile_view.dart'));
    expect(report, contains('search_view.dart'));
  });
}
