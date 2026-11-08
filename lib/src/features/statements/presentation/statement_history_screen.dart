import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../domain/statement_models.dart';
import 'statement_providers.dart';
import '../data/statement_export_service.dart';

class StatementHistoryScreen extends ConsumerStatefulWidget {
  const StatementHistoryScreen({super.key});

  @override
  ConsumerState<StatementHistoryScreen> createState() => _StatementHistoryScreenState();
}

class _StatementHistoryScreenState extends ConsumerState<StatementHistoryScreen> {
  String _selectedFormat = 'All'; // 'All', 'PDF', 'CSV'

  @override
  Widget build(BuildContext context) {
    final historyRepo = ref.watch(statementHistoryRepositoryProvider);
    final historyList = historyRepo.history;

    final filtered = historyList.where((item) {
      if (_selectedFormat == 'All') return true;
      return item.format.toUpperCase() == _selectedFormat.toUpperCase();
    }).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0D1422),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Statement History Archive',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Audit log of previously generated statements',
              style: TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Filter Chips
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
            child: Row(
              children: [
                _buildFormatChip('All (${historyList.length})', 'All'),
                const SizedBox(width: 8),
                _buildFormatChip('PDF Statements', 'PDF'),
                const SizedBox(width: 8),
                _buildFormatChip('CSV Data Files', 'CSV'),
              ],
            ),
          ),

          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.history_toggle_off_rounded, color: Colors.white24, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          'No statement history found for $_selectedFormat',
                          style: const TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, idx) {
                      final item = filtered[idx];
                      final isPdf = item.format.toUpperCase() == 'PDF';

                      return Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: const Color(0xFF161F30),
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isPdf
                                ? const Color(0xFFEF4444).withOpacity(0.2)
                                : const Color(0xFF10B981).withOpacity(0.2),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: isPdf
                                        ? const Color(0xFFEF4444).withOpacity(0.15)
                                        : const Color(0xFF10B981).withOpacity(0.15),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Icon(
                                    isPdf ? Icons.picture_as_pdf_rounded : Icons.table_chart_rounded,
                                    color: isPdf ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        item.title,
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 3),
                                      Text(
                                        item.filterSummary,
                                        style: const TextStyle(color: Colors.white54, fontSize: 11),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        'Period: ${item.periodDescription}',
                                        style: const TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                                  decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    item.format,
                                    style: TextStyle(
                                      color: isPdf ? const Color(0xFFEF4444) : const Color(0xFF10B981),
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            const Divider(color: Colors.white10, height: 1),
                            const SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '${item.recordCount} rows • ${CurrencyFormatter.formatPaise(item.totalAmountPaise)}',
                                  style: const TextStyle(color: Colors.white70, fontSize: 12, fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: const Icon(Icons.share_outlined, color: AppColors.primaryBlueGlow, size: 18),
                                      tooltip: 'Share',
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('Sharing ${item.title}...'),
                                            backgroundColor: AppColors.primaryBlueDark,
                                          ),
                                        );
                                      },
                                    ),
                                    const SizedBox(width: 14),
                                    Text(
                                      _formatTimeAgo(item.generatedAt),
                                      style: const TextStyle(color: Colors.white38, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  String _formatTimeAgo(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) {
      return '${diff.inMinutes}m ago';
    } else if (diff.inHours < 24) {
      return '${diff.inHours}h ago';
    } else {
      return '${diff.inDays}d ago';
    }
  }

  Widget _buildFormatChip(String label, String value) {
    final isSelected = _selectedFormat == value;
    return ChoiceChip(
      label: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white60,
          fontSize: 12,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedColor: AppColors.primaryBlue,
      backgroundColor: const Color(0xFF161F30),
      side: BorderSide(
        color: isSelected ? AppColors.primaryBlueGlow : Colors.white12,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onSelected: (_) => setState(() => _selectedFormat = value),
    );
  }
}
