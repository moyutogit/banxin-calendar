import 'package:banxin_calendar/app/localization/generated/app_localizations.dart';
import 'package:banxin_calendar/app/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FoundationPage extends StatelessWidget {
  const FoundationPage({
    required this.title,
    required this.description,
    required this.icon,
    super.key,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar.large(title: Text(title)),
        SliverPadding(
          padding: const EdgeInsets.all(AppSpacing.md),
          sliver: SliverToBoxAdapter(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 720),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Icon(icon, size: 40, color: colorScheme.primary),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          AppLocalizations.of(context).foundationReady,
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(description),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
