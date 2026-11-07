import 'package:flutter/material.dart';

/// TER Design System Color Palette
/// Directly derived from the reference fintech dashboard UI
abstract class AppColors {
  // Backgrounds
  static const Color background = Color(0xFF080C15);
  static const Color backgroundSecondary = Color(0xFF0D121F);
  
  // Surfaces & Cards
  static const Color cardSurface = Color(0xFF131927);
  static const Color cardSurfaceElevated = Color(0xFF182032);
  static const Color cardBorder = Color(0x1AFFFFFF); // 10% white
  static const Color cardBorderSubtle = Color(0x0DFFFFFF); // 5% white
  
  // Primary & Accents
  static const Color primaryBlue = Color(0xFF2563EB); // Vibrant Electric Blue
  static const Color primaryBlueGlow = Color(0xFF3B82F6);
  static const Color primaryBlueDark = Color(0xFF1D4ED8);
  static const Color accentCyan = Color(0xFF06B6D4);
  
  // Quick Action Buttons
  static const Color actionButtonBg = Color(0xFF141B2B);
  static const Color actionButtonBorder = Color(0x1F3B82F6); // Soft blue rim
  
  // Cash Flow Semantic Colors
  static const Color inflow = Color(0xFF10B981); // Emerald Mint
  static const Color outflow = Color(0xFFEF4444); // Crimson / Coral
  static const Color neutral = Color(0xFF94A3B8); // Slate
  
  // Typography Colors
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFF8E9BAE);
  static const Color textTertiary = Color(0xFF5B687D);
  static const Color textMuted = Color(0xFF475569);
  
  // Chart Colors
  static const Color chartBarMuted = Color(0xFF1C2436);
  static const Color chartBarActive = Color(0xFF2563EB);
  
  // Bottom Navigation
  static const Color navBarBg = Color(0xEE0E1422);
  static const Color navBarBorder = Color(0x1FFFFFFF);
  static const Color navItemInactive = Color(0xFF64748B);
  static const Color navItemActive = Color(0xFFFFFFFF);
}
