import 'package:flutter/material.dart';

import '../models/champion.dart';
import '../theme/hextech.dart';
import '../widgets/champion_avatar.dart';
import '../widgets/info_bar.dart';
import '../widgets/tag_chip.dart';

/// TELA 2: detalhes de um campeão.
///
/// Recebe o campeão PELO CONSTRUTOR: é assim que os dados
/// "descem" da Tela 1 para a Tela 2.
class ChampionDetailScreen extends StatelessWidget {
  final Champion champion;

  const ChampionDetailScreen({super.key, required this.champion});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text(champion.name),
      ),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _Header(champion: champion),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  spacing: 6,
                  children: [
                    for (final tag in champion.tags) TagChip(tag: tag),
                  ],
                ),
                const SizedBox(height: 20),
                const _SectionTitle('Descrição:'),
                const SizedBox(height: 8),
                Text(
                  champion.blurb,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Hextech.goldLight,
                  ),
                ),
                const SizedBox(height: 24),
                const _SectionTitle('Atributos'),
                const SizedBox(height: 8),
                InfoBar(label: 'Ataque', value: champion.attack),
                InfoBar(label: 'Defesa', value: champion.defense),
                InfoBar(
                  label: 'Magia',
                  value: champion.magic,
                  color: Hextech.blue,
                ),
                InfoBar(
                  label: 'Dificuldade',
                  value: champion.difficulty,
                  color: Hextech.textMuted,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Topo da tela: arte de fundo (splash) + ícone + nome e título.
class _Header extends StatelessWidget {
  final Champion champion;

  const _Header({required this.champion});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Etapa 4: arte de fundo vinda da CDN do Data Dragon.
          Image.network(
            champion.splashUrl,
            fit: BoxFit.cover,
            alignment: Alignment.topCenter,
            loadingBuilder: (context, child, progress) => progress == null
                ? child
                : const ColoredBox(color: Hextech.surface),
            errorBuilder: (context, error, stackTrace) =>
                const ColoredBox(color: Hextech.surface),
          ),
          // Degradê para o texto continuar legível sobre a imagem.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Hextech.background],
                stops: [0.45, 1.0],
              ),
            ),
          ),
          Positioned(
            left: 20,
            right: 20,
            bottom: 8,
            child: Row(
              children: [
                Hero(
                  tag: 'champion-${champion.id}',
                  child: ChampionAvatar(champion: champion, radius: 34),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        champion.name.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Hextech.goldLight,
                          letterSpacing: 1.5,
                        ),
                      ),
                      Text(
                        champion.title,
                        style: const TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Hextech.gold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text.toUpperCase(),
      style: const TextStyle(
        fontSize: 15,
        fontWeight: FontWeight.bold,
        color: Hextech.gold,
        letterSpacing: 1.2,
      ),
    );
  }
}
