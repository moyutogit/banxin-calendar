import 'package:banxin_calendar/features/assistant/domain/capability_knowledge_source.dart';
import 'package:flutter/services.dart';

final class AssetCapabilityKnowledgeSource
    implements CapabilityKnowledgeSource {
  const AssetCapabilityKnowledgeSource();

  @override
  Future<String> capabilities() =>
      rootBundle.loadString('assets/assistant/app_capabilities.zh-CN.json');

  @override
  Future<String> featureHelp() =>
      rootBundle.loadString('assets/assistant/feature_help.zh-CN.json');

  @override
  Future<String> safetyRules() =>
      rootBundle.loadString('assets/assistant/safety_rules.zh-CN.md');

  @override
  Future<String> toolDefinitions() =>
      rootBundle.loadString('assets/assistant/tool_definitions.json');
}
