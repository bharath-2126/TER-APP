import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../core/providers/app_providers.dart';
import '../domain/transaction_model.dart';
import 'split_expense_sheet.dart';

enum QuickPresetType {
  expense('1. Expense', Icons.arrow_downward, Color(0xFFEF4444)),
  income('2. Income', Icons.arrow_upward, Color(0xFF10B981)),
  splitExpense('3. ➗ Split Expense', Icons.call_split, Color(0xFF06B6D4)),
  moneyLent('4. Money Lent', Icons.handshake_outlined, Color(0xFFF59E0B)),
  moneyBorrowed('5. Money Borrowed', Icons.account_balance_wallet, Color(0xFF8B5CF6)),
  moneyReceived('6. Money Received', Icons.savings, Color(0xFF10B981)),
  moneyRepaid('7. Money Repaid', Icons.payment, Color(0xFF3B82F6)),
  transfer('8. Transfer', Icons.swap_horiz, Color(0xFF64748B));

  final String label;
  final IconData icon;
  final Color color;

  const QuickPresetType(this.label, this.icon, this.color);
}

class QuickLogSheet extends ConsumerStatefulWidget {
  final QuickPresetType initialPreset;
  const QuickLogSheet({super.key, this.initialPreset = QuickPresetType.expense});

  @override
  ConsumerState<QuickLogSheet> createState() => _QuickLogSheetState();
}

class _QuickLogSheetState extends ConsumerState<QuickLogSheet> {
  late QuickPresetType _selectedPreset;
  String _inputAmount = '0.00';
  int _currentPaise = 0;
  String _note = '';

  @override
  void initState() {
    super.initState();
    _selectedPreset = widget.initialPreset;
  }

  void _onDigitPressed(String digit) {
    if (_currentPaise.toString().length >= 8) return;
    setState(() {
      _currentPaise = (_currentPaise * 10) + int.parse(digit);
      _inputAmount = CurrencyFormatter.formatPaise(_currentPaise, symbol: '');
    });
  }

  void _onClear() {
    setState(() {
      _currentPaise = 0;
      _inputAmount = '0.00';
    });
  }

  void _onBackspace() {
    setState(() {
      _currentPaise = _currentPaise ~/ 10;
      _inputAmount = CurrencyFormatter.formatPaise(_currentPaise, symbol: '');
    });
  }

  void _onPresetSelected(QuickPresetType preset) {
    setState(() => _selectedPreset = preset);
    if (preset == QuickPresetType.splitExpense) {
      Navigator.pop(context);
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (ctx) => const SplitExpenseSheet(),
      );
    }
  }

  void _saveTransaction() {
    if (_currentPaise <= 0) return;

    final repo = ref.read(ledgerRepositoryProvider);
    final defaultAccId = repo.accounts.isNotEmpty ? repo.accounts.first.id : 'acc_hdfc';

    TransactionType txType = TransactionType.expense;
    if (_selectedPreset == QuickPresetType.income) {
      txType = TransactionType.income;
    } else if (_selectedPreset == QuickPresetType.transfer) {
      txType = TransactionType.transfer;
    } else if (_selectedPreset == QuickPresetType.moneyLent) {
      txType = TransactionType.debtLend;
    } else if (_selectedPreset == QuickPresetType.moneyBorrowed) {
      txType = TransactionType.debtBorrow;
    } else if (_selectedPreset == QuickPresetType.moneyReceived || _selectedPreset == QuickPresetType.moneyRepaid) {
      txType = TransactionType.debtRepayment;
    }

    final isExpense = txType == TransactionType.expense;

    final tx = TransactionModel(
      id: 'tx_${DateTime.now().millisecondsSinceEpoch}',
      type: txType,
      amountPaise: _currentPaise,
      fromAccountId: isExpense ? defaultAccId : null,
      toAccountId: isExpense ? null : defaultAccId,
      transactionTimestamp: DateTime.now(),
      note: _note.isNotEmpty ? _note : _selectedPreset.label,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    repo.logTransaction(tx);

    if (isExpense) {
      ref.read(dailyBudgetProvider.notifier).recordExpense(_currentPaise);
    }

    Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Recorded ${_selectedPreset.label}: ${CurrencyFormatter.formatPaise(_currentPaise)}',
        ),
        backgroundColor: AppColors.primaryBlueDark,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF0F1626),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        border: Border(top: BorderSide(color: Color(0x333B82F6), width: 1.5)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 44,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 14),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.bolt, color: AppColors.primaryBlueGlow, size: 18),
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'Quick Transaction Log',
                    style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.close, color: AppColors.textSecondary),
              ),
            ],
          ),
          const SizedBox(height: 12),

          // 8 Presets Scroller
          SizedBox(
            height: 38,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: QuickPresetType.values.length,
              separatorBuilder: (_, __) => const SizedBox(width: 8),
              itemBuilder: (context, index) {
                final preset = QuickPresetType.values[index];
                final isSelected = _selectedPreset == preset;
                return GestureDetector(
                  onTap: () => _onPresetSelected(preset),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primaryBlue : const Color(0xFF131927),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.primaryBlueGlow : Colors.white12,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(preset.icon, size: 14, color: isSelected ? Colors.white : preset.color),
                        const SizedBox(width: 6),
                        Text(
                          preset.label,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),

          // Amount Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF090D18),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const Text(
                  'Enter Amount',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 11),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹$_inputAmount',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Date auto-set to Today (Nov 08, 2026)',
                  style: TextStyle(color: AppColors.primaryBlueGlow, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),

          // Note Field
          TextField(
            onChanged: (v) => _note = v,
            style: const TextStyle(color: Colors.white, fontSize: 13),
            decoration: InputDecoration(
              hintText: 'Add note (e.g. Dinner, Petrol)',
              hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 13),
              filled: true,
              fillColor: const Color(0xFF131927),
              contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
          const SizedBox(height: 12),

          // Numpad Keypad
          _buildNumpad(),
          const SizedBox(height: 16),

          // Save Button
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _currentPaise > 0 ? _saveTransaction : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                disabledBackgroundColor: Colors.white12,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text(
                'Save Transaction (< 2s)',
                style: TextStyle(color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumpad() {
    return Column(
      children: [
        _buildNumpadRow(['1', '2', '3']),
        const SizedBox(height: 8),
        _buildNumpadRow(['4', '5', '6']),
        const SizedBox(height: 8),
        _buildNumpadRow(['7', '8', '9']),
        const SizedBox(height: 8),
        _buildNumpadRow(['CLR', '0', '⌫']),
      ],
    );
  }

  Widget _buildNumpadRow(List<String> keys) {
    return Row(
      children: keys.map((key) {
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: InkWell(
              onTap: () {
                if (key == 'CLR') {
                  _onClear();
                } else if (key == '⌫') {
                  _onBackspace();
                } else {
                  _onDigitPressed(key);
                }
              },
              borderRadius: BorderRadius.circular(12),
              child: Container(
                height: 44,
                decoration: BoxDecoration(
                  color: const Color(0xFF131927),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white10),
                ),
                alignment: Alignment.center,
                child: Text(
                  key,
                  style: TextStyle(
                    color: key == 'CLR'
                        ? Colors.amber
                        : (key == '⌫' ? AppColors.outflow : Colors.white),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'monospace',
                  ),
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
