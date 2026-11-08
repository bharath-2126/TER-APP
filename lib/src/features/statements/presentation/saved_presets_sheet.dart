import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../domain/statement_models.dart';
import 'statement_providers.dart';
import 'pdf_preview_screen.dart';

class SavedPresetsSheet extends ConsumerStatefulWidget {
  const SavedPresetsSheet({super.key});

  @override
  ConsumerState<SavedPresetsSheet> createState() => _SavedPresetsSheetState();
}

class _SavedPresetsSheetState extends ConsumerState<SavedPresetsSheet> {
  final TextEditingController _presetNameController = TextEditingController();

  @override
  void dispose() {
    _presetNameController.dispose();
    super.dispose();
  }

  void _applyPreset(SavedFilterPreset preset) {
    ref.read(activeStatementFilterProvider.notifier).state = preset.criteria;
    final queryService = ref.read(statementQueryServiceProvider);
    final entries = queryService.queryStatementEntries(preset.criteria);

    Navigator.pop(context);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PdfPreviewScreen(
          title: preset.name,
          periodDescription: preset.criteria.datePreset.label,
          entries: entries,
        ),
      ),
    );
  }

  void _showSavePresetDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: const Color(0xFF1E293B),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Save Current Filter Preset',
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Give this filter combination a name for 1-tap statement generation:',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _presetNameController,
              style: const TextStyle(color: Colors.white, fontSize: 14),
              decoration: InputDecoration(
                hintText: 'e.g., Weekly Grocery Spends',
                hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                filled: true,
                fillColor: const Color(0xFF0F172A),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel', style: TextStyle(color: Colors.white54)),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () {
              final name = _presetNameController.text.trim();
              if (name.isNotEmpty) {
                final currentCriteria = ref.read(activeStatementFilterProvider);
                final newPreset = SavedFilterPreset(
                  id: 'preset_${DateTime.now().millisecondsSinceEpoch}',
                  name: name,
                  description: 'Custom Filter Preset',
                  icon: Icons.star_rounded,
                  accentColor: const Color(0xFF38BDF8),
                  criteria: currentCriteria,
                );
                ref.read(statementHistoryRepositoryProvider).addPreset(newPreset);
                Navigator.pop(ctx);
                setState(() {});
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Preset "$name" saved!'),
                    backgroundColor: AppColors.inflow,
                  ),
                );
              }
            },
            child: const Text('Save Preset', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final historyRepo = ref.watch(statementHistoryRepositoryProvider);
    final presets = historyRepo.presets;

    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
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
                const SizedBox(height: 14),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        Icon(Icons.bookmarks_rounded, color: Color(0xFFF59E0B), size: 22),
                        SizedBox(width: 10),
                        Text(
                          'Saved Filter Presets',
                          style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
                        ),
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

          // List of Presets
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              itemCount: presets.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, idx) {
                final preset = presets[idx];
                return InkWell(
                  onTap: () => _applyPreset(preset),
                  borderRadius: BorderRadius.circular(16),
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: const Color(0xFF161F30),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: preset.accentColor.withOpacity(0.2)),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: preset.accentColor.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(preset.icon, color: preset.accentColor, size: 22),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                preset.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                preset.description,
                                style: const TextStyle(color: Colors.white54, fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: AppColors.primaryBlue.withOpacity(0.4)),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                'Run',
                                style: TextStyle(
                                  color: AppColors.primaryBlueGlow,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 4),
                              Icon(Icons.arrow_forward_rounded, color: AppColors.primaryBlueGlow, size: 14),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Bottom "+ Save Current Active Filter" Button
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _showSavePresetDialog,
                icon: const Icon(Icons.bookmark_add_outlined, color: AppColors.primaryBlueGlow, size: 18),
                label: const Text(
                  'Save Active Filter as Preset',
                  style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
                ),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: AppColors.primaryBlueGlow),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
