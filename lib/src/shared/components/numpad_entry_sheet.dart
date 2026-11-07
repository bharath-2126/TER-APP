import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_typography.dart';
import '../../core/formatting/currency_formatter.dart';

class NumpadEntrySheet extends StatefulWidget {
  final String title;
  final Function(int amountPaise, String? note) onSave;

  const NumpadEntrySheet({
    super.key,
    this.title = 'Quick Expense',
    required this.onSave,
  });

  @override
  State<NumpadEntrySheet> createState() => _NumpadEntrySheetState();
}

class _NumpadEntrySheetState extends State<NumpadEntrySheet> {
  String _inputBuffer = '0';
  final TextEditingController _noteController = TextEditingController();

  void _onDigit(String digit) {
    setState(() {
      if (_inputBuffer == '0') {
        _inputBuffer = digit;
      } else if (_inputBuffer.length < 9) {
        _inputBuffer += digit;
      }
    });
  }

  void _onBackspace() {
    setState(() {
      if (_inputBuffer.length > 1) {
        _inputBuffer = _inputBuffer.substring(0, _inputBuffer.length - 1);
      } else {
        _inputBuffer = '0';
      }
    });
  }

  void _onClear() {
    setState(() {
      _inputBuffer = '0';
    });
  }

  void _submit() {
    final paise = CurrencyFormatter.parseToPaise(_inputBuffer);
    if (paise > 0) {
      widget.onSave(paise, _noteController.text.trim().isEmpty ? null : _noteController.text.trim());
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
      decoration: const BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.cardBorder,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 16),
          // Sheet Title
          Text(widget.title, style: AppTypography.cardTitle),
          const SizedBox(height: 12),
          // Active Display Amount
          Text(
            CurrencyFormatter.formatPaise(
              CurrencyFormatter.parseToPaise(_inputBuffer),
              symbol: '₹',
            ),
            style: AppTypography.heroBalance.copyWith(
              color: AppColors.textPrimary,
              fontSize: 38,
            ),
          ),
          const SizedBox(height: 16),
          // Note field
          TextField(
            controller: _noteController,
            style: const TextStyle(color: Colors.white, fontSize: 14),
            decoration: InputDecoration(
              hintText: 'Add note (optional)',
              hintStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 13),
              filled: true,
              fillColor: AppColors.cardSurface,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            ),
          ),
          const SizedBox(height: 18),
          // Keypad 4x3 Grid
          _buildKeypadGrid(),
          const SizedBox(height: 16),
          // Save Button
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _inputBuffer == '0' ? null : _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 0,
              ),
              child: const Text('Save Transaction', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildKeypadGrid() {
    final rows = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['C', '0', '⌫'],
    ];

    return Column(
      children: rows.map((row) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: row.map((key) {
              return _buildKeyButton(key);
            }).toList(),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildKeyButton(String label) {
    return GestureDetector(
      onTap: () {
        if (label == '⌫') {
          _onBackspace();
        } else if (label == 'C') {
          _onClear();
        } else {
          _onDigit(label);
        }
      },
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: 72,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: AppColors.cardSurface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: AppColors.cardBorderSubtle, width: 1),
        ),
        child: label == '⌫'
            ? const Icon(Icons.backspace_outlined, color: AppColors.textPrimary, size: 20)
            : Text(
                label,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
      ),
    );
  }
}
