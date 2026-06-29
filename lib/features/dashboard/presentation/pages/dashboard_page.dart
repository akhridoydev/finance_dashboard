import 'package:flutter/material.dart';
import '../../../../shared/widgets/kpi_card.dart';
import '../../../../core/theme/app_theme.dart';

/// Executive Dashboard Page
/// Shows high-level financial KPIs and metrics for business owners
class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App Bar
          SliverAppBar(
            expandedHeight: 120,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: const Text('Executive Dashboard'),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppTheme.primaryColor.withValues(alpha: 0.8),
                      AppTheme.secondaryColor.withValues(alpha: 0.6),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Dashboard Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Date Filter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Financial Overview',
                        style: theme.textTheme.headlineSmall,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.calendar_today,
                              size: 16,
                              color: theme.colorScheme.onPrimaryContainer,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'This Month',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  // Primary KPI Cards
                  _buildPrimaryKPIs(context),

                  const SizedBox(height: 24),

                  // Secondary KPI Cards
                  Text(
                    'Financial Health',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildFinancialHealthCards(context),

                  const SizedBox(height: 24),

                  // Performance Metrics
                  Text(
                    'Performance Metrics',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildPerformanceCards(context),

                  const SizedBox(height: 24),

                  // Business Metrics
                  Text(
                    'Business Metrics',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildBusinessCards(context),

                  const SizedBox(height: 32),

                  // Quick Actions
                  Text(
                    'Quick Actions',
                    style: theme.textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildQuickActions(context),

                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrimaryKPIs(BuildContext context) {
    return GridView.count(
      crossAxisCount: _getCrossAxisCount(context),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: const [
        KPICard(
          title: 'Total Revenue',
          value: 125000.50,
          change: 15.3,
          icon: Icons.account_balance_wallet,
          iconColor: AppTheme.revenueColor,
        ),
        KPICard(
          title: 'Net Profit',
          value: 45000.75,
          change: 8.7,
          icon: Icons.trending_up,
          iconColor: AppTheme.profitColor,
        ),
        KPICard(
          title: 'Total Expenses',
          value: 79999.75,
          change: -5.2,
          icon: Icons.money_off,
          iconColor: AppTheme.expenseColor,
        ),
        KPICard(
          title: 'Cash in Hand',
          value: 32000.00,
          subtitle: '+ Bank Balance',
          icon: Icons.account_balance,
          iconColor: AppTheme.primaryColor,
        ),
      ],
    );
  }

  Widget _buildFinancialHealthCards(BuildContext context) {
    return GridView.count(
      crossAxisCount: _getCrossAxisCount(context),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: const [
        KPICard(
          title: 'Accounts Receivable',
          value: 28500.00,
          subtitle: '12 invoices pending',
          icon: Icons.receipt_long,
          iconColor: AppTheme.infoColor,
        ),
        KPICard(
          title: 'Accounts Payable',
          value: 15200.00,
          subtitle: '8 bills pending',
          icon: Icons.payment,
          iconColor: AppTheme.warningColor,
        ),
        KPICard(
          title: 'Investment Value',
          value: 150000.00,
          change: 12.5,
          icon: Icons.show_chart,
          iconColor: AppTheme.investmentColor,
        ),
        KPICard(
          title: 'Owner Equity',
          value: 275000.00,
          subtitle: 'Updated today',
          icon: Icons.business_center,
          iconColor: AppTheme.secondaryColor,
        ),
      ],
    );
  }

  Widget _buildPerformanceCards(BuildContext context) {
    return GridView.count(
      crossAxisCount: _getCrossAxisCount(context),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: const [
        KPICard(
          title: 'Gross Profit Margin',
          value: 36.0,
          isPercentage: true,
          change: 2.1,
          icon: Icons.percent,
          iconColor: AppTheme.profitColor,
        ),
        KPICard(
          title: 'ROI',
          value: 18.5,
          isPercentage: true,
          change: 1.8,
          icon: Icons.rocket_launch,
          iconColor: AppTheme.successColor,
        ),
        KPICard(
          title: 'EBITDA',
          value: 52000.00,
          change: 10.2,
          icon: Icons.analytics,
          iconColor: AppTheme.revenueColor,
        ),
        KPICard(
          title: 'Cash Flow',
          value: 18500.00,
          change: -3.5,
          icon: Icons.currency_exchange,
          iconColor: AppTheme.primaryColor,
        ),
      ],
    );
  }

  Widget _buildBusinessCards(BuildContext context) {
    return GridView.count(
      crossAxisCount: _getCrossAxisCount(context),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 1.5,
      children: const [
        KPICard(
          title: 'Active Projects',
          value: 8,
          subtitle: '3 completed this month',
          icon: Icons.folder_open,
          iconColor: AppTheme.infoColor,
          isCurrency: false,
        ),
        KPICard(
          title: 'Total Employees',
          value: 15,
          subtitle: '+2 new hires',
          icon: Icons.people,
          iconColor: AppTheme.secondaryColor,
          isCurrency: false,
        ),
        KPICard(
          title: 'Active Clients',
          value: 24,
          subtitle: '+3 new clients',
          icon: Icons.business,
          iconColor: AppTheme.successColor,
          isCurrency: false,
        ),
        KPICard(
          title: 'Outstanding Invoices',
          value: 5,
          subtitle: '\$28,500 pending',
          icon: Icons.description,
          iconColor: AppTheme.warningColor,
          isCurrency: false,
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: [
        _QuickActionCard(
          icon: Icons.add_circle,
          label: 'Add Income',
          color: AppTheme.successColor,
          onTap: () {
            // Navigate to income creation
          },
        ),
        _QuickActionCard(
          icon: Icons.remove_circle,
          label: 'Add Cost',
          color: AppTheme.expenseColor,
          onTap: () {
            // Navigate to cost recording
          },
        ),
        _QuickActionCard(
          icon: Icons.trending_up,
          label: 'Add Investment',
          color: AppTheme.investmentColor,
          onTap: () {
            // Navigate to investment creation
          },
        ),
        _QuickActionCard(
          icon: Icons.receipt_long,
          label: 'New Invoice',
          color: AppTheme.primaryColor,
          onTap: () {
            // Navigate to invoice creation
          },
        ),
        _QuickActionCard(
          icon: Icons.account_balance,
          label: 'Bank Transfer',
          color: AppTheme.secondaryColor,
          onTap: () {
            // Navigate to bank transfer
          },
        ),
        _QuickActionCard(
          icon: Icons.assessment,
          label: 'Generate Report',
          color: AppTheme.infoColor,
          onTap: () {
            // Navigate to report generation
          },
        ),
        _QuickActionCard(
          icon: Icons.download,
          label: 'Export Data',
          color: AppTheme.successColor,
          onTap: () {
            // Show export options
          },
        ),
        _QuickActionCard(
          icon: Icons.settings,
          label: 'Settings',
          color: AppTheme.textSecondary,
          onTap: () {
            // Navigate to settings
          },
        ),
      ],
    );
  }

  int _getCrossAxisCount(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    if (width > 1200) return 4;
    if (width > 800) return 3;
    if (width > 600) return 2;
    return 1;
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: color,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}