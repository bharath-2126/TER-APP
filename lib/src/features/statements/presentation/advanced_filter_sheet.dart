import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/providers/app_providers.dart';
import '../domain/statement_models.dart';
import 'statement_providers.dart';
import 'pdf_preview_screen.dart';

class AdvancedFilterSheet extends ConsumerStatefulWidget {
  const AdvancedFilterSheet({super.key});

  @override
  ConsumerState<AdvancedFilterSheet> createState() => _AdvancedFilterSheetState();
}

class _AdvancedFilterSheetState extends ConsumerState<AdvancedFilterSheet> {
  late StatementFilterCriteria _criteria;
  final TextEditingController _minAmountController = TextEditingController();
  final TextEditingController _maxAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _criteria = ref.read(activeStatementFilterProvider);
    if (_criteria.minAmountPaise != null) {
      _minAmountController.text = '${_criteria.minAmountPaise! ~/ 100}';
    }
    if (_criteria.maxAmountPaise != null) {
      _maxAmountController.text = '${_criteria.maxAmountPaise! ~/ 100}';
    }
  }

  void _applyAndGenerate() {
    int? minPaise;
    int? maxPaise;
    final minVal = int.tryParse(_minAmountController.text.trim());
    if (minVal != null) minPaise = minVal * 100;
    final maxVal = int.tryParse(_maxAmountController.text.trim());
    if (maxVal != null) maxPaise = maxVal * 100;

    final updated = _criteria.copyWith(
      minAmountPaise: minPaise,
      maxAmountPaise: maxPaise,
    );

    ref.read(activeStatementFilterProvider.notifier).state = updated;
    final queryService = ref.read(statementQueryServiceProvider);
    final entries = queryService.queryStatementEntries(updated);

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(
          title: 'Custom Filtered Statement',
          periodDescription: updated.datePreset.label,
          entries: entries,
        ),
      ),
    );
  }

  void _resetFilters() {
    setState(() {
      _criteria = const StatementFilterCriteria();
      _minAmountController.clear();
      _maxAmountController.clear();
    });
    ref.read(activeStatementFilterProvider.notifier).state = _criteria;
  }

  @override
  Widget build(BuildContext context) {
    final queryService = ref.watch(statementQueryServiceProvider);
    final personsAsync = ref.watch(personsStreamProvider);
    final persons = (personsAsync.value != null && personsAsync.value!.isNotEmpty)
        ? personsAsync.value!
        : ref.watch(ledgerRepositoryProvider).persons;
    final accountsAsync = ref.watch(accountsStreamProvider);
    final accounts = (accountsAsync.value != null && accountsAsync.value!.isNotEmpty)
        ? accountsAsync.value!
        : ref.watch(ledgerRepositoryProvider).accounts;
    final previewEntries = queryService.queryStatementEntries(_criteria);

    return Container(
      height: MediaQuery.of(context).size.height * 0.88,
      decoration: const BoxDecoration(
        color: Color(0xFF0F1626),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Drag handle & Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 14),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.white12)),
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.white24,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Custom Statement Filters', style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
                        Text('${previewEntries.length} Matching Transactions Found', style: const TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11)),
                      ],
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Scrollable filter controls
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              children: [
                // 1. DATE PRESET
                _buildSectionHeader('1. Date Range Preset'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: StatementDatePreset.values.map((preset) {
                    final selected = _criteria.datePreset == preset;
                    return ChoiceChip(
                      label: Text(preset.label),
                      selected: selected,
                      selectedColor: AppColors.primaryBlue,
                      backgroundColor: const Color(0xFF131927),
                      labelStyle: TextStyle(
                        color: selected ? Colors.white : AppColors.textSecondary,
                        fontSize: 12,
                        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                      ),
                      onSelected: (val) {
                        if (val) setState(() => _criteria = _criteria.copyWith(datePreset: preset));
                      },
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // 2. TRANSACTION TYPES (MULTI-SELECT)
                _buildSectionHeader('2. Transaction Type (Multi-Select)'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _buildTypeChip('Split Expense', 'splitExpense'),
                    _buildTypeChip('Direct Expense', 'expense'),
                    _buildTypeChip('Income Inflow', 'income'),
                    _buildTypeChip('Money Lent', 'debtLend'),
                    _buildTypeChip('Money Repaid', 'debtRepayment'),
                    _buildTypeChip('Money Borrowed', 'debtBorrow'),
                    _buildTypeChip('Transfer', 'transfer'),
                  ],
                ),
                const SizedBox(height: 20),

                // 3. PERSON / COUNTERPARTY
                _buildSectionHeader('3. Filter By Counterparty'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('All Persons'),
                      selected: _criteria.personId == null || _criteria.personId == 'all',
                      selectedColor: AppColors.primaryBlue,
                      backgroundColor: const Color(0xFF131927),
                      labelStyle: TextStyle(
                        color: (_criteria.personId == null || _criteria.personId == 'all') ? Colors.white : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      onSelected: (val) => setState(() => _criteria = _criteria.copyWith(personId: 'all')),
                    ),
                    ...persons.map((p) {
                      final selected = _criteria.personId == p.id;
                      return ChoiceChip(
                        label: Text('${p.name} (₹${p.outstandingBalancePaise ~/ 100})'),
                        selected: selected,
                        selectedColor: const Color(0xFF10B981),
                        backgroundColor: const Color(0xFF131927),
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (val) => setState(() => _criteria = _criteria.copyWith(personId: val ? p.id : 'all')),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),

                // 4. ACCOUNT / CARD
                _buildSectionHeader('4. Bank Account & Cards'),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ChoiceChip(
                      label: const Text('All Accounts'),
                      selected: _criteria.accountId == null || _criteria.accountId == 'all',
                      selectedColor: AppColors.primaryBlue,
                      backgroundColor: const Color(0xFF131927),
                      labelStyle: TextStyle(
                        color: (_criteria.accountId == null || _criteria.accountId == 'all') ? Colors.white : AppColors.textSecondary,
                        fontSize: 12,
                      ),
                      onSelected: (val) => setState(() => _criteria = _criteria.copyWith(accountId: 'all')),
                    ),
                    ...accounts.map((a) {
                      final selected = _criteria.accountId == a.id;
                      return ChoiceChip(
                        label: Text(a.name),
                        selected: selected,
                        selectedColor: const Color(0xFF06B6D4),
                        backgroundColor: const Color(0xFF131927),
                        labelStyle: TextStyle(
                          color: selected ? Colors.white : AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                        ),
                        onSelected: (val) => setState(() => _criteria = _criteria.copyWith(accountId: val ? a.id : 'all')),
                      );
                    }),
                  ],
                ),
                const SizedBox(height: 20),

                // 5. AMOUNT BOUNDARIES
                _buildSectionHeader('5. Amount Range (₹)'),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _minAmountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
                        decoration: InputDecoration(
                          labelText: 'Min Amount (₹)',
                          labelStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 12),
                          filled: true,
                          fillColor: const Color(0xFF131927),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: TextField(
                        controller: _maxAmountController,
                        keyboardType: TextInputType.number,
                        style: const TextStyle(color: Colors.white, fontFamily: 'monospace'),
                        decoration: InputDecoration(
                          labelText: 'Max Amount (₹)',
                          labelStyle: const TextStyle(color: AppColors.textTertiary, fontSize: 12),
                          filled: true,
                          fillColor: const Color(0xFF131927),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                        ),
                        onChanged: (_) => setState(() {}),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),

          // Bottom Action Footer
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Colors.white12)),
              color: Color(0xFF0F1626),
            ),
            child: Row(
              children: [
                OutlinedButton(
                  onPressed: _resetFilters,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Colors.white70,
                    side: const BorderSide(color: Colors.white24),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('Reset'),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyAndGenerate,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryBlue,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      elevation: 6,
                    ),
                    child: Text(
                      'Generate Statement (${previewEntries.length})',
                      style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(color: AppColors.textTertiary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
      ),
    );
  }

  Widget _buildTypeChip(String label, String typeKey) {
    final selected = _criteria.transactionTypes.contains(typeKey);
    return FilterChip(
      label: Text(label),
      selected: selected,
      selectedColor: AppColors.primaryBlue,
      backgroundColor: const Color(0xFF131927),
      labelStyle: TextStyle(
        color: selected ? Colors.white : AppColors.textSecondary,
        fontSize: 12,
        fontWeight: selected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (val) {
        setState(() {
          final types = Set<String>.from(_criteria.transactionTypes);
          if (val) {
            types.add(typeKey);
          } else {
            types.remove(typeKey);
          }
          _criteria = _criteria.copyWith(transactionTypes: types);
        });
      },
    );
  }
}
