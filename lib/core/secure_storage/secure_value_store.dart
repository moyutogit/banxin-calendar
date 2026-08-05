abstract interface class SecureValueStore {
  Future<void> write({required String reference, required String value});

  Future<String?> read({required String reference});

  Future<void> delete({required String reference});
}
