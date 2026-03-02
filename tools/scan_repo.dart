import 'dart:io';

import 'package:args/args.dart';
import 'package:glob/glob.dart';
import 'package:glob/list_local_fs.dart';
import 'package:path/path.dart' as p;

class CopyEntry {
  CopyEntry({
    required this.keyOrLiteral,
    required this.uiLocation,
    required this.file,
    required this.lineStart,
    required this.lineEnd,
    required this.widgetPath,
    required this.usageKind,
    required this.i18nSource,
    required this.controllerLink,
    required this.notes,
  });

  final String keyOrLiteral;
  final String uiLocation;
  final String file;
  final int lineStart;
  final int lineEnd;
  final String widgetPath;
  final String usageKind;
  final String i18nSource;
  final String controllerLink;
  final String notes;
}

class VisualEntry {
  VisualEntry({
    required this.file,
    required this.lineStart,
    required this.lineEnd,
    required this.widgetPath,
    required this.description,
    required this.controllerLink,
    required this.source,
  });

  final String file;
  final int lineStart;
  final int lineEnd;
  final String widgetPath;
  final String description;
  final String controllerLink;
  final String source;
}

class ControllerEntry {
  ControllerEntry({
    required this.widget,
    required this.file,
    required this.binding,
    required this.expression,
    required this.controller,
    required this.scope,
    required this.notes,
  });

  final String widget;
  final String file;
  final String binding;
  final String expression;
  final String controller;
  final String scope;
  final String notes;
}

class EventTraceEntry {
  EventTraceEntry({
    required this.uiElement,
    required this.file,
    required this.lineStart,
    required this.lineEnd,
    required this.callbackSnippet,
    required this.flow,
  });

  final String uiElement;
  final String file;
  final int lineStart;
  final int lineEnd;
  final String callbackSnippet;
  final String flow;
}

class CatalogEntry {
  CatalogEntry({
    required this.screen,
    required this.file,
    required this.copyRefs,
    required this.actions,
    required this.controllers,
    required this.keyFlows,
  });

  final String screen;
  final String file;
  final List<String> copyRefs;
  final List<String> actions;
  final List<String> controllers;
  final List<String> keyFlows;
}

const List<String> _copyWidgets = <String>[
  'Text(',
  'SelectableText(',
  'RichText(',
  'AppBar(',
  'ListTile(',
  'SnackBar(',
  'AlertDialog(',
  'CupertinoAlertDialog(',
  'MaterialBanner(',
  'Tooltip(',
  'Tab(',
  'Chip(',
  'InputDecoration(',
  'TextField(',
  'TextFormField(',
  'SearchBar(',
  'SearchField(',
  'PopupMenuItem(',
  'ElevatedButton(',
  'TextButton(',
  'OutlinedButton(',
  'FilledButton(',
  'IconButton(',
];

const List<String> _visualWidgets = <String>[
  'CircleAvatar',
  'Avatar(',
  'UserAvatar',
  'UserImage',
  'FadeInImage',
  'Image.network',
  'Image.asset',
  'CachedNetworkImage',
  'ClipOval',
  'HeroAvatar',
];

const List<String> _actionKeys = <String>[
  'onPressed:',
  'onTap:',
  'onLongPress:',
  'onSecondaryTap:',
  'onDoubleTap:',
  'onSelected:',
  'onChanged:',
  'onSubmitted:',
];

const List<String> _controllerHints = <String>[
  'BlocBuilder<',
  'BlocConsumer<',
  'BlocListener<',
  'Cubit',
  'ChangeNotifierProvider',
  'Consumer<',
  'Provider.of',
  'context.read',
  'context.watch',
  'ref.watch',
  'ref.read',
  'ValueListenableBuilder',
  'TextEditingController',
  'StreamBuilder',
  'FutureBuilder',
];

String _detectI18nSource(String line) {
  final String lower = line.toLowerCase();
  if (lower.contains('l10n.of') || lower.contains('s.of')) {
    return 'localizations';
  }
  if (lower.contains("tr('") || lower.contains('intl.')) {
    return 'arb';
  }
  return 'literal';
}

String _detectUsageKind(String line, String widget) {
  if (line.contains('title:')) return 'title';
  if (line.contains('subtitle:')) return 'subtitle';
  if (line.contains('label') || line.contains('InputDecoration')) return 'label';
  if (line.contains('hint')) return 'hint';
  if (line.contains('tooltip')) return 'tooltip';
  if (line.contains('SnackBar')) return 'toast';
  if (line.contains('AlertDialog') || line.contains('CupertinoAlertDialog')) {
    return 'alert';
  }
  if (line.contains('MaterialBanner')) return 'banner';
  if (line.toLowerCase().contains('empty')) return 'empty';
  if (line.toLowerCase().contains('error')) return 'error';
  if (widget.contains('Button')) return 'button';
  return 'text';
}

String _extractLiteral(String line) {
  final RegExp literal = RegExp(r"'([^']{1,120})'");
  final Match? single = literal.firstMatch(line);
  if (single != null) return single.group(1) ?? line.trim();
  final RegExp doubleQuote = RegExp(r'"([^"]{1,120})"');
  final Match? dbl = doubleQuote.firstMatch(line);
  if (dbl != null) return dbl.group(1) ?? line.trim();
  return line.trim().replaceAll(',', '');
}

String _currentScope(List<String> stack) {
  if (stack.isEmpty) return 'global';
  return stack.join(' → ');
}

String _firstController(List<String> controllers) {
  if (controllers.isEmpty) return '';
  return controllers.first;
}

String _trim(String text, [int max = 160]) {
  if (text.length <= max) return text;
  return '${text.substring(0, max)}…';
}

void main(List<String> args) {
  final ArgParser parser = ArgParser()
    ..addOption('root', defaultsTo: 'lib')
    ..addOption('max-lines', defaultsTo: '500');
  final ArgResults results = parser.parse(args);
  final Directory root = Directory(results['root'] as String);
  final int maxLines = int.tryParse(results['max-lines'] as String) ?? 500;

  if (!root.existsSync()) {
    stderr.writeln('Root ${root.path} not found');
    exit(1);
  }

  final List<CopyEntry> copies = <CopyEntry>[];
  final List<VisualEntry> visuals = <VisualEntry>[];
  final List<ControllerEntry> controllers = <ControllerEntry>[];
  final List<EventTraceEntry> traces = <EventTraceEntry>[];
  final List<CatalogEntry> catalogs = <CatalogEntry>[];

  final Glob glob = Glob('**/*.dart');
  for (final FileSystemEntity entity in glob.listSync(root: root.path)) {
    if (entity is! File) continue;
    final List<String> lines = entity.readAsLinesSync();
    final String relPath = p.relative(entity.path, from: Directory.current.path);

    if (relPath.contains('${p.separator}generated${p.separator}') ||
        relPath.endsWith('.g.dart')) {
      continue;
    }

    final List<String> scopeStack = <String>[];
    final List<String> localControllers = <String>[];

    for (int i = 0; i < lines.length; i++) {
      final String line = lines[i];
      final String trimmed = line.trim();
      if (trimmed.startsWith('//')) continue;

      final RegExp classRegex = RegExp(r'class (\w+)');
      final Match? classMatch = classRegex.firstMatch(trimmed);
      if (classMatch != null) {
        scopeStack
          ..clear()
          ..add(classMatch.group(1)!);
      }

      for (final String hint in _controllerHints) {
        if (trimmed.contains(hint)) {
          final String expression = _trim(trimmed);
          controllers.add(
            ControllerEntry(
              widget: _currentScope(scopeStack),
              file: relPath,
              binding: _bindingType(hint),
              expression: expression,
              controller: _inferControllerName(trimmed),
              scope: _scopeFromPath(relPath),
              notes: 'Detected via $hint',
            ),
          );
          localControllers.add(expression);
        }
      }

      for (final String widget in _copyWidgets) {
        if (trimmed.contains(widget)) {
          final String usageKind = _detectUsageKind(trimmed, widget);
          final String literal = _extractLiteral(trimmed);
          copies.add(
            CopyEntry(
              keyOrLiteral: literal,
              uiLocation: _currentScope(scopeStack),
              file: relPath,
              lineStart: i + 1,
              lineEnd: i + 1,
              widgetPath: '${_currentScope(scopeStack)} → $widget',
              usageKind: usageKind,
              i18nSource: _detectI18nSource(trimmed),
              controllerLink: _firstController(localControllers),
              notes: 'Auto-detected',
            ),
          );
        }
      }

      for (final String widget in _visualWidgets) {
        if (trimmed.contains(widget)) {
          visuals.add(
            VisualEntry(
              file: relPath,
              lineStart: i + 1,
              lineEnd: i + 1,
              widgetPath: '${_currentScope(scopeStack)} → $widget',
              description: _trim(trimmed),
              controllerLink: _firstController(localControllers),
              source: trimmed.contains('asset')
                  ? 'asset'
                  : (trimmed.contains('http') || trimmed.contains('mxContent'))
                      ? 'remote/cache'
                      : 'unknown',
            ),
          );
        }
      }

      for (final String action in _actionKeys) {
        if (trimmed.contains(action)) {
          final List<String> snippet = <String>[];
          for (int j = i; j < lines.length && snippet.length < 6; j++) {
            snippet.add(lines[j].trim());
          }
          traces.add(
            EventTraceEntry(
              uiElement: action,
              file: relPath,
              lineStart: i + 1,
              lineEnd: (i + snippet.length),
              callbackSnippet: _trim(snippet.join(' '), 200),
              flow: _inferFlow(snippet.join(' ')),
            ),
          );
        }
      }
    }

    catalogs.add(
      CatalogEntry(
        screen: scopeStack.isEmpty ? p.basename(relPath) : scopeStack.first,
        file: relPath,
        copyRefs: copies.where((CopyEntry c) => c.file == relPath).map((CopyEntry c) => c.widgetPath).toList(),
        actions: traces.where((EventTraceEntry e) => e.file == relPath).map((EventTraceEntry e) => e.uiElement).toList(),
        controllers: localControllers,
        keyFlows: traces.where((EventTraceEntry e) => e.file == relPath).map((EventTraceEntry e) => e.flow).toList(),
      ),
    );
  }

  _writeCopyRegistry(copies, maxLines);
  _writeVisuals(visuals, maxLines);
  _writeControllerMap(controllers, maxLines);
  _writeEventTrace(traces, maxLines);
  _writeCatalog(catalogs, maxLines);
}

String _bindingType(String hint) {
  if (hint.startsWith('Bloc')) return 'BLoC/Cubit';
  if (hint.startsWith('ChangeNotifierProvider') || hint.startsWith('Consumer')) {
    return 'Provider';
  }
  if (hint.startsWith('ref.')) return 'Riverpod';
  if (hint.contains('ValueListenable')) return 'ValueNotifier';
  if (hint.contains('TextEditingController')) return 'TextEditingController';
  if (hint.contains('StreamBuilder')) return 'StreamBuilder';
  if (hint.contains('FutureBuilder')) return 'FutureBuilder';
  if (hint.contains('context.read') || hint.contains('context.watch')) {
    return 'Provider/Bloc';
  }
  return 'Other';
}

String _inferControllerName(String line) {
  final RegExp generic = RegExp(r'<([A-Za-z0-9_]+)');
  final Match? match = generic.firstMatch(line);
  if (match != null) return match.group(1) ?? '';
  final RegExp varName = RegExp(r'(\w+)Controller');
  final Match? ctrl = varName.firstMatch(line);
  if (ctrl != null) return ctrl.group(0) ?? '';
  return '';
}

String _scopeFromPath(String path) {
  if (path.contains('pages/')) return 'page';
  if (path.contains('widgets/')) return 'widget';
  if (path.contains('modules/')) return 'module';
  return 'misc';
}

String _inferFlow(String snippet) {
  if (snippet.contains('Navigator') || snippet.contains('GoRouter')) {
    return 'Navigation';
  }
  if (snippet.contains('showDialog') || snippet.contains('ScaffoldMessenger')) {
    return 'Dialog/Toast';
  }
  if (snippet.contains('bloc') || snippet.contains('add(')) {
    return 'Bloc event dispatch';
  }
  if (snippet.contains('ref.') || snippet.contains('notifyListeners')) {
    return 'State update';
  }
  return 'Action callback';
}

void _writeCopyRegistry(List<CopyEntry> entries, int maxLines) {
  final File file = File('reports/ui_copy_registry.csv')..createSync(recursive: true);
  final StringBuffer buffer = StringBuffer();
  buffer.writeln(
      'key_or_literal,ui_location,file,line_start,line_end,widget_path,usage_kind,i18n_source,controller_link,notes');
  for (final CopyEntry entry in entries.take(maxLines)) {
    final String cleanedKey = entry.keyOrLiteral.replaceAll('"', "'");
    final String cleanedWidget = entry.widgetPath.replaceAll('"', "'");
    final String cleanedController = entry.controllerLink.replaceAll('"', "'");
    final List<String> row = <String>[
      '"$cleanedKey"',
      entry.uiLocation,
      entry.file,
      entry.lineStart.toString(),
      entry.lineEnd.toString(),
      '"$cleanedWidget"',
      entry.usageKind,
      entry.i18nSource,
      '"$cleanedController"',
      entry.notes.replaceAll(',', ';'),
    ];
    buffer.writeln(row.join(','));
  }
  file.writeAsStringSync(buffer.toString());
}

void _writeVisuals(List<VisualEntry> entries, int maxLines) {
  final File file = File('reports/ui_visual_elements.md')..createSync(recursive: true);
  final StringBuffer buffer = StringBuffer();
  buffer.writeln('# UI Visual Elements');
  buffer.writeln();
  buffer.writeln('| Dosya | Satır | Widget | Ne gösterir | Controller | Kaynak |');
  buffer.writeln('| --- | --- | --- | --- | --- | --- |');
  for (final VisualEntry entry in entries.take(maxLines)) {
    buffer.writeln(
        '| ${entry.file} | ${entry.lineStart}-${entry.lineEnd} | ${entry.widgetPath} | ${entry.description} | ${entry.controllerLink} | ${entry.source} |');
  }
  file.writeAsStringSync(buffer.toString());
}

void _writeControllerMap(List<ControllerEntry> entries, int maxLines) {
  final File file = File('reports/ui_to_controller_map.md')..createSync(recursive: true);
  final StringBuffer buffer = StringBuffer();
  buffer.writeln('# UI ↔ Controller Map');
  buffer.writeln();
  final Map<String, int> summary = <String, int>{};
  for (final ControllerEntry entry in entries) {
    summary.update(entry.binding, (int v) => v + 1, ifAbsent: () => 1);
  }
  buffer.writeln('| Bağ türü | Sayı |');
  buffer.writeln('| --- | --- |');
  summary.forEach((String key, int value) {
    buffer.writeln('| $key | $value |');
  });
  buffer.writeln();
  buffer.writeln('| Widget/Ekran | Dosya | Bağ türü | Bağlantı ifadesi | Controller | Kapsam | Notlar |');
  buffer.writeln('| --- | --- | --- | --- | --- | --- | --- |');
  for (final ControllerEntry entry in entries.take(maxLines)) {
    buffer.writeln(
        '| ${entry.widget} | ${entry.file} | ${entry.binding} | ${entry.expression} | ${entry.controller} | ${entry.scope} | ${entry.notes} |');
  }
  file.writeAsStringSync(buffer.toString());
}

void _writeEventTrace(List<EventTraceEntry> entries, int maxLines) {
  final File file = File('reports/ui_event_trace.md')..createSync(recursive: true);
  final StringBuffer buffer = StringBuffer();
  buffer.writeln('# UI Event Trace');
  buffer.writeln();
  buffer.writeln('## En Kritik 10 Etkileşim');
  buffer.writeln('| # | Dosya | Satır | Callback | Akış |');
  buffer.writeln('| --- | --- | --- | --- | --- |');
  for (int i = 0; i < entries.length && i < 10; i++) {
    final EventTraceEntry entry = entries[i];
    buffer.writeln(
        '| ${i + 1} | ${entry.file} | ${entry.lineStart}-${entry.lineEnd} | `${entry.callbackSnippet}` | ${entry.flow} |');
  }
  buffer.writeln();
  buffer.writeln('| UI öğesi | Dosya | Satır | Callback | Akış |');
  buffer.writeln('| --- | --- | --- | --- | --- |');
  for (final EventTraceEntry entry in entries.take(maxLines)) {
    buffer.writeln(
        '| ${entry.uiElement} | ${entry.file} | ${entry.lineStart}-${entry.lineEnd} | `${entry.callbackSnippet}` | ${entry.flow} |');
  }
  file.writeAsStringSync(buffer.toString());
}

void _writeCatalog(List<CatalogEntry> entries, int maxLines) {
  final File file = File('reports/ui_catalog.md')..createSync(recursive: true);
  final StringBuffer buffer = StringBuffer();
  buffer.writeln('# UI Catalog');
  buffer.writeln();
  buffer.writeln('| Ekran | Dosya | Metin Adet | Aksiyon Adet | Controller Adet |');
  buffer.writeln('| --- | --- | --- | --- | --- |');
  for (final CatalogEntry entry in entries.take(maxLines)) {
    buffer.writeln(
        '| ${entry.screen} | ${entry.file} | ${entry.copyRefs.length} | ${entry.actions.length} | ${entry.controllers.length} |');
  }
  file.writeAsStringSync(buffer.toString());
}
