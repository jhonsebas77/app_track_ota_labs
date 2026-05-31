// lib/theme/blueprint_theme.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blueprint_colors.dart';

class BlueprintTheme {
  BlueprintTheme._();

  static TextStyle _mono({
    required Color color,
    double size = 14,
    FontWeight weight = FontWeight.w400,
    double letterSpacing = 0,
    double height = 1.4,
  }) =>
      GoogleFonts.jetBrainsMono(
        color: color,
        fontSize: size,
        fontWeight: weight,
        letterSpacing: letterSpacing,
        height: height,
      );

  static ThemeData dark() {
    const Color bg      = BpColors.background;
    const Color surface = BpColors.surfaceContainerLow;
    const Color grid    = BpColors.gridLine;
    const Color text    = BpColors.textPrimary;
    const Color dim     = BpColors.textDim;
    const Color accent  = BpColors.primaryContainer;

    ColorScheme scheme = const ColorScheme(
      brightness:           Brightness.dark,
      primary:              accent,
      onPrimary:            BpColors.onPrimaryFixed,
      primaryContainer:     Color(0xFF6A3B00),
      onPrimaryContainer:   text,
      secondary:            BpColors.primary,
      onSecondary:          BpColors.onPrimaryFixed,
      secondaryContainer:   grid,
      onSecondaryContainer: text,
      tertiary:             BpColors.success,
      onTertiary:           bg,
      tertiaryContainer:    Color(0xFF004D64),
      onTertiaryContainer:  text,
      error:                BpColors.error,
      onError:              bg,
      errorContainer:       BpColors.errorContainer,
      onErrorContainer:     BpColors.error,
      surface:              surface,
      onSurface:            BpColors.onSurface,
      surfaceContainerHighest: Color(0xFF3D332A),
      onSurfaceVariant:     BpColors.onSurfaceVariant,
      outline:              BpColors.outline,
      outlineVariant:       BpColors.outlineVariant,
      shadow:               Colors.black38,
      scrim:                Colors.black54,
      inverseSurface:       text,
      onInverseSurface:     bg,
      inversePrimary:       Color(0xFF8B5000),
    );

    return ThemeData(
      useMaterial3:           true,
      brightness:             Brightness.dark,
      colorScheme:            scheme,
      scaffoldBackgroundColor: bg,
      fontFamily:             GoogleFonts.jetBrainsMono().fontFamily,

      // ── SystemUI overlay ─────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor:         surface,
        foregroundColor:         text,
        elevation:               0,
        scrolledUnderElevation:  0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor:             Colors.transparent,
          statusBarIconBrightness:    Brightness.light,
          systemNavigationBarColor:   BpColors.background,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: _mono(color: text, size: 16, weight: FontWeight.w600, letterSpacing: 2),
        shape: const Border(bottom: BorderSide(color: BpColors.outline, width: 1)),
      ),

      // ── Cards ────────────────────────────────────────────
      cardTheme: CardThemeData(
        color:     surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
          side: BorderSide(color: BpColors.outline.withAlpha(80), width: 1),
        ),
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
      ),

      // ── Elevated Button ───────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.resolveWith((Set<WidgetState> s) {
            if (s.contains(WidgetState.pressed)) return const Color(0xFFD47800);
            return accent;
          }),
          foregroundColor:   WidgetStateProperty.all(BpColors.onPrimaryFixed),
          overlayColor:      WidgetStateProperty.all(Colors.transparent),
          elevation:         WidgetStateProperty.all(0),
          padding:           WidgetStateProperty.all(
            const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          ),
          shape:             WidgetStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          textStyle: WidgetStateProperty.all(
            _mono(color: BpColors.onPrimaryFixed, size: 12, weight: FontWeight.w700, letterSpacing: 3),
          ),
          side: WidgetStateProperty.all(const BorderSide(color: accent, width: 1)),
          animationDuration: const Duration(milliseconds: 150),
        ),
      ),

      // ── Outlined Button ───────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStateProperty.all(dim),
          side: WidgetStateProperty.all(BorderSide(color: BpColors.outline.withAlpha(100), width: 1)),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          ),
          textStyle: WidgetStateProperty.all(
            _mono(color: dim, size: 10, weight: FontWeight.w500, letterSpacing: 1),
          ),
        ),
      ),

      // ── Input ─────────────────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled:           true,
        fillColor:        surface,
        contentPadding:   const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        hintStyle:        _mono(color: dim.withAlpha(100), size: 12, letterSpacing: 3, weight: FontWeight.w500),
        labelStyle:       _mono(color: dim, size: 10, letterSpacing: 2),
        floatingLabelStyle: _mono(color: accent, size: 10, letterSpacing: 2),
        prefixIconColor:  dim,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: BpColors.outline.withAlpha(120), width: 1),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: accent, width: 1.5),
        ),
        errorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: BpColors.error, width: 1),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.zero,
          borderSide: BorderSide(color: BpColors.error, width: 1.5),
        ),
      ),

      // ── Divider ──────────────────────────────────────────
      dividerTheme: const DividerThemeData(color: BpColors.gridLine, thickness: 1, space: 1),

      // ── Icon ─────────────────────────────────────────────
      iconTheme: const IconThemeData(color: BpColors.textDim, size: 20),
      primaryIconTheme: const IconThemeData(color: accent, size: 20),

      // ── Progress ─────────────────────────────────────────
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: accent,
        linearTrackColor: BpColors.gridLine,
        linearMinHeight: 2,
      ),

      // ── SnackBar ─────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor:  grid,
        contentTextStyle: _mono(color: text, size: 12),
        actionTextColor:  accent,
        elevation:        0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
