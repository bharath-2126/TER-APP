import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../core/providers/app_providers.dart';
import 'person_statement_screen.dart';

/// Searchable Counterparty Selector Sheet
/// Allows user to pick a contact to generate their detailed financial statement.
class PersonSelectorSheet extends ConsumerStatefulWidget {
  const PersonSelectorSheet({super.key});

  @override
  ConsumerState<PersonSelectorSheet> createState() => _PersonSelectorSheetState();
}

class _PersonSelectorSheetState extends ConsumerState<PersonSelectorSheet> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final personsAsync = ref.watch(personsStreamProvider);
    final persons = (personsAsync.value != null && personsAsync.value!.isNotEmpty)
        ? personsAsync.value!
        : ref.watch(ledgerRepositoryProvider).persons;

    final filtered = persons.where((p) {
      if (_searchQuery.isEmpty) return true;
      return p.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          (p.phone ?? '').contains(_searchQuery);
    }).toList();

    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Color(0xFF0F1626),
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: Column(
        children: [
          // Drag handle & Header
          Container(
            padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
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
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFF10B981).withOpacity(0.15),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.person_search_rounded,
                        color: Color(0xFF10B981),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Counterparty',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            'Generate person-wise audit ledger & closing balance',
                            style: TextStyle(color: Colors.white54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.white70),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 14),
                // Search bar
                TextField(
                  controller: _searchController,
                  style: const TextStyle(color: Colors.white, fontSize: 14),
                  decoration: InputDecoration(
                    hintText: 'Search person by name or phone...',
                    hintStyle: const TextStyle(color: Colors.white38, fontSize: 13),
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryBlueGlow, size: 18),
                    suffixIcon: _searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, color: Colors.white38, size: 16),
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _searchQuery = '');
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFF1A2234),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.white12),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: Colors.white12),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                      borderSide: const BorderSide(color: AppColors.primaryBlue),
                    ),
                  ),
                  onChanged: (val) {
                    setState(() => _searchQuery = val);
                  },
                ),
              ],
            ),
          ),

          // Contact List
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.person_off_rounded, color: Colors.white24, size: 48),
                        const SizedBox(height: 12),
                        Text(
                          _searchQuery.isEmpty ? 'No counterparties found' : 'No matching results for "$_searchQuery"',
                          style: const TextStyle(color: Colors.white54, fontSize: 14),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, idx) {
                      final person = filtered[idx];
                      final balance = person.outstandingBalancePaise;
                      final isReceivable = balance > 0;
                      final isPayable = balance < 0;
                      final isSettled = balance == 0;

                      return InkWell(
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PersonStatementScreen(personId: person.id),
                            ),
                          );
                        },
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: const Color(0xFF161F30),
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: isSettled ? Colors.white10 : const Color(0xFF10B981).withOpacity(0.2),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 22,
                                backgroundColor: isSettled
                                    ? Colors.white12
                                    : (isReceivable
                                        ? const Color(0xFF10B981).withOpacity(0.2)
                                        : const Color(0xFFEF4444).withOpacity(0.2)),
                                child: Text(
                                  person.name.isNotEmpty ? person.name[0].toUpperCase() : '?',
                                  style: TextStyle(
                                    color: isSettled
                                        ? Colors.white70
                                        : (isReceivable ? const Color(0xFF10B981) : const Color(0xFFEF4444)),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      person.name,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 2),
                                    Text(
                                      person.phone ?? 'Verified Contact',
                                      style: const TextStyle(
                                        color: Colors.white38,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Text(
                                    isSettled
                                        ? 'Settled'
                                        : CurrencyFormatter.formatPaise(balance.abs()),
                                    style: TextStyle(
                                      color: isSettled
                                          ? Colors.white54
                                          : (isReceivable
                                              ? const Color(0xFF10B981)
                                              : const Color(0xFFEF4444)),
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    isSettled
                                        ? 'No balance'
                                        : (isReceivable ? 'Owes you' : 'You owe'),
                                    style: TextStyle(
                                      color: isSettled
                                          ? Colors.white38
                                          : (isReceivable
                                              ? const Color(0xFF10B981).withOpacity(0.8)
                                              : const Color(0xFFEF4444).withOpacity(0.8)),
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.chevron_right_rounded,
                                color: Colors.white30,
                                size: 20,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
