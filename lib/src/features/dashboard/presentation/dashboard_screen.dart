import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../core/providers/app_providers.dart';
import '../../transactions/domain/transaction_model.dart';
import '../../lending/domain/lending_engine.dart';
import '../../transactions/presentation/quick_log_sheet.dart';
import '../../transactions/presentation/split_expense_sheet.dart';
import '../../statements/presentation/statement_generator_screen.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  final VoidCallback? onViewAllPressed;
  final ValueChanged<int>? onNavigateTab;

  const DashboardScreen({
    super.key,
    this.onViewAllPressed,
    this.onNavigateTab,
  });

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good morning';
    if (hour < 17) return 'Good afternoon';
    return 'Good evening';
  }

  void _openQuickLog() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuickLogSheet(),
    );
  }

  void _openQuickLogWithPreset(QuickPresetType preset) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => QuickLogSheet(initialPreset: preset),
    );
  }

  void _openSplitExpense() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const SplitExpenseSheet(),
    );
  }

  void _showBudgetDialog() {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF0F1626),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Daily Budget & Carry Forward', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF131927),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Base Allocation:', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        Text('₹2,050.00', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                      ],
                    ),
                    SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('+ Carry Forward:', style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 12)),
                        Text('+₹450.00', style: TextStyle(color: AppColors.primaryBlueGlow, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                      ],
                    ),
                    Divider(color: Colors.white12, height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Today Available:', style: TextStyle(color: AppColors.inflow, fontWeight: FontWeight.bold, fontSize: 12)),
                        Text('₹2,500.00', style: TextStyle(color: AppColors.inflow, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Unspent surplus from yesterday automatically cascades into today. Editing historical transactions dynamically recalculates forward balances.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Got it', style: TextStyle(color: AppColors.primaryBlueGlow, fontWeight: FontWeight.bold)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final totalBalancePaise = ref.watch(totalNetWorthProvider);
    final bankAndCashPaise = ref.watch(liquidBankAndCashProvider);
    final cardsDuePaise = ref.watch(creditCardsDueProvider);
    final todayIncomePaise = ref.watch(todayIncomePaiseProvider);
    final todayExpensePaise = ref.watch(todayExpensePaiseProvider);
    final transactionsAsync = ref.watch(transactionsStreamProvider);
    final isPrivacy = ref.watch(privacyModeProvider);
    final totalReceivablesPaise = ref.watch(totalLentReceivablesProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 8),

            // A. HEADER SECTION
            _buildHeader(isPrivacy),
            const SizedBox(height: 16),

            // B. TOTAL BALANCE CARD
            _buildTotalBalanceCard(
              totalBalancePaise: totalBalancePaise,
              bankAndCashPaise: bankAndCashPaise,
              cardsDuePaise: cardsDuePaise,
              todayIncomePaise: todayIncomePaise,
              todayExpensePaise: todayExpensePaise,
              isPrivacy: isPrivacy,
            ),
            const SizedBox(height: 14),

            // C. DAILY BUDGET CARD (IMMEDIATELY BELOW TOTAL BALANCE)
            _buildDailyBudgetCard(todayExpensePaise, isPrivacy),
            const SizedBox(height: 18),

            // D. 5-CATEGORY FEATURE HUBS
            _buildCategorySection(totalReceivablesPaise, isPrivacy),
            const SizedBox(height: 20),

            // E. WEEKLY SPENDING VELOCITY CHART
            _buildSpendingOverviewChart(),
            const SizedBox(height: 16),

            // F. UPCOMING PAYMENTS BANNER
            _buildUpcomingPaymentsBanner(),
            const SizedBox(height: 20),

            // G. RECENT TRANSACTIONS (LATEST 5)
            _buildRecentTransactionsSection(transactionsAsync, isPrivacy),
            const SizedBox(height: 110), // Padding for floating bottom bar
          ],
        ),
      ),
    );
  }

  // ================= A. HEADER =================
  Widget _buildHeader(bool isPrivacy) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: const LinearGradient(
                  colors: [Color(0xFF2563EB), Color(0xFF06B6D4)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF2563EB).withOpacity(0.3),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: const Center(
                child: Text(
                  'BK',
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'TER',
                      style: TextStyle(
                        color: AppColors.primaryBlueGlow,
                        fontSize: 12,
                        fontWeight: FontWeight.w900,
                        letterSpacing: 1.0,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text('• Offline Ledger', style: TextStyle(color: Colors.white38, fontSize: 10)),
                  ],
                ),
                const SizedBox(height: 2),
                Text(
                  '${_getGreeting()}, Bharath',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Row(
          children: [
            // Privacy Toggle Button
            GestureDetector(
              onTap: () {
                ref.read(privacyModeProvider.notifier).state = !isPrivacy;
              },
              child: Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFF131927),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white12),
                ),
                child: Icon(
                  isPrivacy ? Icons.visibility_off : Icons.visibility,
                  size: 18,
                  color: isPrivacy ? AppColors.primaryBlueGlow : Colors.white70,
                ),
              ),
            ),
            const SizedBox(width: 8),
            // Notification Bell
            Container(
              width: 38,
              height: 38,
              decoration: BoxDecoration(
                color: const Color(0xFF131927),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(Icons.notifications_none, size: 20, color: Colors.white70),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Container(
                      width: 6,
                      height: 6,
                      decoration: const BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  // ================= B. TOTAL BALANCE CARD =================
  Widget _buildTotalBalanceCard({
    required int totalBalancePaise,
    required int bankAndCashPaise,
    required int cardsDuePaise,
    required int todayIncomePaise,
    required int todayExpensePaise,
    required bool isPrivacy,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF131927), Color(0xFF182238)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3), width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'TOTAL NET WORTH',
                style: TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                decoration: BoxDecoration(
                  color: AppColors.inflow.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.trending_up, size: 12, color: AppColors.inflow),
                    SizedBox(width: 4),
                    Text(
                      '+14.4%',
                      style: TextStyle(color: AppColors.inflow, fontSize: 10, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isPrivacy ? '₹ ••••••' : CurrencyFormatter.formatPaise(totalBalancePaise),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 34,
              fontWeight: FontWeight.w900,
              fontFamily: 'monospace',
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'Assets minus Liabilities • Accurate Integer Paise',
            style: TextStyle(color: AppColors.textTertiary, fontSize: 11),
          ),
          const Divider(color: Colors.white12, height: 24),
          // Sub-row 1: Bank & Cash + Cards Due
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0F1D),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(radius: 3, backgroundColor: AppColors.inflow),
                          SizedBox(width: 6),
                          Text('Bank & Cash', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isPrivacy ? '₹ ••••••' : CurrencyFormatter.formatPaise(bankAndCashPaise),
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0F1D),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          CircleAvatar(radius: 3, backgroundColor: AppColors.outflow),
                          SizedBox(width: 6),
                          Text('Cards Due', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isPrivacy ? '₹ ••••••' : '-${CurrencyFormatter.formatPaise(cardsDuePaise)}',
                        style: const TextStyle(color: AppColors.outflow, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          // Sub-row 2: Today's Income + Today's Spending
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0F1D),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.arrow_upward, size: 10, color: AppColors.inflow),
                          SizedBox(width: 4),
                          Text('Today\'s Income', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isPrivacy ? '₹ ••••••' : '+${CurrencyFormatter.formatPaise(todayIncomePaise)}',
                        style: const TextStyle(color: AppColors.inflow, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0A0F1D),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.arrow_downward, size: 10, color: AppColors.outflow),
                          SizedBox(width: 4),
                          Text('Today\'s Spending', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        isPrivacy ? '₹ ••••••' : '-${CurrencyFormatter.formatPaise(todayExpensePaise)}',
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ================= C. DAILY BUDGET CARD =================
  Widget _buildDailyBudgetCard(int todaySpentPaise, bool isPrivacy) {
    const dailyLimit = 250000; // ₹2,500.00
    final remaining = (dailyLimit - todaySpentPaise).clamp(0, dailyLimit).toInt();
    final progress = (todaySpentPaise / dailyLimit).clamp(0.0, 1.0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131927),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 28,
                    height: 28,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.18),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.bolt, color: AppColors.primaryBlueGlow, size: 16),
                  ),
                  const SizedBox(width: 8),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TODAY\'S DAILY BUDGET',
                        style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                      ),
                      Text('Autoflow with Carry-Forward', style: TextStyle(color: AppColors.textTertiary, fontSize: 9)),
                    ],
                  ),
                ],
              ),
              GestureDetector(
                onTap: _showBudgetDialog,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
                  ),
                  child: const Row(
                    children: [
                      Text('View Budget', style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11, fontWeight: FontWeight.bold)),
                      SizedBox(width: 2),
                      Icon(Icons.chevron_right, size: 14, color: AppColors.primaryBlueGlow),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                isPrivacy ? '₹ ••••••' : CurrencyFormatter.formatPaise(remaining),
                style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w900, fontFamily: 'monospace'),
              ),
              Text(
                'of ₹2,500.00 Limit',
                style: const TextStyle(color: AppColors.textSecondary, fontSize: 11),
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: const Color(0xFF090D18),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.primaryBlueGlow),
              minHeight: 6,
            ),
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '+₹450 carried forward from yesterday',
                style: TextStyle(color: Color(0xFF38BDF8), fontSize: 10, fontWeight: FontWeight.w600),
              ),
              Text('Monthly: 51% spent', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
            ],
          ),
        ],
      ),
    );
  }

  // ================= D. 5 CATEGORY HUBS =================
  Widget _buildCategorySection(int totalReceivablesPaise, bool isPrivacy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'FINANCIAL HUB & MANAGEMENT',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
              ),
              Text('5 Categories', style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            // 1. Income
            Expanded(
              child: _buildCategoryCard(
                title: 'Income',
                subtitle: '+₹85K/mo',
                actionLabel: 'Add & Trends',
                icon: Icons.trending_up,
                accentColor: AppColors.inflow,
                onTap: () => _openQuickLogWithPreset(QuickPresetType.income),
              ),
            ),
            const SizedBox(width: 8),
            // 2. Spends
            Expanded(
              child: _buildCategoryCard(
                title: 'Spends',
                subtitle: '₹42.1K/mo',
                actionLabel: 'Add & Analytics',
                icon: Icons.receipt_long,
                accentColor: AppColors.outflow,
                onTap: () => _openQuickLogWithPreset(QuickPresetType.expense),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 3. ⭐ SPLIT TRANSACTION DEDICATED CARD
        GestureDetector(
          onTap: _openSplitExpense,
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0F2042), Color(0xFF131927)],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFF38BDF8).withOpacity(0.4)),
            ),
            child: Row(
              children: [
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(colors: [Color(0xFF2563EB), Color(0xFF06B6D4)]),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Center(
                    child: Text('➗', style: TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text('Split Transaction', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
                          SizedBox(width: 6),
                          Text('Auto-Lending', style: TextStyle(color: Color(0xFF38BDF8), fontSize: 10, fontWeight: FontWeight.bold)),
                        ],
                      ),
                      SizedBox(height: 2),
                      Text('Pay full bill • Personal share in budget • Auto-lend remainder', style: TextStyle(color: AppColors.textSecondary, fontSize: 10)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('Split Now', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            // 4. Statement Generation
            Expanded(
              child: _buildCategoryCard(
                title: 'Statements',
                subtitle: 'PDF & CSV Export',
                actionLabel: 'Audit Reports',
                icon: Icons.description_outlined,
                accentColor: const Color(0xFF06B6D4),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const StatementGeneratorScreen()),
                  );
                },
              ),
            ),
            const SizedBox(width: 8),
            // 5. Lending & Borrowing
            Expanded(
              child: _buildCategoryCard(
                title: 'Lending',
                subtitle: isPrivacy ? '₹ ••••••' : CurrencyFormatter.formatPaise(totalReceivablesPaise),
                actionLabel: 'Rahul, Priya',
                icon: Icons.handshake_outlined,
                accentColor: const Color(0xFFF59E0B),
                onTap: () {
                  widget.onNavigateTab?.call(1); // Navigate to Lending tab
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        // 6. Accounts & Cards
        _buildCategoryCard(
          title: 'Accounts & Cards Vault',
          subtitle: 'Bank Accounts, Cash Wallet & Encrypted Cards',
          actionLabel: 'View Assets & Liabilities',
          icon: Icons.account_balance_wallet_outlined,
          accentColor: const Color(0xFF8B5CF6),
          onTap: () {
            widget.onNavigateTab?.call(3); // Navigate to Cards tab
          },
        ),
      ],
    );
  }

  Widget _buildCategoryCard({
    required String title,
    required String subtitle,
    required String actionLabel,
    required IconData icon,
    required Color accentColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: const Color(0xFF131927),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accentColor.withOpacity(0.25)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: accentColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(icon, color: accentColor, size: 16),
                ),
                Text(
                  subtitle,
                  style: TextStyle(color: accentColor, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
            const SizedBox(height: 2),
            Text(actionLabel, style: const TextStyle(color: AppColors.textTertiary, fontSize: 10), maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }

  // ================= E. SPENDING OVERVIEW CHART =================
  Widget _buildSpendingOverviewChart() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFF131927),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.white12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('WEEKLY SPENDING VELOCITY', style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8)),
              Text('Peak: Wed (₹4.2K)', style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _buildBar('Mon', '₹1.8K', 35, false),
              _buildBar('Tue', '₹2.4K', 50, false),
              _buildBar('Wed', '₹4.2K', 80, true), // Peak
              _buildBar('Thu', '₹1.1K', 25, false),
              _buildBar('Fri', '₹3.1K', 65, false),
            ],
          ),
          const Divider(color: Colors.white12, height: 20),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Highest Category: Food & Dining (38%)', style: TextStyle(color: Colors.white70, fontSize: 10)),
              Text('Full Analytics >', style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 10, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBar(String day, String amount, double height, bool isPeak) {
    return Column(
      children: [
        Text(amount, style: TextStyle(color: isPeak ? AppColors.primaryBlueGlow : Colors.white38, fontSize: 9, fontFamily: 'monospace')),
        const SizedBox(height: 4),
        Container(
          width: 26,
          height: height,
          decoration: BoxDecoration(
            color: isPeak ? AppColors.primaryBlue : const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(6),
            gradient: isPeak
                ? const LinearGradient(
                    colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )
                : null,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          day,
          style: TextStyle(
            color: isPeak ? AppColors.primaryBlueGlow : AppColors.textSecondary,
            fontSize: 10,
            fontWeight: isPeak ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ],
    );
  }

  // ================= F. UPCOMING PAYMENTS BANNER =================
  Widget _buildUpcomingPaymentsBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: const Color(0xFF0F1E36),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
      ),
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.schedule, color: AppColors.primaryBlueGlow, size: 20),
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('HDFC Regalia Bill', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                    SizedBox(width: 6),
                    Text('Due in 3 days', style: TextStyle(color: Color(0xFFF59E0B), fontSize: 10, fontWeight: FontWeight.bold)),
                  ],
                ),
                SizedBox(height: 2),
                Text('₹18,400.00 • Double-Entry Settlement Ready', style: TextStyle(color: Colors.white70, fontSize: 10, fontFamily: 'monospace')),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Settlement simulated for HDFC Regalia (₹18,400).'),
                  backgroundColor: AppColors.primaryBlueDark,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              minimumSize: Size.zero,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Settle', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  // ================= G. RECENT TRANSACTIONS =================
  Widget _buildRecentTransactionsSection(AsyncValue<List<TransactionModel>> transactionsAsync, bool isPrivacy) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'RECENT TRANSACTIONS',
              style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
            ),
            GestureDetector(
              onTap: widget.onViewAllPressed,
              child: const Text('View All', style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
        const SizedBox(height: 10),
        transactionsAsync.when(
          data: (transactions) {
            if (transactions.isEmpty) {
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF131927),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text('No transactions logged today.', style: TextStyle(color: AppColors.textTertiary, fontSize: 12)),
                ),
              );
            }
            final recent = transactions.take(5).toList();
            return Column(
              children: recent.map((tx) {
                final isInflow = tx.isInflow;
                final isSplit = tx.type == TransactionType.splitExpense;
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131927),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: (isSplit ? Colors.cyan : (isInflow ? AppColors.inflow : AppColors.outflow)).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          isSplit ? Icons.call_split : (isInflow ? Icons.arrow_downward : Icons.arrow_upward),
                          color: isSplit ? Colors.cyan : (isInflow ? AppColors.inflow : AppColors.outflow),
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tx.note ?? (isInflow ? 'Income' : 'Expense'),
                              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              isSplit ? 'Split Transaction • Today' : 'Today, Nov 08',
                              style: const TextStyle(color: AppColors.textTertiary, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        isPrivacy
                            ? '₹ ••••••'
                            : '${isInflow ? '+' : '-'}${CurrencyFormatter.formatPaise(tx.amountPaise)}',
                        style: TextStyle(
                          color: isInflow ? AppColors.inflow : AppColors.outflow,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const SizedBox(),
        ),
      ],
    );
  }
}
