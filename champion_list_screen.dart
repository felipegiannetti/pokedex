import 'package:flutter/material.dart';

import '../models/champion.dart';
import '../services/api_service.dart';
import '../theme/hextech.dart';
import '../widgets/champion_tile.dart';
import 'champion_detail_screen.dart';

/// TELA 1: lista de campeões (versão completa, com Data Dragon).
class ChampionListScreen extends StatefulWidget {
  const ChampionListScreen({super.key});

  @override
  State<ChampionListScreen> createState() => _ChampionListScreenState();
}

class _ChampionListScreenState extends State<ChampionListScreen> {
  final ApiService apiService = ApiService();

  /// Criado UMA vez no initState. Se fosse criado no build(), cada
  /// setState() (ex.: digitar na busca) faria uma nova requisição.
  late Future<List<Champion>> futureChampions;

  String _query = '';

  @override
  void initState() {
    super.initState();
    futureChampions = apiService.fetchChampions();
  }

  Future<void> _reload() async {
    setState(() {
      futureChampions = apiService.fetchChampions();
    });
    await futureChampions;
  }

  /// Etapa 2: navegação Tela 1 -> Tela 2, enviando o campeão escolhido.
  void _openDetails(Champion champion) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChampionDetailScreen(champion: champion),
      ),
    );
  }

  List<Champion> _filter(List<Champion> all) {
    if (_query.isEmpty) return all;
    final q = _query.toLowerCase();
    return all.where((c) => c.name.toLowerCase().contains(q)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Campeões',
          style: TextStyle(fontWeight: FontWeight.bold, color: Hextech.gold),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 10),
            child: TextField(
              onChanged: (value) => setState(() => _query = value.trim()),
              style: const TextStyle(color: Hextech.goldLight),
              decoration: InputDecoration(
                hintText: 'Buscar campeão',
                prefixIcon: const Icon(Icons.search, color: Hextech.gold),
                filled: true,
                fillColor: Hextech.background,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(4),
                  borderSide: const BorderSide(color: Hextech.gold),
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Champion>>(
        future: futureChampions,
        builder: (context, snapshot) {
          // 1) Esperando a resposta
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Hextech.gold),
            );
          }
          // 2) Erro (sem internet, timeout, status != 200...)
          else if (snapshot.hasError) {
            return _ErrorView(
              message: '${snapshot.error}',
              onRetry: _reload,
            );
          }
          // 3) Resposta vazia
          else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Nenhum campeão disponível'));
          }
          // 4) Dados prontos
          final champions = _filter(snapshot.data!);
          return RefreshIndicator(
            onRefresh: _reload,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: champions.length,
              itemBuilder: (context, index) {
                final champion = champions[index];
                return ChampionTile(
                  key: ValueKey(champion.id),
                  champion: champion,
                  onTap: () => _openDetails(champion),
                );
              },
            ),
          );
        },
      ),
    );
  }
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, size: 56, color: Hextech.textMuted),
            const SizedBox(height: 12),
            Text('Erro: $message', textAlign: TextAlign.center),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar de novo'),
            ),
          ],
        ),
      ),
    );
  }
}
