// tool/build_version.dart
//
// Reads the version from pubspec.yaml and writes lib/version.dart.
// Run this before every build (or hook it into your CI):
//
//   dart tool/build_version.dart
//
// Or add it to your flutter build command:
//   dart tool/build_version.dart && flutter build apk --release

import 'dart:io';

void main() {
  // ── 1. Read pubspec.yaml ───────────────────────────────────────────────────
  final pubspec = File('pubspec.yaml');
  if (!pubspec.existsSync()) {
    stderr.writeln('Error: pubspec.yaml not found. '
        'Run this script from the project root.');
    exit(1);
  }

  final lines = pubspec.readAsLinesSync();

  // pubspec version looks like:  version: 2.7.0+2
  // We only want the semver part before the '+'.
  String? version;
  for (final line in lines) {
    final match = RegExp(r'^version:\s*(\d+\.\d+\.\d+)').firstMatch(line);
    if (match != null) {
      version = match.group(1);
      break;
    }
  }

  if (version == null) {
    stderr.writeln('Error: could not find a version: x.y.z line in pubspec.yaml.');
    exit(1);
  }

  // ── 2. Write lib/version.dart ─────────────────────────────────────────────
  final output = File('lib/version.dart');
  output.writeAsStringSync('''// GENERATED FILE — do not edit by hand.
// Run `dart tool/build_version.dart` to regenerate.
// Source of truth: pubspec.yaml → version field.

const String kAppVersion = '$version';
''');

  stdout.writeln('✓ lib/version.dart updated → kAppVersion = \'$version\'');
}