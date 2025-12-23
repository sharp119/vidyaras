import 'package:flutter/material.dart';
import '../../theme/app_spacing.dart';

/// Stats row component displaying multiple stat items
/// Design System: Theme-based typography
class StatsRow extends StatelessWidget {
  const StatsRow({super.key, required this.stats});

  final List<StatItem> stats;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: stats
          .map(
            (stat) => _StatItemWidget(
              value: stat.value,
              label: stat.label,
              color: stat.color,
            ),
          )
          .toList(),
    );
  }
}

class StatItem {
  const StatItem({required this.value, required this.label, this.color});

  final dynamic value;
  final String label;
  final Color? color;
}

class _StatItemWidget extends StatelessWidget {
  const _StatItemWidget({required this.value, required this.label, this.color});

  final dynamic value;
  final String label;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value.toString(),
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: color ?? theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          label,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
