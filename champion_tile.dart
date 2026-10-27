import 'package:flutter/material.dart';

import '../models/champion.dart';
import '../theme/hextech.dart';
import 'champion_avatar.dart';
import 'tag_chip.dart';

/// Item da lista de campeões (Tela 1). É um ListTile, como no roteiro,
/// com o visual do tema Hextech.
///
/// O tile NÃO navega sozinho: só avisa o pai pelo callback [onTap].
class ChampionTile extends StatelessWidget {
  final Champion champion;
  final VoidCallback? onTap;

  const ChampionTile({super.key, required this.champion, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Hextech.surface,
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(color: Hextech.gold.withValues(alpha: 0.35)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        leading: Hero(
          // Mesma tag na Tela 2: o ícone "voa" entre as telas.
          tag: 'champion-${champion.id}',
          child: ChampionAvatar(champion: champion),
        ),
        title: Text(
          champion.name,
          style: const TextStyle(
            color: Hextech.goldLight,
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                champion.title,
                style: const TextStyle(color: Hextech.textMuted),
              ),
              const SizedBox(height: 6),
              Wrap(
                spacing: 4,
                runSpacing: 4,
                children: [for (final tag in champion.tags) TagChip(tag: tag)],
              ),
            ],
          ),
        ),
        trailing: const Icon(Icons.chevron_right, color: Hextech.gold),
        onTap: onTap,
      ),
    );
  }
}
