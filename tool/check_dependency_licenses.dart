import 'dart:convert';
import 'dart:io';

Future<void> main() async {
  final configFile = File('.dart_tool/package_config.json');
  if (!configFile.existsSync()) {
    stderr.writeln('Run flutter pub get before checking dependency licenses.');
    exitCode = 2;
    return;
  }
  final config =
      jsonDecode(await configFile.readAsString()) as Map<String, Object?>;
  final packages = config['packages']! as List<Object?>;
  final missing = <String>[];
  for (final raw in packages) {
    final package = raw! as Map<String, Object?>;
    final name = package['name']! as String;
    if (name == 'banxin_calendar') continue;
    final rootUri = Uri.parse(package['rootUri']! as String);
    if (rootUri.scheme == 'org-dartlang-sdk') continue;
    final root = rootUri.isAbsolute
        ? Directory.fromUri(rootUri)
        : Directory.fromUri(configFile.uri.resolveUri(rootUri));
    var current = root;
    var hasLicense = false;
    for (var depth = 0; depth <= 3 && !hasLicense; depth++) {
      hasLicense = <String>['LICENSE', 'LICENSE.md', 'LICENSE.txt', 'NOTICE']
          .any(
            (name) => File(
              '${current.path}${Platform.pathSeparator}$name',
            ).existsSync(),
          );
      final parent = current.parent;
      if (parent.path == current.path) break;
      current = parent;
    }
    if (!hasLicense) missing.add(name);
  }
  if (missing.isNotEmpty) {
    stderr.writeln(
      'Dependencies without a license/notice file: ${missing.join(', ')}',
    );
    exitCode = 1;
    return;
  }
  stdout.writeln(
    'Dependency license check passed for ${packages.length - 1} packages.',
  );
}
