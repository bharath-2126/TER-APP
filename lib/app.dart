import 'package:flutter/material.dart';
import 'src/core/theme/app_theme.dart';
import 'src/shared/components/custom_bottom_nav_bar.dart';
import 'src/features/transactions/presentation/quick_log_sheet.dart';
import 'src/features/dashboard/presentation/dashboard_screen.dart';
import 'src/features/analytics/presentation/statistics_screen.dart';
import 'src/features/lending/presentation/lending_screen.dart';
import 'src/features/cards_vault/presentation/cards_screen.dart';

class TerApp extends StatelessWidget {
  const TerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TER – Track Every Rupee',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
      home: const MainNavigationShell(),
    );
  }
}

class MainNavigationShell extends StatefulWidget {
  const MainNavigationShell({super.key});

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  int _currentIndex = 0;

  void _openQuickEntry() {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const QuickLogSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      DashboardScreen(
        onNavigateTab: (index) {
          setState(() => _currentIndex = index);
        },
      ),
      const StatisticsScreen(),
      const LendingScreen(),
      const CardsScreen(),
    ];

    return Scaffold(
      extendBody: true,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index) {
          setState(() => _currentIndex = index);
        },
        onQuickActionPressed: _openQuickEntry,
      ),
    );
  }
}
