import 'dart:io';

import 'package:banxin_calendar/features/statistics/domain/csv_exporter.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

final class LocalCsvExporter implements CsvExporter {
  @override
  Future<String> write({
    required String fileName,
    required List<int> bytes,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final exportDirectory = Directory(path.join(directory.path, 'exports'));
    await exportDirectory.create(recursive: true);
    final file = File(path.join(exportDirectory.path, fileName));
    await file.writeAsBytes(bytes, flush: true);
    return file.path;
  }
}
