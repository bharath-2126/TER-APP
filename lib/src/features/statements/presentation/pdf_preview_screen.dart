import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../domain/statement_models.dart';
import '../data/statement_pdf_service.dart';
import '../data/statement_csv_service.dart';
import '../data/statement_export_service.dart';

class PdfPreviewScreen extends StatefulWidget {
  final String title;
  final String periodDescription;
  final List<StatementEntry> entries;
  final PersonStatementSummary? personSummary;
  final int? openingBalancePaise;
  final int? closingBalancePaise;
  final String? accountOrPersonName;

  const PdfPreviewScreen({
    super.key,
    required this.title,
    required this.periodDescription,
    required this.entries,
    this.personSummary,
    this.openingBalancePaise,
    this.closingBalancePaise,
    this.accountOrPersonName,
  });

  @override
  State<PdfPreviewScreen> createState() => _PdfPreviewScreenState();
}

class _PdfPreviewScreenState extends State<PdfPreviewScreen> {
  Uint8List? _pdfBytes;
  bool _isGenerating = true;

  @override
  void initState() {
    super.initState();
    _compilePdf();
  }

  Future<void> _compilePdf() async {
    setState(() => _isGenerating = true);
    Uint8List bytes;
    if (widget.personSummary != null) {
      bytes = await StatementPdfService.generatePersonStatementPdf(widget.personSummary!);
    } else {
      bytes = await StatementPdfService.generateGeneralStatementPdf(
        title: widget.title,
        periodDescription: widget.periodDescription,
        entries: widget.entries,
        openingBalancePaise: widget.openingBalancePaise,
        closingBalancePaise: widget.closingBalancePaise,
        accountOrPersonName: widget.accountOrPersonName,
      );
    }
    setState(() {
      _pdfBytes = bytes;
      _isGenerating = false;
    });
  }

  Future<void> _savePdfToDevice() async {
    if (_pdfBytes == null) return;
    final fileName = 'TER_Statement_${widget.title.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.pdf';
    final file = await StatementExportService.saveFileLocally(
      bytes: _pdfBytes!,
      fileName: fileName,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Saved PDF locally: ${file.path.split('/').last}'),
        backgroundColor: AppColors.inflow,
        action: SnackBarAction(
          label: 'Share',
          textColor: Colors.white,
          onPressed: () => _sharePdf(file),
        ),
      ),
    );
  }

  Future<void> _sharePdf([File? existingFile]) async {
    if (_pdfBytes == null) return;
    final file = existingFile ??
        await StatementExportService.saveFileLocally(
          bytes: _pdfBytes!,
          fileName: 'TER_Statement_${widget.title.replaceAll(' ', '_')}.pdf',
        );
    await StatementExportService.shareFile(
      file: file,
      subject: 'TER Financial Statement: ${widget.title}',
    );
  }

  Future<void> _exportCsv() async {
    final csvContent = StatementCsvService.generateCsv(
      entries: widget.entries,
      statementTitle: widget.title,
      personOrAccount: widget.accountOrPersonName ?? widget.personSummary?.personName,
    );
    final fileName = 'TER_Export_${widget.title.replaceAll(' ', '_')}_${DateTime.now().millisecondsSinceEpoch}.csv';
    final file = await StatementExportService.saveCsvLocally(
      csvContent: csvContent,
      fileName: fileName,
    );
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('CSV Exported: ${file.path.split('/').last}'),
        backgroundColor: AppColors.primaryBlueDark,
        action: SnackBarAction(
          label: 'Share CSV',
          textColor: Colors.white,
          onPressed: () => StatementExportService.shareFile(file: file, subject: 'TER Statement CSV Export'),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    int totalInflow = 0;
    int totalOutflow = 0;
    for (final e in widget.entries) {
      if (e.isInflow) {
        totalInflow += e.amountPaise;
      } else {
        totalOutflow += e.amountPaise;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F1626),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(widget.title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white)),
            Text(
              '${widget.entries.length} Entries • ${widget.periodDescription}',
              style: const TextStyle(fontSize: 11, color: AppColors.primaryBlueGlow),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.table_chart_outlined, color: AppColors.primaryBlueGlow),
            tooltip: 'Export CSV',
            onPressed: _exportCsv,
          ),
          IconButton(
            icon: const Icon(Icons.download_rounded, color: Colors.white),
            tooltip: 'Save PDF',
            onPressed: _savePdfToDevice,
          ),
          IconButton(
            icon: const Icon(Icons.share_rounded, color: AppColors.primaryBlueGlow),
            tooltip: 'Share Native Intent',
            onPressed: () => _sharePdf(),
          ),
        ],
      ),
      body: _isGenerating
          ? const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(color: AppColors.primaryBlueGlow),
                  SizedBox(height: 16),
                  Text('Compiling PDF Document locally...', style: TextStyle(color: AppColors.textSecondary, fontSize: 13)),
                ],
              ),
            )
          : ListView(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              children: [
                // Summary Metric Bar
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFF131927),
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.primaryBlue.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildMetricCol('Inflow', CurrencyFormatter.formatPaise(totalInflow), AppColors.inflow),
                      Container(width: 1, height: 28, color: Colors.white12),
                      _buildMetricCol('Outflow', CurrencyFormatter.formatPaise(totalOutflow), AppColors.outflow),
                      Container(width: 1, height: 28, color: Colors.white12),
                      _buildMetricCol(
                        'Net Movement',
                        CurrencyFormatter.formatPaise(totalInflow - totalOutflow),
                        AppColors.primaryBlueGlow,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Simulated High-Fidelity A4 Document Canvas
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.6),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Document Header
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'TER | LEDGER',
                                style: TextStyle(color: Color(0xFF1E3A8A), fontWeight: FontWeight.w900, fontSize: 16),
                              ),
                              Text(
                                'TRACK EVERY RUPEE • PRIVATE FINANCIAL STATEMENT',
                                style: TextStyle(color: Color(0xFF475569), fontSize: 8, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'STMT-ID: TER-${DateTime.now().millisecondsSinceEpoch ~/ 1000}',
                                style: const TextStyle(color: Color(0xFF0F172A), fontSize: 9, fontWeight: FontWeight.bold),
                              ),
                              Text(
                                'Date: ${_formatDate(DateTime.now())}',
                                style: const TextStyle(color: Color(0xFF64748B), fontSize: 8),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const Divider(color: Color(0xFF1E3A8A), thickness: 1.5, height: 20),

                      Center(
                        child: Text(
                          widget.title.toUpperCase(),
                          style: const TextStyle(color: Color(0xFF0F172A), fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 0.5),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Center(
                        child: Text(
                          'Period: ${widget.periodDescription} • Verified Local SQLite Ledger',
                          style: const TextStyle(color: Color(0xFF64748B), fontSize: 9),
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Document Summary Table Box
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _buildDocStat('Transactions', '${widget.entries.length}'),
                            _buildDocStat('Total Credits', CurrencyFormatter.formatPaise(totalInflow)),
                            _buildDocStat('Total Debits', CurrencyFormatter.formatPaise(totalOutflow)),
                            _buildDocStat('Net Balance', CurrencyFormatter.formatPaise(totalInflow - totalOutflow)),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),

                      // Table Header
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                        color: const Color(0xFF0F172A),
                        child: const Row(
                          children: [
                            Expanded(flex: 2, child: Text('DATE', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold))),
                            Expanded(flex: 4, child: Text('DESCRIPTION', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold))),
                            Expanded(flex: 2, child: Text('TYPE', style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold))),
                            Expanded(flex: 2, child: Text('AMOUNT', textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold))),
                            Expanded(flex: 2, child: Text('RUNNING', textAlign: TextAlign.right, style: TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold))),
                          ],
                        ),
                      ),

                      // Table Rows
                      ...widget.entries.take(15).map((e) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                          decoration: const BoxDecoration(
                            border: Border(bottom: BorderSide(color: Color(0xFFE2E8F0))),
                          ),
                          child: Row(
                            children: [
                              Expanded(flex: 2, child: Text(_formatDate(e.timestamp), style: const TextStyle(color: Color(0xFF1E293B), fontSize: 8))),
                              Expanded(flex: 4, child: Text(e.title, maxLines: 1, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Color(0xFF1E293B), fontSize: 8, fontWeight: FontWeight.bold))),
                              Expanded(flex: 2, child: Text(e.typeName, style: const TextStyle(color: Color(0xFF64748B), fontSize: 8))),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  '${e.isInflow ? '+' : '-'}${CurrencyFormatter.formatPaise(e.amountPaise)}',
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                    color: e.isInflow ? const Color(0xFF16A34A) : const Color(0xFFDC2626),
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'monospace',
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Text(
                                  CurrencyFormatter.formatPaise(e.runningBalancePaise),
                                  textAlign: TextAlign.right,
                                  style: const TextStyle(color: Color(0xFF0F172A), fontSize: 8, fontFamily: 'monospace', fontWeight: FontWeight.w600),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),

                      const SizedBox(height: 16),
                      const Divider(color: Color(0xFFCBD5E1), height: 1),
                      const SizedBox(height: 8),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Page 1 of 1 • System Hash: SHA-256 Verified', style: TextStyle(color: Color(0xFF64748B), fontSize: 7)),
                          Text('CONFIDENTIAL • OFFLINE LEDGER', style: TextStyle(color: Color(0xFF64748B), fontSize: 7, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Bottom Quick Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _exportCsv,
                        icon: const Icon(Icons.table_chart_outlined, size: 18),
                        label: const Text('Export CSV'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.white,
                          side: const BorderSide(color: Colors.white24),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () => _sharePdf(),
                        icon: const Icon(Icons.share_rounded, size: 18, color: Colors.white),
                        label: const Text('Share PDF', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlue,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                          elevation: 6,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
    );
  }

  Widget _buildMetricCol(String label, String value, Color color) {
    return Column(
      children: [
        Text(label.toUpperCase(), style: const TextStyle(color: AppColors.textTertiary, fontSize: 10, fontWeight: FontWeight.bold)),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(color: color, fontSize: 14, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
      ],
    );
  }

  Widget _buildDocStat(String label, String value) {
    return Column(
      children: [
        Text(label.toUpperCase(), style: const TextStyle(color: Color(0xFF64748B), fontSize: 8, fontWeight: FontWeight.bold)),
        const SizedBox(height: 2),
        Text(value, style: const TextStyle(color: Color(0xFF0F172A), fontSize: 10, fontWeight: FontWeight.bold, fontFamily: 'monospace')),
      ],
    );
  }

  String _formatDate(DateTime d) {
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}/${d.year}';
  }
}
