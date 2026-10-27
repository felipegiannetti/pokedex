import 'package:material_ui/material_ui.dart';

import '../data/pokemon_mock.dart';
import '../models/pokemon.dart';
import '../theme/type_colors.dart';
import '../widgets/pokemon_card.dart';
// TODO (Etapa 1): este import será usado quando você implementar a navegação.
// ignore: unused_import
import 'pokemon_detail_screen.dart';

/// TELA 1: grade com os Pokémon.
///
/// Versão BASE: usa os dados estáticos de `pokemonMock`.
class PokedexScreen extends StatefulWidget {
  const PokedexScreen({super.key});

  @override
  State<PokedexScreen> createState() => _PokedexScreenState();
}

class _PokedexScreenState extends State<PokedexScreen> {
  // TODO (Etapa 3): trocar a lista estática por um Future vindo da PokéAPI.
  //   late Future<List<Pokemon>> _pokedexFuture;
  //   initState() { _pokedexFuture = _api.fetchPokedex(); }
  final List<Pokemon> _pokemons = pokemonMock;

  /// Ids dos Pokémon capturados (resultado devolvido pela Tela 2).
  final Set<int> _captured = {};

  void _openDetails(Pokemon pokemon) {
    // TODO (Etapa 1): navegar para PokemonDetailScreen enviando o pokemon.
    //   Navigator.push(context, MaterialPageRoute(builder: (context) => ...));
    //
    // TODO (Etapa 2): esperar o resultado do Navigator.push<bool>.
    //   Se vier `true`, adicionar o id em _captured dentro de um setState()
    //   e mostrar um SnackBar "<nome> foi capturado!".
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Você tocou em ${pokemon.displayName}')),
    );
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
      ),
      // TODO (Etapa 3): envolver a grade em um FutureBuilder<List<Pokemon>>
      // tratando os estados: carregando, erro e dados prontos.
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          mainAxisSpacing: 12,
          crossAxisSpacing: 12,
          childAspectRatio: 0.8,
        ),
        itemCount: _pokemons.length,
        itemBuilder: (context, index) {
          final pokemon = _pokemons[index];
          return PokemonCard(
            key: ValueKey(pokemon.id),
            pokemon: pokemon,
            isCaptured: _captured.contains(pokemon.id),
            onTap: () => _openDetails(pokemon),
          );
        },
      ),
    );
  }
}
