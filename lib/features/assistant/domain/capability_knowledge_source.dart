abstract interface class CapabilityKnowledgeSource {
  Future<String> capabilities();

  Future<String> featureHelp();

  Future<String> safetyRules();

  Future<String> toolDefinitions();
}
