abstract interface class CsvExporter {
  Future<String> write({required String fileName, required List<int> bytes});
}
