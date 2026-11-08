import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../domain/statement_models.dart';
import 'statement_providers.dart';
import 'pdf_preview_screen.dart';

class PersonStatementScreen extends ConsumerWidget {
  final String personId;

  const PersonStatementScreen({super.key, required this.personId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(personStatementSummaryProvider(personId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1626),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${summary.personName} Statement', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(
              '${summary.entries.length} Transactions • Real-Time Offline Reconciliation',
              style: const TextStyle(fontSize: 11, color: AppColors.primaryBlueGlow),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.primaryBlueGlow),
            tooltip: 'Preview PDF',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PdfPreviewScreen(
                    title: 'Counterparty Statement: ${summary.personName}',
                    periodDescription: '01 Nov 2026 - Today',
                    entries: summary.entries,
                    personSummary: summary,
                    openingBalancePaise: summary.openingOutstandingPaise,
                    closingBalancePaise: summary.closingOutstandingPaise,
                    accountOrPersonName: summary.personName,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        children: [
          // 1. Executive Balance Hero Card
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF0B251D), Color(0xFF131A2B)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppColors.inflow.withOpacity(0.35)),
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
                    const Text(
                      'CURRENT OUTSTANDING BALANCE',
                      style: TextStyle(color: Color(0xFF6EE7B7), fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: AppColors.inflow.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        summary.closingOutstandingPaise == 0 ? 'SETTLED' : 'PARTIALLY PAID',
                        style: const TextStyle(color: AppColors.inflow, fontSize: 10, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  CurrencyFormatter.formatPaise(summary.closingOutstandingPaise),
                  style: const TextStyle(
                    color: AppColors.inflow,
                    fontSize: 34,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'monospace',
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Opening: ${CurrencyFormatter.formatPaise(summary.openingOutstandingPaise)} • New Lent: +${CurrencyFormatter.formatPaise(summary.periodLentPaise)} • Repaid: -${CurrencyFormatter.formatPaise(summary.periodRepaidPaise)}',
                  style: const TextStyle(color: AppColors.textTertiary, fontSize: 10),
                ),
                const SizedBox(height: 14),
                const Divider(color: Colors.white12, height: 1),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFF080C15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('TOTAL LENT (LIFETIME)', style: TextStyle(color: AppColors.textTertiary, fontSize: 9, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            Text(
                              CurrencyFormatter.formatPaise(summary.lifetimeTotalLentPaise),
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
                          color: const Color(0xFF080C15),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.white10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text('TOTAL REPAID BY COUNTERPARTY', style: TextStyle(color: AppColors.textTertiary, fontSize: 9, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 2),
                            Text(
                              CurrencyFormatter.formatPaise(summary.lifetimeTotalRepaidPaise),
                              style: const TextStyle(color: AppColors.inflow, fontSize: 13, fontWeight: FontWeight.bold, fontFamily: 'monospace'),
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

          // 2. Section Header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'DETAILED TRANSACTION AUDIT LEDGER',
                  style: TextStyle(color: AppColors.textSecondary, fontSize: 11, fontWeight: FontWeight.bold, letterSpacing: 0.8),
                ),
                Text('${summary.entries.length} Entries', style: const TextStyle(color: AppColors.primaryBlueGlow, fontSize: 11, fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // 3. Transactions Table
          if (summary.entries.isEmpty)
            Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: const Color(0xFF131927),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Center(
                child: Text('No transaction history found for this person in the period', style: TextStyle(color: AppColors.textTertiary, fontSize: 13)),
              ),
            )
          else
            ...summary.entries.map((e) {
              final isRepay = e.isInflow;
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
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: (isRepay ? AppColors.inflow : (e.splitGroupId != null ? const Color(0xFF06B6D4) : const Color(0xFFF59E0B))).withOpacity(0.18),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isRepay ? Icons.arrow_downward : (e.splitGroupId != null ? Icons.call_split_rounded : Icons.handshake_outlined),
                        color: isRepay ? AppColors.inflow : (e.splitGroupId != null ? const Color(0xFF38BDF8) : const Color(0xFFF59E0B)),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            e.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            '${_formatDate(e.timestamp)} • ${e.typeName}',
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
                          '${isRepay ? '-' : '+'}${CurrencyFormatter.formatPaise(e.amountPaise)}',
                          style: TextStyle(
                            color: isRepay ? AppColors.inflow : const Color(0xFFF59E0B),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'monospace',
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'Due: ${CurrencyFormatter.formatPaise(e.runningBalancePaise)}',
                          style: const TextStyle(color: AppColors.textTertiary, fontSize: 10, fontFamily: 'monospace'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            }),

          const SizedBox(height: 20),

          // Bottom Action
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PdfPreviewScreen(
                      title: 'Counterparty Statement: ${summary.personName}',
                      periodDescription: '01 Nov 2026 - Today',
                      entries: summary.entries,
                      personSummary: summary,
                      openingBalancePaise: summary.openingOutstandingPaise,
                      closingBalancePaise: summary.closingOutstandingPaise,
                      accountOrPersonName: summary.personName,
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.picture_as_pdf_rounded, color: Colors.white),
              label: const Text('Generate Official PDF Statement', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                elevation: 6,
              ),
            ),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}
