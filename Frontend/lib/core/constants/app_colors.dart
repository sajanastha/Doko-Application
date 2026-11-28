import 'package:flutter/material.dart';

/// Doko app color palette.
class AppColors {
  AppColors._(); // Prevent instantiation

  // --- Brand ---
  static const Color primaryDark = Color(0xFF1B5E40); // Deep forest green for headers, nav
  static const Color primary = Color(0xFF5B6849); // Core brand olive green
  static const Color primaryLight = Color(0xFF66BB6A); // Light green for highlights

  // --- Backgrounds ---
  static const Color background = Color(0xFFFAF7F0); // Warm off-white, not pure white
  static const Color surface = Color(0xFFFFFFFF); // Cards sit on pure white above the off-white bg
  static const Color surfaceMuted = Color(0xFFF1ECE1); // Secondary/earthy surface (tabs, chips)

  //  Accent (primary actions only)
  static const Color accent = Color(0xFF5B6849); // muted olive — Add to cart, Confirm, Accept
  static const Color accentDark = Color(0xFF66BB6A); // Pressed/hover state for accent

  //Quick-contact icons (call / WhatsApp)
  static const Color contactWhatsApp = Color(0xFF25D366);
  static const Color contactCall = Color(0xFF1E88E5); // reuses the `info` blue below

  //  Status colors
  static const Color success = Color(0xFF43A047); // Confirmed / Delivered
  static const Color warning = Color(0xFFF9A825); // Pending / Pre-order
  static const Color error = Color(0xFFD32F2F); // Declined / Out of stock
  static const Color info = Color(0xFF1E88E5); // In transit / neutral info

  //  Surplus / discount tag
  static const Color surplus = Color(0xFFEF6C00); // Distinct burnt-orange for surplus badges

  //  Text
  static const Color textPrimary = Color(0xFF2B2B28); // Near-black, slightly warm (not pure black)
  static const Color textSecondary = Color(0xFF6B6B63);
  static const Color textOnDark = Color(0xFFFAF7F0);

  //  Borders / dividers
  static const Color border = Color(0xFFE0DACB);
}