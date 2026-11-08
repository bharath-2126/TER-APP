import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../core/providers/app_providers.dart';

class SplitExpenseSheet extends ConsumerStatefulWidget {
  const SplitExpenseSheet({super.key});

  @override
  ConsumerState<SplitExpenseSheet> createState() => _SplitExpenseSheetState();
}

class _SplitExpenseSheetState extends ConsumerState<SplitExpenseSheet> {
  final TextEditingController _totalBillController = TextEditingController(text: '1000');
  final TextEditingController _descController = TextEditingController(text: 'Restaurant (Punjab Grill)');
  final TextEditingController _myShareController = TextEditingController(text: '400');
  final TextEditingController _rahulShareController = TextEditingController(text: '600');
  final TextEditingController _priyaShareController = TextEditingController(text: '0');

  bool _isEqualSplit = false; // default to custom as requested
  bool _includePriya = false;
  String _selectedAccount = 'acc_hdfc';

  @override
  void dispose() {
    _totalBillController.dispose();
    _descController.dispose();
    _myShareController.dispose();
    _rahulShareController.dispose();
    _priyaShareController.dispose();
    super.dispose();
  }

  void _onTotalBillChanged(String val) {
    if (_isEqualSplit) {
      _recalcEqualSplit();
    } else {
      setState(() {});
    }
  }

  void _setSplitMode(bool equal) {
    setState(() {
      _isEqualSplit = equal;
      if (equal) {
        _recalcEqualSplit();
      }
    });
  }

  void _recalcEqualSplit() {
    final total = double.tryParse(_totalBillController.text) ?? 0;
    final count = _includePriya ? 3 : 2;
    if (count == 0) return;

    final share = (total / count).floor();
    final remainder = (total - (share * count)).toInt();

    _myShareController.text = (share + remainder).toString();
    _rahulShareController.text = share.toString();
    if (_includePriya) {
      _priyaShareController.text = share.toString();
    }
    setState(() {});
  }

  void _togglePriya() {
    setState(() {
      _includePriya = !_includePriya;
      if (!_includePriya) {
        _priyaShareController.text = '0';
      }
      if (_isEqualSplit) {
        _recalcEqualSplit();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final totalBill = double.tryParse(_totalBillController.text) ?? 0;
    final myShare = double.tryParse(_myShareController.text) ?? 0;
    final rahulShare = double.tryParse(_rahulShareController.text) ?? 0;
    final priyaShare = _includePriya ? (double.tryParse(_priyaShareController.text) ?? 0) : 0;

    final allocatedSum = myShare + rahulShare + priyaShare;
    final isBalanced = (allocatedSum == totalBill && totalBill > 0);

    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F1626),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(top: BorderSide(color: Color(0x333B82F6), width: 1.5)),
      ),
      padding: EdgeInsets.only(
        top: 16,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle & Header
            Center(
              child: Container(
                width: 44,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 14),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          '➗',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Split Expense',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Automatic Lending & Double-Entry',
                          style: TextStyle(
                            color: AppColors.primaryBlueGlow.withOpacity(0.9),
                            fontSize: 11,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Total Bill Card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF131927),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'TOTAL BILL PAID BY YOU',
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.5,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: AppColors.primaryBlue.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Text(
                          'Today: Automatic',
                          style: TextStyle(
                            color: AppColors.primaryBlueGlow,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text(
                        '₹',
                        style: TextStyle(
                          color: AppColors.primaryBlueGlow,
                          fontSize: 28,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: TextField(
                          controller: _totalBillController,
                          keyboardType: const TextInputType.numberWithOptions(decimal: true),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            fontFamily: 'monospace',
                          ),
                          onChanged: _onTotalBillChanged,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: '0',
                            hintStyle: TextStyle(color: Colors.white24),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Divider(color: Colors.white12, height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(color: AppColors.textTertiary, fontSize: 10),
                            ),
                            const SizedBox(height: 4),
                            TextField(
                              controller: _descController,
                              style: const TextStyle(color: Colors.white, fontSize: 12),
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                filled: true,
                                fillColor: const Color(0xFF090D18),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Paid From Account',
                              style: TextStyle(color: AppColors.textTertiary, fontSize: 10),
                            ),
                            const SizedBox(height: 4),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFF090D18),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  value: _selectedAccount,
                                  isDense: true,
                                  dropdownColor: const Color(0xFF131927),
                                  style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w600),
                                  items: const [
                                    DropdownMenuItem(value: 'acc_hdfc', child: Text('HDFC Salary A/c')),
                                    DropdownMenuItem(value: 'acc_icici', child: Text('ICICI Savings')),
                                    DropdownMenuItem(value: 'acc_cash', child: Text('Cash Wallet')),
                                  ],
                                  onChanged: (v) {
                                    if (v != null) setState(() => _selectedAccount = v);
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),

            // Mode Toggle: Equal vs Custom
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFF131927),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _setSplitMode(true),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: _isEqualSplit ? AppColors.primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'A. Equal Split',
                          style: TextStyle(
                            color: _isEqualSplit ? Colors.white : AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => _setSplitMode(false),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: BoxDecoration(
                          color: !_isEqualSplit ? AppColors.primaryBlue : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'B. Custom Split',
                          style: TextStyle(
                            color: !_isEqualSplit ? Colors.white : AppColors.textSecondary,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Participants Header & Status
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'PARTICIPANTS & SHARES',
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  isBalanced
                      ? '✓ 100% Balanced'
                      : '⚠️ Diff: ₹${(totalBill - allocatedSum).toStringAsFixed(2)}',
                  style: TextStyle(
                    color: isBalanced ? AppColors.inflow : AppColors.outflow,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // 1. My Share (Personal Expense) Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B).withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.primaryBlue.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: AppColors.primaryBlue,
                    child: const Text('ME', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'MY SHARE',
                              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Personal Expense',
                                style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        const Text(
                          'Only this share affects your budget & stats',
                          style: TextStyle(color: AppColors.textTertiary, fontSize: 10),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: TextField(
                      controller: _myShareController,
                      enabled: !_isEqualSplit,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        prefixText: '₹ ',
                        prefixStyle: const TextStyle(color: AppColors.primaryBlueGlow),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        filled: true,
                        fillColor: const Color(0xFF090D18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // 2. Rahul's Share (Auto-Lent) Card
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF131927),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.inflow.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFF059669),
                    child: Text('RK', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Text(
                              'Rahul Kumar',
                              style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 6),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                              decoration: BoxDecoration(
                                color: AppColors.inflow.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: const Text(
                                'Auto-Lent',
                                style: TextStyle(color: AppColors.inflow, fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          'Owed: ₹300 → Increases to ₹${(300 + rahulShare).toStringAsFixed(0)}',
                          style: const TextStyle(color: AppColors.inflow, fontSize: 10, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    child: TextField(
                      controller: _rahulShareController,
                      enabled: !_isEqualSplit,
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      textAlign: TextAlign.right,
                      style: const TextStyle(color: AppColors.inflow, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                      onChanged: (_) => setState(() {}),
                      decoration: InputDecoration(
                        prefixText: '₹ ',
                        prefixStyle: const TextStyle(color: AppColors.inflow),
                        isDense: true,
                        contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        filled: true,
                        fillColor: const Color(0xFF090D18),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),

            // Optional 3rd Participant: Priya
            if (_includePriya) ...[
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: const Color(0xFF131927),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: Colors.amber.withOpacity(0.4)),
                ),
                child: Row(
                  children: [
                    const CircleAvatar(
                      radius: 18,
                      backgroundColor: Colors.amber,
                      child: Text('PS', style: TextStyle(color: Colors.black, fontSize: 11, fontWeight: FontWeight.bold)),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Priya Sharma',
                                style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: Colors.amber.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Auto-Lent',
                                  style: TextStyle(color: Colors.amber, fontSize: 9, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            'Creates separate lending ledger entry',
                            style: TextStyle(color: Colors.amber, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 90,
                      child: TextField(
                        controller: _priyaShareController,
                        enabled: !_isEqualSplit,
                        keyboardType: const TextInputType.numberWithOptions(decimal: true),
                        textAlign: TextAlign.right,
                        style: const TextStyle(color: Colors.amber, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
                        onChanged: (_) => setState(() {}),
                        decoration: InputDecoration(
                          prefixText: '₹ ',
                          prefixStyle: const TextStyle(color: Colors.amber),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                          filled: true,
                          fillColor: const Color(0xFF090D18),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],

            // Add/Remove Multi-Person button
            GestureDetector(
              onTap: _togglePriya,
              child: Row(
                children: [
                  Icon(
                    _includePriya ? Icons.remove_circle_outline : Icons.add_circle_outline,
                    color: AppColors.primaryBlueGlow,
                    size: 16,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    _includePriya ? 'Remove Priya' : '+ Add Priya (Multi-Person Split)',
                    style: const TextStyle(
                      color: AppColors.primaryBlueGlow,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Live Math Summary Banner
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFF090D18),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white12),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Total Bank Deduction (HDFC):', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      Text('-₹${totalBill.toStringAsFixed(2)}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'monospace')),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Your Expense (Budget & Stats):', style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11)),
                      Text('₹${myShare.toStringAsFixed(2)}', style: const TextStyle(color: AppColors.primaryBlueGlow, fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'monospace')),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Money Lent (Receivable Asset):', style: TextStyle(color: AppColors.inflow, fontSize: 11)),
                      Text('+₹${(rahulShare + priyaShare).toStringAsFixed(2)}', style: const TextStyle(color: AppColors.inflow, fontWeight: FontWeight.bold, fontSize: 11, fontFamily: 'monospace')),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isBalanced
                    ? () {
                        final repo = ref.read(ledgerRepositoryProvider);
                        final participantShares = <String, int>{
                          'person_rahul': (rahulShare * 100).toInt(),
                        };
                        if (_includePriya && priyaShare > 0) {
                          participantShares['person_priya'] = (priyaShare * 100).toInt();
                        }

                        final myPaise = (myShare * 100).toInt();
                        final totalPaise = (totalBill * 100).toInt();

                        repo.recordSplitTransaction(
                          totalBillPaise: totalPaise,
                          mySharePaise: myPaise,
                          description: _descController.text.trim(),
                          fromAccountId: _selectedAccount,
                          participantShares: participantShares,
                          transactionTimestamp: DateTime.now(),
                        );

                        // Record in daily budget personal share ONLY
                        ref.read(dailyBudgetProvider.notifier).recordExpense(myPaise);

                        Navigator.pop(context);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Split saved! ₹${myShare.toStringAsFixed(0)} personal spend, ₹${rahulShare.toStringAsFixed(0)} lent to Rahul.',
                            ),
                            backgroundColor: AppColors.primaryBlueDark,
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  disabledBackgroundColor: Colors.white12,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  elevation: 6,
                ),
                child: const Text(
                  'Confirm & Record Split Transaction',
                  style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
