import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Backgrounds
  static const Color background = Color(0xFF0C0D12);
  static const Color cardBg = Color(0xFF14161F);
  static const Color cardBgElevated = Color(0xFF1A1D29);
  static const Color cardBorder = Color(0xFF26293A);
  
  // Brand & Accents
  static const Color gold = Color(0xFFC9A227);
  static const Color goldLight = Color(0xFFE2B83B);
  static const Color goldDark = Color(0xFFA6851F);
  static const Color goldMuted = Color(0x33C9A227);
  
  // Fresh Farm Emerald Accents
  static const Color emerald = Color(0xFF10B981);
  static const Color emeraldMuted = Color(0x2A10B981);
  
  // Text Colors
  static const Color textPrimary = Color(0xFFF3F4F6);
  static const Color textSecondary = Color(0xFF9CA3AF);
  static const Color textMuted = Color(0xFF6B7280);
  
  // Verified Seal Blue
  static const Color verifiedBlue = Color(0xFF1DA1F2);
  
  // Danger / Sale
  static const Color saleRed = Color(0xFFEF4444);
  static const Color saleRedMuted = Color(0x29EF4444);

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: gold,
      colorScheme: const ColorScheme.dark(
        primary: gold,
        secondary: emerald,
        surface: cardBg,
      ),
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
          side: const BorderSide(color: cardBorder, width: 1),
        ),
      ),
      textTheme: GoogleFonts.montserratTextTheme(
        ThemeData.dark().textTheme.copyWith(
          displayLarge: GoogleFonts.cormorantGaramond(
            color: textPrimary,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.5,
          ),
          displayMedium: GoogleFonts.cormorantGaramond(
            color: textPrimary,
            fontWeight: FontWeight.w700,
          ),
          titleLarge: GoogleFonts.montserrat(
            color: textPrimary,
            fontWeight: FontWeight.w600,
          ),
          bodyLarge: GoogleFonts.montserrat(
            color: textPrimary,
          ),
          bodyMedium: GoogleFonts.montserrat(
            color: textSecondary,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: textPrimary),
    );
  }
}
