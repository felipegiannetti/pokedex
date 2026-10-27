import 'package:material_ui/material_ui.dart';

import '../models/pokemon.dart';
import '../services/pokeapi_service.dart';
import '../theme/type_colors.dart';
import '../widgets/pokemon_card.dart';
import 'pokemon_detail_screen.dart';

/// TELA 1: grade com os Pokémon.
///
/// Busca a Pokédex direto da PokéAPI (com busca por nome e "arrastar para
/// atualizar"), e abre a Tela 2 ao tocar em um card.
class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  final PokeApiService _api = PokeApiService();
  late Future<List<Pokemon>> _pokedexFuture;

  /// Ids dos Pokémon capturados (resultado devolvido pela Tela 2).
  final Set<int> _captured = {};

  String _query = '';

  @override
  void initState() {
    super.initState();
    _pokedexFuture = _api.fetchPokedex();
  }

  Future<void> _refresh() {
    final future = _api.fetchPokedex();
    setState(() => _pokedexFuture = future);
    return future;
  }

  Future<void> _openDetails(Pokemon pokemon) async {
    final captured = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => PokemonDetailScreen(
          pokemon: pokemon,
          isCaptured: _captured.contains(pokemon.id),
        ),
      ),
    );

    if (captured == true && mounted) {
      setState(() => _captured.add(pokemon.id));
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${pokemon.displayName} foi capturado!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F6),
      appBar: AppBar(
        backgroundColor: pokedexRed,
        foregroundColor: Colors.white,
        title: const Text(
          'Pokédex',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Row(
              children: [
                const Icon(Icons.catching_pokemon),
                const SizedBox(width: 4),
                Text('${_captured.length}'),
              ],
            ),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: TextField(
              onChanged: (value) =>
                  setState(() => _query = value.trim().toLowerCase()),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Buscar por nome...',
                hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.7)),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                filled: true,
                fillColor: Colors.white.withValues(alpha: 0.15),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ),
      ),
      body: FutureBuilder<List<Pokemon>>(
        future: _pokedexFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.grey),
                  const SizedBox(height: 12),
                  const Text('Não foi possível carregar a Pokédex.'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _refresh,
                    child: const Text('Tentar de novo'),
                  ),
                ],
              ),
            );
          }

          final pokemons = (snapshot.data ?? [])
              .where((p) => p.displayName.toLowerCase().contains(_query))
              .toList();

          if (pokemons.isEmpty) {
            return Center(
              child: Text('Nenhum Pokémon encontrado para "$_query".'),
            );
          }

          return RefreshIndicator(
            onRefresh: _refresh,
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: 0.8,
              ),
              itemCount: pokemons.length,
              itemBuilder: (context, index) {
                final pokemon = pokemons[index];
                return PokemonCard(
                  key: ValueKey(pokemon.id),
                  pokemon: pokemon,
                  isCaptured: _captured.contains(pokemon.id),
                  onTap: () => _openDetails(pokemon),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
