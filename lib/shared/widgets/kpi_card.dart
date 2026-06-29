import 'package:flutter/material.dart';
import '../../core/utils/formatters.dart';
import '../../core/theme/app_theme.dart';
import 'loading_widget.dart';

/// Financial KPI Card Widget
/// Displays key performance indicators with trend indicators
class KPICard extends StatelessWidget {
  final String title;
  final double value;
  final String? subtitle;
  final double? change;
  final String? currency;
  final IconData? icon;
  final Color? iconColor;
  final bool isCurrency;
  final bool isPercentage;
  final VoidCallback? onTap;
  final bool isLoading;

  const KPICard({
    super.key,
    required this.title,
    required this.value,
    this.subtitle,
    this.change,
    this.currency,
    this.icon,
    this.iconColor,
    this.isCurrency = true,
    this.isPercentage = false,
    this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: isLoading
              ? _buildLoadingContent()
              : _buildContent(theme),
        ),
      ),
    );
  }

  Widget _buildLoadingContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShimmerLoadingWidget(width: 100, height: 16),
        const SizedBox(height: 12),
        ShimmerLoadingWidget(width: 150, height: 28),
        const SizedBox(height: 8),
        ShimmerLoadingWidget(width: 80, height: 16),
      ],
    );
  }

  Widget _buildContent(ThemeData theme) {
    final isPositive = change == null || change! >= 0;
    final trendColor = isPositive
        ? AppTheme.successColor
        : AppTheme.dangerColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        // Header with icon and title
        Row(
          children: [
            if (icon != null) ...[
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: (iconColor ?? theme.colorScheme.primary).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: iconColor ?? theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 12),
            ],
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Main value
        FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            isPercentage
                ? Formatters.formatPercentage(value)
                : isCurrency
                    ? Formatters.formatCurrency(value)
                    : Formatters.formatNumber(value),
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: _getValueColor(theme),
            ),
          ),
        ),

        if (subtitle != null || change != null) ...[
          const SizedBox(height: 8),

          // Subtitle or trend
          Row(
            children: [
              if (change != null) ...[
                Icon(
                  isPositive ? Icons.trending_up : Icons.trending_down,
                  size: 16,
                  color: trendColor,
                ),
                const SizedBox(width: 4),
                Text(
                  Formatters.formatChange(change!),
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: trendColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              if (subtitle != null)
                Expanded(
                  child: Text(
                    subtitle!,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
            ],
          ),
        ],
      ],
    );
  }

  Color _getValueColor(ThemeData theme) {
    // Custom colors based on value type can be added here
    return theme.colorScheme.onSurface;
  }
}

/// Compact KPI Card for smaller spaces
class CompactKPICard extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;
  final IconData? icon;
  final VoidCallback? onTap;

  const CompactKPICard({
    super.key,
    required this.label,
    required this.value,
    this.valueColor,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 8),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      label,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: valueColor,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}