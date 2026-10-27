import 'package:flutter/material.dart';

import '../theme/hextech.dart';

/// Etiqueta com a classe do campeão (Mago, Atirador, Suporte...).
class TagChip extends StatelessWidget {
  final String tag;

  const TagChip({super.key, required this.tag});

  @override
  Widget build(BuildContext context) {
    final style = ChampionTagStyle.of(tag);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: style.color.withValues(alpha: 0.35),
        border: Border.all(color: style.color),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        style.label.toUpperCase(),
        style: const TextStyle(
          color: Hextech.goldLight,
          fontSize: 11,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
    );
  }
}
