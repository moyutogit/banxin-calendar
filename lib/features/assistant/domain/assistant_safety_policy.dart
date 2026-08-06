final class AssistantSafetyPolicy {
  const AssistantSafetyPolicy();

  bool mustRefuse(String input) {
    final normalized = input.toLowerCase();
    return <String>[
      'api key',
      'apikey',
      '读取密钥',
      '显示密钥',
      'skip confirmation',
      'bypass confirmation',
      '跳过确认',
      '执行代码',
      '执行 sql',
      '执行命令',
      'run command',
    ].any(normalized.contains);
  }
}
