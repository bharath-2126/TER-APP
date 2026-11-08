import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../core/providers/app_providers.dart';
import '../../../shared/components/financial_card.dart';
import '../../../shared/components/segmented_pill_control.dart';
import '../domain/lending_engine.dart';

class LendingScreen extends ConsumerStatefulWidget {
  const LendingScreen({super.key});

  @override
  ConsumerState<LendingScreen> createState() => _LendingScreenState();
}

class _LendingScreenState extends ConsumerState<LendingScreen> {
  int _selectedTabIndex = 0; // 0: I Lent (Receivable), 1: I Borrowed (Payable)

  void _showRepaymentDialog({
    required BuildContext context,
    required String personId,
    required String personName,
    required int outstandingPaise,
    required bool isLent,
  }) {
    final amountController = TextEditingController();
    String selectedAccountId = 'acc_hdfc';

    showDialog<void>(
      context: context,
      builder: (ctx) {
        return StatefulBuilder(
          builder: (dialogCtx, setDialogState) {
            return AlertDialog(
              backgroundColor: const Color(0xFF131927),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(color: AppColors.primaryBlue.withOpacity(0.3)),
              ),
              title: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isLent ? AppColors.inflow.withOpacity(0.15) : AppColors.outflow.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      isLent ? Icons.south_west_rounded : Icons.north_east_rounded,
                      color: isLent ? AppColors.inflow : AppColors.outflow,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    isLent ? 'Receive Repayment' : 'Make Repayment',
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Person: $personName',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Text(
                        'Total Outstanding: ',
                        style: TextStyle(color: AppColors.textTertiary, fontSize: 12),
                      ),
                      Text(
                        CurrencyFormatter.formatPaise(outstandingPaise),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          fontFamily: 'monospace',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Repayment Amount (₹)',
                    style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  TextField(
                    controller: amountController,
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                    style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                    decoration: InputDecoration(
                      prefixText: '₹ ',
                      prefixStyle: const TextStyle(color: AppColors.primaryBlueGlow, fontSize: 16, fontWeight: FontWeight.bold),
                      hintText: 'e.g. 300',
                      hintStyle: const TextStyle(color: Colors.white24),
                      filled: true,
                      fillColor: const Color(0xFF090D18),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide(color: Colors.white.withOpacity(0.1)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: const BorderSide(color: AppColors.primaryBlueGlow),
                      ),
                    ),
                  ),
                  const SizedBox(height: 14),
                  Text(
                    isLent ? 'Deposit Inflow To Account' : 'Pay Outflow From Account',
                    style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 6),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFF090D18),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.white.withOpacity(0.1)),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        value: selectedAccountId,
                        isExpanded: true,
                        dropdownColor: const Color(0xFF131927),
                        style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w600),
                        items: const [
                          DropdownMenuItem(value: 'acc_hdfc', child: Text('HDFC Salary A/c')),
                          DropdownMenuItem(value: 'acc_icici', child: Text('ICICI Savings A/c')),
                          DropdownMenuItem(value: 'acc_cash', child: Text('Cash Wallet')),
                        ],
                        onChanged: (val) {
                          if (val != null) {
                            setDialogState(() => selectedAccountId = val);
                          }
                        },
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(ctx),
                  child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final text = amountController.text.trim();
                    final amountPaise = CurrencyFormatter.parseToPaise(text);
                    if (amountPaise <= 0 || amountPaise > outstandingPaise) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Please enter a valid amount within the outstanding balance')),
                      );
                      return;
                    }

                    final repo = ref.read(ledgerRepositoryProvider);
                    await repo.recordLendingRepayment(
                      personId: personId,
                      amountPaise: amountPaise,
                      toAccountId: selectedAccountId,
                      notes: 'Repayment from $personName',
                    );

                    Navigator.pop(ctx);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          'Recorded ${CurrencyFormatter.formatPaise(amountPaise)} repayment from $personName. Deposited to selected account.',
                        ),
                        backgroundColor: AppColors.inflow,
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Confirm Repayment', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final debtsAsync = ref.watch(debtsStreamProvider);
    final personsAsync = ref.watch(personsStreamProvider);
    final isPrivacy = ref.watch(privacyModeProvider);

    final isLentView = _selectedTabIndex == 0;
    final allDebts = debtsAsync.value ?? [];
    final allPersons = personsAsync.value ?? [];

    final aggregates = LendingEngine.calculateAggregates(allDebts);
    final currentDebts = allDebts.where((d) => isLentView ? d.type == DebtType.lent : d.type == DebtType.borrowed).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
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
                        const Text('• Person-Wise Ledger', style: TextStyle(color: Colors.white38, fontSize: 10)),
                      ],
                    ),
                    const SizedBox(height: 2),
                    const Text(
                      'Lending & Borrowing',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900, color: Colors.white),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131927),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.people_outline, size: 16, color: AppColors.primaryBlueGlow),
                      const SizedBox(width: 6),
                      Text(
                        '${allPersons.length} Persons',
                        style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Segmented Switcher (I Lent vs I Borrowed)
            SegmentedPillControl(
              segments: const ['I Lent (Receivable)', 'I Borrowed (Payable)'],
              selectedIndex: _selectedTabIndex,
              onSegmentSelected: (index) => setState(() => _selectedTabIndex = index),
            ),
            const SizedBox(height: 16),

            // Aggregate Hero Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: isLentView
                      ? [const Color(0xFF0B291E), const Color(0xFF131927)]
                      : [const Color(0xFF2C1014), const Color(0xFF131927)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(24),
                border: Border.all(
                  color: isLentView ? AppColors.inflow.withOpacity(0.3) : AppColors.outflow.withOpacity(0.3),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 6),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        isLentView ? 'TOTAL MONEY YOU ARE OWED' : 'TOTAL MONEY YOU OWE',
                        style: TextStyle(
                          color: isLentView ? const Color(0xFF6EE7B7) : const Color(0xFFFCA5A5),
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.8,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: (isLentView ? AppColors.inflow : AppColors.outflow).withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          isLentView ? 'Asset (Receivable)' : 'Liability (Payable)',
                          style: TextStyle(
                            color: isLentView ? AppColors.inflow : AppColors.outflow,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    isPrivacy
                        ? '₹ ••••••'
                        : CurrencyFormatter.formatPaise(
                            isLentView ? aggregates.totalLentOutstandingPaise : aggregates.totalBorrowedOutstandingPaise,
                          ),
                    style: TextStyle(
                      color: isLentView ? AppColors.inflow : AppColors.outflow,
                      fontSize: 32,
                      fontWeight: FontWeight.w900,
                      fontFamily: 'monospace',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    isLentView
                        ? 'Auto-tracked from splits & manual loans • 0% interest'
                        : 'Outstanding amounts to repay creditors',
                    style: const TextStyle(color: AppColors.textTertiary, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Person-Wise Profiles Breakdown (for Lent view)
            if (isLentView && allPersons.isNotEmpty) ...[
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 4),
                child: Text(
                  'PERSON PROFILES & SETTLEMENTS',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                ),
              ),
              const SizedBox(height: 10),
              ...allPersons.map((person) {
                final personDebts = allDebts.where((d) => d.personId == person.id && d.type == DebtType.lent).toList();
                final bool isSettled = person.outstandingBalancePaise == 0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131927),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: isSettled ? Colors.white10 : AppColors.primaryBlue.withOpacity(0.25),
                    ),
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
                                width: 40,
                                height: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(int.parse('0xFF${person.avatarColor}')),
                                      AppColors.primaryBlueDark,
                                    ],
                                  ),
                                ),
                                child: Center(
                                  child: Text(
                                    person.name.split(' ').map((n) => n.isNotEmpty ? n[0] : '').take(2).join(),
                                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    person.name,
                                    style: const TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    person.phone ?? 'Verified Contact',
                                    style: const TextStyle(color: AppColors.textTertiary, fontSize: 11),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                isSettled ? 'Settled' : 'Owes You',
                                style: TextStyle(
                                  color: isSettled ? AppColors.inflow : const Color(0xFFF59E0B),
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                isPrivacy ? '₹ ••••••' : CurrencyFormatter.formatPaise(person.outstandingBalancePaise),
                                style: TextStyle(
                                  color: isSettled ? Colors.white54 : Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.w900,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      const Divider(color: Colors.white12, height: 1),
                      const SizedBox(height: 10),

                      // List of linked debts / split entries
                      ...personDebts.map((debt) {
                        final isSplit = debt.splitGroupId != null;
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 4),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(
                                      isSplit ? Icons.call_split_rounded : Icons.handshake_outlined,
                                      size: 14,
                                      color: isSplit ? const Color(0xFF38BDF8) : const Color(0xFFF59E0B),
                                    ),
                                    const SizedBox(width: 6),
                                    Expanded(
                                      child: Text(
                                        debt.notes ?? (isSplit ? 'Split Transaction' : 'Personal Loan'),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(color: Colors.white70, fontSize: 12),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                isPrivacy ? '₹ ••••••' : CurrencyFormatter.formatPaise(debt.outstandingBalancePaise),
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  fontFamily: 'monospace',
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      if (!isSettled) ...[
                        const SizedBox(height: 12),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: ElevatedButton.icon(
                            onPressed: () => _showRepaymentDialog(
                              context: context,
                              personId: person.id,
                              personName: person.name,
                              outstandingPaise: person.outstandingBalancePaise,
                              isLent: true,
                            ),
                            icon: const Icon(Icons.arrow_downward_rounded, size: 16, color: Colors.white),
                            label: const Text('Receive Repayment', style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold)),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryBlue,
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              }),
              const SizedBox(height: 12),
            ],

            // General Debt Ledger List
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 4),
              child: Text(
                'TRANSACTION DETAILS & AUDIT TRAIL',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
              ),
            ),
            const SizedBox(height: 10),

            if (currentDebts.isEmpty)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: const Color(0xFF131927),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text('No active debt entries found in this view', style: TextStyle(color: AppColors.textTertiary, fontSize: 13)),
                ),
              )
            else
              ...currentDebts.map((debt) {
                final isSettled = debt.status == DebtStatus.fullySettled;
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(14),
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
                          color: (debt.splitGroupId != null ? const Color(0xFF06B6D4) : AppColors.primaryBlue).withOpacity(0.18),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(
                          debt.splitGroupId != null ? Icons.call_split_rounded : (isLentView ? Icons.arrow_outward : Icons.arrow_downward),
                          color: debt.splitGroupId != null ? const Color(0xFF38BDF8) : AppColors.primaryBlueGlow,
                          size: 18,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              debt.notes ?? (debt.splitGroupId != null ? 'Split Bill Remainder' : 'Lending Entry'),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Principal: ${CurrencyFormatter.formatPaise(debt.principalPaise)} • ${debt.status.name}',
                              style: const TextStyle(color: AppColors.textTertiary, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            isSettled ? '₹0.00' : (isPrivacy ? '₹ ••••••' : CurrencyFormatter.formatPaise(debt.outstandingBalancePaise)),
                            style: TextStyle(
                              color: isSettled ? Colors.white38 : (isLentView ? AppColors.inflow : AppColors.outflow),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'monospace',
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isSettled ? 'Settled' : 'Pending',
                            style: TextStyle(
                              color: isSettled ? AppColors.inflow : const Color(0xFFF59E0B),
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }),

            const SizedBox(height: 110), // Padding for bottom dock
          ],
        ),
      ),
    );
  }
}
