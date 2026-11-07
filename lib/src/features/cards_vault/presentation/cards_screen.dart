import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/formatting/currency_formatter.dart';
import '../../../core/security/vault_security_service.dart';
import '../../../core/providers/app_providers.dart';
import '../../cards_vault/domain/card_model.dart';
import '../../accounts/domain/account_model.dart';
import '../../../shared/components/financial_card.dart';

class CardsScreen extends ConsumerStatefulWidget {
  const CardsScreen({super.key});

  @override
  ConsumerState<CardsScreen> createState() => _CardsScreenState();
}

class _CardsScreenState extends ConsumerState<CardsScreen> {
  bool _vaultUnlocked = false;

  void _toggleVaultLock() {
    setState(() {
      _vaultUnlocked = !_vaultUnlocked;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _vaultUnlocked ? 'Biometric Verified: Card Details Revealed' : 'Card Vault Locked',
        ),
        backgroundColor: _vaultUnlocked ? AppColors.inflow : AppColors.cardSurfaceElevated,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cardsAsync = ref.watch(cardsStreamProvider);
    final accountsAsync = ref.watch(accountsStreamProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        bottom: false,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Cards & Card Vault',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: Colors.white),
                ),
                IconButton(
                  icon: Icon(
                    _vaultUnlocked ? Icons.lock_open : Icons.lock_outline,
                    color: _vaultUnlocked ? AppColors.inflow : AppColors.textSecondary,
                  ),
                  onPressed: _toggleVaultLock,
                  tooltip: 'Biometric Vault Lock',
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Security badge
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              decoration: BoxDecoration(
                color: const Color(0x1F10B981),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.inflow.withOpacity(0.3)),
              ),
              child: const Row(
                children: [
                  Icon(Icons.shield_outlined, color: AppColors.inflow, size: 16),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Zero-Knowledge Vault: CVVs, PINs & Passwords are never stored.',
                      style: TextStyle(fontSize: 11, color: AppColors.inflow, fontWeight: FontWeight.w500),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            // Cards carousel
            cardsAsync.when(
              data: (cards) {
                if (cards.isEmpty) {
                  return const Center(child: Text('No cards added yet.', style: TextStyle(color: Colors.white70)));
                }
                return Column(
                  children: cards.map((card) => _buildCardWidget(card)).toList(),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator(color: AppColors.primaryBlue)),
              error: (err, _) => Center(child: Text('Error: $err', style: const TextStyle(color: AppColors.outflow))),
            ),
            const SizedBox(height: 24),
            // Bank Accounts section
            const Text(
              'Linked Bank Accounts',
              style: AppTypography.sectionHeader,
            ),
            const SizedBox(height: 12),
            accountsAsync.when(
              data: (accounts) {
                return Column(
                  children: accounts.map((acc) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: FinancialCard(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: AppColors.cardSurfaceElevated,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(Icons.account_balance, color: AppColors.primaryBlueGlow, size: 20),
                                ),
                                const SizedBox(width: 12),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(acc.name, style: AppTypography.cardTitle),
                                    Text(acc.type.name.toUpperCase(), style: AppTypography.cardSubtitle),
                                  ],
                                ),
                              ],
                            ),
                            Text(
                              CurrencyFormatter.formatPaise(acc.currentBalancePaise),
                              style: AppTypography.amountMedium.copyWith(color: AppColors.inflow),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () => const SizedBox.shrink(),
              error: (_, __) => const SizedBox.shrink(),
            ),
            const SizedBox(height: 100),
          ],
        ),
      ),
    );
  }

  Widget _buildCardWidget(CardModel card) {
    final isCredit = card.cardType == CardType.credit;
    final gradientColors = isCredit
        ? const [Color(0xFF1E3A8A), Color(0xFF0F172A)]
        : const [Color(0xFF065F46), Color(0xFF064E3B)];

    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Container(
        height: 180,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(color: Colors.black45, blurRadius: 16, offset: Offset(0, 6)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(card.cardName, style: AppTypography.cardTitle),
                Text(card.cardType.name.toUpperCase(), style: AppTypography.cardSubtitle),
              ],
            ),
            Text(
              _vaultUnlocked
                  ? '•••• •••• •••• ${card.last4Digits}'
                  : VaultSecurityService.maskCardNumber(card.last4Digits),
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 2,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (isCredit)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Outstanding', style: AppTypography.cardSubtitle),
                      Text(
                        CurrencyFormatter.formatPaise(card.currentOutstandingPaise),
                        style: AppTypography.amountMedium.copyWith(color: AppColors.outflow),
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Text('Credit Limit', style: AppTypography.cardSubtitle),
                      Text(
                        CurrencyFormatter.formatPaise(card.creditLimitPaise ?? 0),
                        style: AppTypography.amountMedium,
                      ),
                    ],
                  ),
                ],
              )
            else
              const Text('Linked to Active Bank Account', style: AppTypography.cardSubtitle),
          ],
        ),
      ),
    );
  }
}
