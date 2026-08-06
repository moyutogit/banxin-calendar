import 'dart:convert';
import 'dart:io';

import 'package:banxin_calendar/core/app_version.dart';
import 'package:banxin_calendar/core/ids/stable_id_generator.dart';
import 'package:banxin_calendar/core/logging/app_logger.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

final class AppErrorReporter {
  AppErrorReporter._();

  static final AppErrorReporter instance = AppErrorReporter._();
  static const int _maximumRecords = 50;

  final AppLogger _logger = AppLogger('diagnostics');
  final StableIdGenerator _ids = UuidV4Generator();
  Future<void> _writeChain = Future<void>.value();

  String report(Object error, {required String source}) {
    final id = _ids.generate();
    final record = <String, Object?>{
      'diagnostic_id': id,
      'created_at_utc': DateTime.now().toUtc().toIso8601String(),
      'source': source,
      'error_type': error.runtimeType.toString(),
      'app_version': AppVersion.display,
    };
    _logger.event(Level.SEVERE, 'unhandled_error', fields: record);
    _writeChain = _writeChain.then((_) => _persist(record));
    return id;
  }

  Future<String> exportRedactedBundle() async {
    await _writeChain;
    final records = await _readRecords();
    final documents = await getApplicationDocumentsDirectory();
    final directory = Directory(path.join(documents.path, 'exports'));
    await directory.create(recursive: true);
    final output = File(
      path.join(
        directory.path,
        'banxin-diagnostics-${DateTime.now().toUtc().millisecondsSinceEpoch}.json',
      ),
    );
    await output.writeAsString(
      const JsonEncoder.withIndent('  ').convert(<String, Object?>{
        'format_version': 1,
        'redacted': true,
        'app_version': AppVersion.display,
        'records': records,
      }),
      flush: true,
    );
    return output.path;
  }

  Future<void> _persist(Map<String, Object?> record) async {
    final file = await _recordsFile();
    final records = await _readRecords();
    records.add(record);
    if (records.length > _maximumRecords) {
      records.removeRange(0, records.length - _maximumRecords);
    }
    final temporary = File('${file.path}.tmp');
    await temporary.writeAsString(jsonEncode(records), flush: true);
    await temporary.rename(file.path);
  }

  Future<List<Map<String, Object?>>> _readRecords() async {
    final file = await _recordsFile();
    if (!await file.exists()) return <Map<String, Object?>>[];
    final decoded = jsonDecode(await file.readAsString());
    if (decoded is! List<Object?>) return <Map<String, Object?>>[];
    return decoded
        .whereType<Map<String, dynamic>>()
        .map((record) => record.cast<String, Object?>())
        .toList();
  }

  Future<File> _recordsFile() async {
    final support = await getApplicationSupportDirectory();
    final directory = Directory(path.join(support.path, 'diagnostics'));
    await directory.create(recursive: true);
    return File(path.join(directory.path, 'redacted_records.json'));
  }
}
