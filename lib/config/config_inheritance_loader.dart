import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

/// Config inheritance loader for DEDI Chat
/// Supports inheritance pattern: config.sample.json -> config.json -> config.debug.json
class ConfigInheritanceLoader {
  static const String _baseConfigFile = 'config.sample.json';
  static const String _productionConfigFile = 'config.json';
  static const String _debugConfigFile = 'config.debug.json';

  /// Load configuration with inheritance support
  static Future<Map<String, dynamic>> loadConfig() async {
    String configFile = _productionConfigFile;

    // Auto-select config file based on environment
    if (kDebugMode) {
      configFile = _debugConfigFile;
    }

    return await _loadWithInheritance(configFile);
  }

  /// Load specific config file with inheritance
  static Future<Map<String, dynamic>> loadConfigFile(String fileName) async {
    return await _loadWithInheritance(fileName);
  }

  /// Load configuration with inheritance chain
  static Future<Map<String, dynamic>> _loadWithInheritance(
    String fileName,
  ) async {
    try {
      // Load the requested config file
      final configData = await _loadJsonFile(fileName);

      // Check if this config extends another
      if (configData.containsKey('_extends')) {
        final parentFileName = configData['_extends'] as String;

        // Load parent configuration recursively
        final parentConfig = await _loadWithInheritance(parentFileName);

        // Merge configurations (child overrides parent)
        final mergedConfig = <String, dynamic>{};
        mergedConfig.addAll(parentConfig);
        mergedConfig.addAll(configData);

        // Remove inheritance metadata
        mergedConfig.remove('_extends');
        mergedConfig.remove('_comment');
        mergedConfig.remove('_version');
        mergedConfig.remove('_description');

        return mergedConfig;
      }

      // No inheritance, return as-is
      return configData;
    } catch (e) {
      if (kDebugMode) {
        print('❌ ConfigInheritanceLoader: Failed to load $fileName - $e');
      }
      rethrow;
    }
  }

  /// Load JSON file from assets or filesystem
  static Future<Map<String, dynamic>> _loadJsonFile(String fileName) async {
    try {
      // Try to load from filesystem first (for mobile/desktop)
      final file = File(fileName);
      if (await file.exists()) {
        final content = await file.readAsString();
        return json.decode(content) as Map<String, dynamic>;
      }

      // For web, try HTTP loading
      try {
        final response = await http.get(Uri.parse(fileName));
        if (response.statusCode == 200) {
          return json.decode(response.body) as Map<String, dynamic>;
        }
      } catch (e) {
        // HTTP loading failed, continue to fallback
      }

      // Fallback to default config
      if (fileName != _baseConfigFile) {
        return await _loadJsonFile(_baseConfigFile);
      }

      throw Exception('Config file not found: $fileName');
    } catch (e) {
      if (kDebugMode) {
        print('❌ ConfigInheritanceLoader: Error loading $fileName - $e');
      }
      rethrow;
    }
  }

  /// Get available config files
  static List<String> getAvailableConfigs() {
    return [_baseConfigFile, _productionConfigFile, _debugConfigFile];
  }

  /// Validate config inheritance chain
  static Future<bool> validateInheritanceChain() async {
    try {
      final configs = getAvailableConfigs();

      for (final configFile in configs) {
        final config = await _loadJsonFile(configFile);

        if (config.containsKey('_extends')) {
          final parentFile = config['_extends'] as String;
          if (!configs.contains(parentFile)) {
            if (kDebugMode) {
              print(
                '❌ Invalid inheritance: $configFile extends $parentFile (not found)',
              );
            }
            return false;
          }
        }
      }

      return true;
    } catch (e) {
      if (kDebugMode) {
        print('❌ Inheritance validation failed: $e');
      }
      return false;
    }
  }
}
