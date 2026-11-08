import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../domain/statement_models.dart';
import 'statement_providers.dart';
import 'person_statement_screen.dart';
import 'pdf_preview_screen.dart';
import '../data/statement_csv_service.dart';
import '../data/statement_export_service.dart';

class OutstandingBalanceScreen extends ConsumerStatefulWidget {
  const OutstandingBalanceScreen({super.key});

  @override
  ConsumerState<OutstandingBalanceScreen> createState() => _OutstandingBalanceScreenState();
}

class _OutstandingBalanceScreenState extends ConsumerState<OutstandingBalanceScreen> {
  String _selectedFilter = 'all'; // 'all', 'receivables', 'payables', 'settled'
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _exportCsv(OutstandingBalanceSummary summary) async {
    // Generate entries for CSV
    final entries = summary.personBalances.map((item) {
      return StatementEntry(
        transactionId: 'BAL_${item.personId}',
        timestamp: DateTime.now(),
        title: item.name,
        categoryName: item.isReceivable ? 'Receivable (Asset)' : 'Payable (Liability)',
        personName: item.name,
        typeName: item.isReceivable ? 'Receivable' : 'Payable',
        amountPaise: item.outstandingPaise,
        isInflow: !item.isReceivable,
        runningBalancePaise: item.outstandingPaise,
        notes: item.status,
      );
    }).toList();

    final csvContent = StatementCsvService.generateGeneralStatementCsv(
      title: 'Macro Outstanding Balance Report',
      periodDescription: 'As of ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
      entries: entries,
    );

    final fileName = 'TER_Outstanding_Balance_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = await StatementExportService.saveCsvLocally(
      csvContent: csvContent,
      fileName: fileName,
    );

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved CSV: ${file.path.split('/').last}'),
        backgroundColor: AppColors.inflow,
        action: SnackBarAction(
          label: 'Share',
          textColor: Colors.white,
          onPressed: () => StatementExportService.shareFile(
            file: file,
            subject: 'Macro Outstanding Balance Report - TER App',
          ),
        ),
      ),
    );
  }

  void _openPdfPreview(OutstandingBalanceSummary summary) {
    final entries = summary.personBalances.map((item) {
      return StatementEntry(
        transactionId: 'BAL_${item.personId}',
        timestamp: DateTime.now(),
        title: item.name,
        categoryName: item.isReceivable ? 'Receivable (Asset)' : 'Payable (Liability)',
        personName: item.name,
        typeName: item.isReceivable ? 'Receivable' : 'Payable',
        amountPaise: item.outstandingPaise,
        isInflow: !item.isReceivable,
        runningBalancePaise: item.outstandingPaise,
        notes: item.status,
      );
    }).toList();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(
          title: 'Macro Outstanding Balance Report',
          periodDescription: 'As of ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}',
          entries: entries,
          openingBalancePaise: summary.totalReceivablesPaise,
          closingBalancePaise: summary.netPositionPaise,
          accountOrPersonName: 'Receivables ₹${summary.totalReceivablesPaise ~/ 100} | Payables ₹${summary.totalPayablesPaise ~/ 100}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final summary = ref.watch(outstandingBalanceSummaryProvider);

    final filteredList = summary.personBalances.where((item) {
      if (_searchQuery.isNotEmpty) {
        final matchesQuery = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
            (item.phone ?? '').contains(_searchQuery);
        if (!matchesQuery) return false;
      }

      switch (_selectedFilter) {
        case 'receivables':
          return item.isReceivable && item.outstandingPaise > 0;
        case 'payables':
          return !item.isReceivable && item.outstandingPaise > 0;
        case 'settled':
          return item.outstandingPaise == 0;
        default:
          return true;
      }
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
              'Outstanding Balance Report',
              style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Macro Receivables vs Payables Audit',
              style: TextStyle(color: Colors.white54, fontSize: 11),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.table_chart_outlined, color: AppColors.primaryBlueGlow),
            tooltip: 'Export CSV',
            onPressed: () => _exportCsv(summary),
          ),
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded, color: Color(0xFFF59E0B)),
            tooltip: 'Preview PDF',
            onPressed: () => _openPdfPreview(summary),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        children: [
          // Macro Balance Sheet Card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1E293B), Color(0xFF0F172A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.3),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.balance_rounded, color: Color(0xFFF59E0B), size: 18),
                        SizedBox(width: 8),
                        Text(
                          'NET BALANCE POSITION',
                          style: TextStyle(
                            color: Colors.white70,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.0,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: summary.netPositionPaise >= 0
                            ? const Color(0xFF10B981).withOpacity(0.15)
                            : const Color(0xFFEF4444).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        summary.netPositionPaise >= 0 ? '+ NET ASSET' : '- NET LIABILITY',
                        style: TextStyle(
                          color: summary.netPositionPaise >= 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  CurrencyFormatter.formatPaise(summary.netPositionPaise.abs()),
                  style: TextStyle(
                    color: summary.netPositionPaise >= 0 ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                const SizedBox(height: 14),
                const Divider(color: Colors.white10),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFF10B981).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFF10B981).withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.arrow_downward_rounded, color: Color(0xFF10B981), size: 14),
                                SizedBox(width: 4),
                                Text(
                                  'RECEIVABLES',
                                  style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              CurrencyFormatter.formatPaise(summary.totalReceivablesPaise),
                              style: const TextStyle(
                                color: Color(0xFF10B981),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Money others owe you',
                              style: TextStyle(color: Colors.white38, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEF4444).withOpacity(0.08),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: const Color(0xFFEF4444).withOpacity(0.2)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.arrow_upward_rounded, color: Color(0xFFEF4444), size: 14),
                                SizedBox(width: 4),
                                Text(
                                  'PAYABLES',
                                  style: TextStyle(color: Colors.white60, fontSize: 10, fontWeight: FontWeight.w600),
                                ),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Text(
                              CurrencyFormatter.formatPaise(summary.totalPayablesPaise),
                              style: const TextStyle(
                                color: Color(0xFFEF4444),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 2),
                            const Text(
                              'Money you owe others',
                              style: TextStyle(color: Colors.white38, fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Search and Filters
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                  decoration: InputDecoration(
                    hintText: 'Search person...',
                    hintStyle: const TextStyle(color: Colors.white38, fontSize: 12),
                    prefixIcon: const Icon(Icons.search, color: Colors.white38, size: 16),
                    filled: true,
                    fillColor: const Color(0xFF161F30),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  onChanged: (val) => setState(() => _searchQuery = val),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Filter Chips
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip('All (${summary.personBalances.length})', 'all'),
                const SizedBox(width: 8),
                _buildFilterChip('Receivables', 'receivables'),
                const SizedBox(width: 8),
                _buildFilterChip('Payables', 'payables'),
                const SizedBox(width: 8),
                _buildFilterChip('Settled', 'settled'),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Person List Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'COUNTERPARTIES (${filteredList.length})',
                style: const TextStyle(
                  color: Colors.white60,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.8,
                ),
              ),
              const Text(
                'Tap to view ledger',
                style: TextStyle(color: Colors.white38, fontSize: 11),
              ),
            ],
          ),

          const SizedBox(height: 10),

          // Person Cards List
          if (filteredList.isEmpty)
            Container(
              padding: const EdgeInsets.symmetric(vertical: 40),
              alignment: Alignment.center,
              child: const Column(
                children: [
                  Icon(Icons.check_circle_outline_rounded, color: Colors.white24, size: 40),
                  SizedBox(height: 10),
                  Text(
                    'No counterparties found in this view',
                    style: TextStyle(color: Colors.white38, fontSize: 13),
                  ),
                ],
              ),
            )
          else
            ...filteredList.map((item) {
              final isSettled = item.outstandingPaise == 0;
              return Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFF161F30),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: isSettled
                        ? Colors.white10
                        : (item.isReceivable
                            ? const Color(0xFF10B981).withOpacity(0.2)
                            : const Color(0xFFEF4444).withOpacity(0.2)),
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  leading: CircleAvatar(
                    radius: 20,
                    backgroundColor: isSettled
                        ? Colors.white12
                        : (item.isReceivable
                            ? const Color(0xFF10B981).withOpacity(0.15)
                            : const Color(0xFFEF4444).withOpacity(0.15)),
                    child: Text(
                      item.name.isNotEmpty ? item.name[0].toUpperCase() : '?',
                      style: TextStyle(
                        color: isSettled
                            ? Colors.white60
                            : (item.isReceivable ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                  title: Text(
                    item.name,
                    style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                  ),
                  subtitle: Text(
                    item.phone ?? 'Verified Counterparty',
                    style: const TextStyle(color: Colors.white38, fontSize: 11),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            isSettled ? '₹0.00' : CurrencyFormatter.formatPaise(item.outstandingPaise),
                            style: TextStyle(
                              color: isSettled
                                  ? Colors.white54
                                  : (item.isReceivable ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            isSettled ? 'Settled' : (item.isReceivable ? 'Owes you' : 'You owe'),
                            style: TextStyle(
                              color: isSettled
                                  ? Colors.white38
                                  : (item.isReceivable
                                      ? const Color(0xFF10B981).withOpacity(0.8)
                                      : const Color(0xFFEF4444).withOpacity(0.8)),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 6),
                      const Icon(Icons.chevron_right_rounded, color: Colors.white24, size: 20),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PersonStatementScreen(personId: item.personId),
                      ),
                    );
                  },
                ),
              );
            }),
        ],
      ),
    );
  }

  Widget _buildFilterChip(String label, String value) {
    final isSelected = _selectedFilter == value;
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
      onSelected: (_) => setState(() => _selectedFilter = value),
    );
  }
}
