import 'package:flutter/material.dart';

/// Doko app color palette.
/// Based on the agri-app design research: deep, desaturated greens for
/// branding, a warm off-white (never pure white) for backgrounds so the
/// UI stays readable in bright outdoor sunlight, and a single consistent
/// accent color reserved for primary actions (Add to cart, Accept order).
class AppColors {
  AppColors._(); // Prevent instantiation-stop other file from creating an object of this class

  // --- Brand ---
  static const Color primaryDark =Color(0xFF1B5E20); // deep green forest
  static const Color primary =Color(0xFF2E7D32);      //  green
  static const Color primaryLight = Color(0xFF66BB6A); // Light green — subtle highlights

  // Backgrounds
  static const Color background = Color(0xFFFAF7F0); // warm off-white
  static const Color surface = Color(0xFFFFFFFF); // Cards sit on pure white above the off-white bg
  static const Color surfaceMuted = Color(0xFFF1ECE1); // Secondary/earthy surface (tabs, chips)

  // Accent
  static const Color accent = Color(0xFF5B6840); // green— Add to cart, Confirm, Accept
  static const Color accentDark = Color(0xFF66BB4A); // Pressed/hover state for accent

  //  Status colors (kept distinct from brand green to avoid confusion)
  static const Color success = Color(0xFF43A047); // Confirmed / Delivered
  static const Color warning = Color(0xFFF9A825); // Pending / Pre-order
  static const Color error = Color(0xFFD32F2F); // Declined / Out of stock
  static const Color info = Color(0xFF5B6840); // In transit / neutral info

  //  Surplus / discount tag
  static const Color surplus = Color(0xFFEF6C00); // Distinct burnt-orange for surplus badges

  //  Text
  static const Color textPrimary = Color(0xFF2B2B28); // Near-black, slightly warm (not pure black)
  static const Color textSecondary = Color(0xFF6B6B63);
  static const Color textOnDark = Color(0xFFFAF7F0);

  //  Borders / dividers
  static const Color border = Color(0xFFE0DACB);
}