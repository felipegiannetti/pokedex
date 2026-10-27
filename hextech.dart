import 'package:flutter/material.dart';

/// Paleta inspirada no cliente do jogo (tons "Hextech": azul-noite e dourado).
class Hextech {
  static const Color background = Color(0xFF010A13);
  static const Color surface = Color(0xFF0A1428);
  static const Color surfaceHigh = Color(0xFF1E2328);
  static const Color gold = Color(0xFFC8AA6E);
  static const Color goldLight = Color(0xFFF0E6D2);
  static const Color blue = Color(0xFF0AC8B9);
  static const Color textMuted = Color(0xFFA09B8C);

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: gold,
          brightness: Brightness.dark,
          surface: surface,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: surface,
          foregroundColor: goldLight,
          centerTitle: false,
        ),
      );
}

/// Nome em português e cor de cada classe (tag) devolvida pela API.
class ChampionTagStyle {
  final String label;
  final Color color;

  const ChampionTagStyle(this.label, this.color);

  static const Map<String, ChampionTagStyle> _styles = {
    'Fighter': ChampionTagStyle('Lutador', Color(0xFFC0392B)),
    'Tank': ChampionTagStyle('Tanque', Color(0xFF7F8C8D)),
    'Mage': ChampionTagStyle('Mago', Color(0xFF8E44AD)),
    'Assassin': ChampionTagStyle('Assassino', Color(0xFF2C3E50)),
    'Marksman': ChampionTagStyle('Atirador', Color(0xFFD68910)),
    'Support': ChampionTagStyle('Suporte', Color(0xFF16A085)),
  };

  static ChampionTagStyle of(String tag) =>
      _styles[tag] ?? ChampionTagStyle(tag, Hextech.surfaceHigh);
}
