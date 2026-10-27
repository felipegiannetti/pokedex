import 'package:material_ui/material_ui.dart';

import '../models/pokemon.dart';
import '../services/pokeapi_service.dart';
import '../theme/type_colors.dart';
import '../widgets/stat_bar.dart';
import '../widgets/type_chip.dart';

/// TELA 2: detalhes de um Pokémon.
///
/// Recebe o Pokémon PELO CONSTRUTOR (dados "descem" da Tela 1) e busca a
/// descrição em /pokemon-species/{id} caso ela ainda não tenha vindo pronta.
class PokemonDetailScreen extends StatefulWidget {
  final Pokemon pokemon;
  final bool isCaptured;

  const PokemonDetailScreen({
    super.key,
    required this.pokemon,
    this.isCaptured = false,
  });

  @override
  State<PokemonDetailScreen> createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {
  final PokeApiService _api = PokeApiService();
  late Future<String> _descriptionFuture;

  @override
  void initState() {
    super.initState();
    final description = widget.pokemon.description;
    _descriptionFuture = description != null
        ? Future.value(description)
        : _api.fetchDescription(widget.pokemon.id);
  }

  @override
  Widget build(BuildContext context) {
    final pokemon = widget.pokemon;
    final color = PokemonTypeStyle.of(pokemon.primaryType).color;

    return Scaffold(
      backgroundColor: color,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
        title: Text(pokemon.displayName),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                pokemon.number,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ---------- Topo colorido com a arte ----------
          SizedBox(
            height: 220,
            child: Hero(
              tag: 'pokemon-${pokemon.id}',
              child: Image.network(pokemon.imageUrl, fit: BoxFit.contain),
            ),
          ),
          // ---------- "Folha" branca com as informações ----------
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
              ),
              child: ListView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 100),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for (final type in pokemon.types)
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: TypeChip(type: type),
                        ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  _SectionTitle('Sobre', color: color),
                  Row(
                    children: [
                      _InfoTile(
                        icon: Icons.straighten,
                        label: 'Altura',
                        value: '${pokemon.heightInMeters} m',
                      ),
                      _InfoTile(
                        icon: Icons.fitness_center,
                        label: 'Peso',
                        value: '${pokemon.weightInKg} kg',
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Habilidades: ${pokemon.abilities.join(', ')}',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                  const SizedBox(height: 12),
                  FutureBuilder<String>(
                    future: _descriptionFuture,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          ),
                        );
                      }
                      if (snapshot.hasError) {
                        return const Text(
                          'Sem descrição.',
                          style: TextStyle(height: 1.4),
                        );
                      }
                      return Text(
                        snapshot.data ?? 'Sem descrição.',
                        style: const TextStyle(height: 1.4),
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  _SectionTitle('Status base', color: color),
                  for (final entry in pokemon.stats.entries)
                    StatBar(
                      label: statLabels[entry.key] ?? entry.key,
                      value: entry.value,
                      color: color,
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: widget.isCaptured
          ? const FloatingActionButton.extended(
              onPressed: null,
              backgroundColor: Colors.grey,
              icon: Icon(Icons.check),
              label: Text('Já capturado'),
            )
          : FloatingActionButton.extended(
              backgroundColor: pokedexRed,
              foregroundColor: Colors.white,
              icon: const Icon(Icons.catching_pokemon),
              label: const Text('Capturar!'),
              onPressed: () => Navigator.pop(context, true),
            ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String text;
  final Color color;

  const _SectionTitle(this.text, {required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: color,
        ),
      ),
    );
  }
}

class _InfoTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoTile({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18),
              const SizedBox(width: 6),
              Text(value, style: const TextStyle(fontSize: 16)),
            ],
          ),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(color: Colors.grey.shade600)),
        ],
      ),
    );
  }
}
