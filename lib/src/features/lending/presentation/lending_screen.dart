import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../shared/components/financial_card.dart';
import '../../../shared/components/segmented_pill_control.dart';
import '../domain/lending_engine.dart';

class LendingScreen extends StatefulWidget {
  const LendingScreen({super.key});

  @override
  State<LendingScreen> createState() => _LendingScreenState();
}

class _LendingScreenState extends State<LendingScreen> {
  int _selectedTabIndex = 0; // 0: I Lent (Receivable), 1: I Borrowed (Payable)

  // In-memory records demonstrating the immutable lending engine
  final List<DebtRecord> _debts = [
    DebtRecord(
      id: 'debt_1',
      personId: 'person_rahul',
      type: DebtType.lent,
      principalPaise: 1000000, // ₹10,000
      outstandingBalancePaise: 700000, // ₹7,000 (after ₹3,000 partial payment)
      initialDate: DateTime.now().subtract(const Duration(days: 15)),
      dueDate: DateTime.now().add(const Duration(days: 15)),
      status: DebtStatus.partiallyPaid,
      notes: 'Emergency medical loan',
    ),
    DebtRecord(
      id: 'debt_2',
      personId: 'person_priya',
      type: DebtType.lent,
      principalPaise: 250000, // ₹2,500
      outstandingBalancePaise: 250000,
      initialDate: DateTime.now().subtract(const Duration(days: 3)),
      status: DebtStatus.active,
      notes: 'Concert tickets split',
    ),
    DebtRecord(
      id: 'debt_3',
      personId: 'person_vikram',
      type: DebtType.borrowed,
      principalPaise: 500000, // ₹5,000
      outstandingBalancePaise: 500000,
      initialDate: DateTime.now().subtract(const Duration(days: 7)),
      status: DebtStatus.active,
      notes: 'Hardware parts advance',
    ),
  ];

  void _recordPartialRepayment(DebtRecord debt) {
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: AppColors.backgroundSecondary,
          title: Text(
            debt.type == DebtType.lent ? 'Receive Repayment' : 'Pay Back',
            style: AppTypography.cardTitle,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Outstanding: ${CurrencyFormatter.formatPaise(debt.outstandingBalancePaise)}',
                style: AppTypography.cardSubtitle,
              ),
              const SizedBox(height: 12),
              TextField(
                controller: controller,
                keyboardType: TextInputType.number,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Enter amount in ₹',
                  hintStyle: const TextStyle(color: AppColors.textTertiary),
                  filled: true,
                  fillColor: AppColors.cardSurface,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
            ),
            ElevatedButton(
              onPressed: () {
                final amountPaise = CurrencyFormatter.parseToPaise(controller.text);
                if (amountPaise > 0 && amountPaise <= debt.outstandingBalancePaise) {
                  final result = LendingEngine.applyRepayment(
                    debt: debt,
                    repaymentId: 'rep_${DateTime.now().millisecondsSinceEpoch}',
                    repaymentAmountPaise: amountPaise,
                    repaymentDate: DateTime.now(),
                    notes: 'Partial payment',
                  );
                  setState(() {
                    final index = _debts.indexOf(debt);
                    _debts[index] = debt.copyWithOutstanding(
                      newOutstanding: result.newOutstandingPaise,
                      newStatus: result.newStatus,
                    );
                  });
                  Navigator.pop(context);
                }
              },
              style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryBlue),
              child: const Text('Record'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final aggregates = LendingEngine.calculateAggregates(_debts);
    final isLentView = _selectedTabIndex == 0;
    final currentDebts = _debts.where((d) => isLentView ? d.type == DebtType.lent : d.type == DebtType.borrowed).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 12),
            const Text(
              'Lending & Borrowing',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
            ),
            const SizedBox(height: 16),
            // Segmented Switcher
            SegmentedPillControl(
              segments: const ['I Lent (Receivable)', 'I Borrowed (Payable)'],
              selectedIndex: _selectedTabIndex,
              onSegmentSelected: (index) => setState(() => _selectedTabIndex = index),
            ),
            const SizedBox(height: 20),
            // Aggregate Summary Hero
            FinancialCard(
              padding: const EdgeInsets.all(20),
              backgroundColor: isLentView ? const Color(0x1F10B981) : const Color(0x1FEF4444),
              border: Border.all(
                color: isLentView ? AppColors.inflow.withOpacity(0.3) : AppColors.outflow.withOpacity(0.3),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isLentView ? 'Total Money You Are Owed' : 'Total Money You Owe',
                    style: AppTypography.cardSubtitle,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    CurrencyFormatter.formatPaise(
                      isLentView ? aggregates.totalLentOutstandingPaise : aggregates.totalBorrowedOutstandingPaise,
                      symbol: '₹',
                    ),
                    style: AppTypography.heroBalance.copyWith(
                      color: isLentView ? AppColors.inflow : AppColors.outflow,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            // Debt list
            ...List.generate(currentDebts.length, (index) {
              final debt = currentDebts[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: FinancialCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(debt.personId.replaceFirst('person_', '').toUpperCase(), style: AppTypography.cardTitle),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: debt.status == DebtStatus.fullySettled
                                  ? const Color(0x1F10B981)
                                  : AppColors.primaryBlue.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              debt.status == DebtStatus.fullySettled
                                  ? 'Settled'
                                  : (debt.status == DebtStatus.partiallyPaid ? 'Partially Paid' : 'Active'),
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                                color: debt.status == DebtStatus.fullySettled ? AppColors.inflow : AppColors.primaryBlueGlow,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Original Principal', style: AppTypography.cardSubtitle),
                              const SizedBox(height: 2),
                              Text(CurrencyFormatter.formatPaise(debt.principalPaise), style: AppTypography.amountMedium),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('Remaining Balance', style: AppTypography.cardSubtitle),
                              const SizedBox(height: 2),
                              Text(
                                CurrencyFormatter.formatPaise(debt.outstandingBalancePaise),
                                style: AppTypography.amountMedium.copyWith(
                                  color: isLentView ? AppColors.inflow : AppColors.outflow,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      if (debt.status != DebtStatus.fullySettled) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 38,
                          child: OutlinedButton(
                            onPressed: () => _recordPartialRepayment(debt),
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(color: AppColors.primaryBlue, width: 1),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                            ),
                            child: Text(
                              isLentView ? 'Receive Repayment' : 'Make Repayment',
                              style: const TextStyle(color: AppColors.primaryBlueGlow, fontSize: 13),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }
}
