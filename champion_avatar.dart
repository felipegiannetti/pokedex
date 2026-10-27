import 'package:flutter/material.dart';

import '../models/champion.dart';
import '../theme/hextech.dart';

/// Ícone redondo do campeão com borda dourada.
/// Etapa 4: a imagem vem da CDN do Data Dragon (champion.imageUrl).
class ChampionAvatar extends StatelessWidget {
  final Champion champion;
  final double radius;

  const ChampionAvatar({super.key, required this.champion, this.radius = 26});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Hextech.gold,
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Hextech.surfaceHigh,
        // Mesmo widget do roteiro: NetworkImage baixa e guarda em cache.
        backgroundImage: NetworkImage(champion.imageUrl),
        // Se a imagem falhar, o CircleAvatar mostra só a cor de fundo.
        onBackgroundImageError: (error, stackTrace) {},
      ),
    );
  }
}
