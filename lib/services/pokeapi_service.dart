import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokeApiService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  /// GET $baseUrl/pokemon/{idOuNome}
  Future<Pokemon> fetchPokemon(String idOrName) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon/$idOrName'));
    if (response.statusCode != 200) {
      throw Exception(
        'Falha ao buscar o Pokémon "$idOrName" (status ${response.statusCode})',
      );
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return Pokemon.fromJson(json);
  }

  /// GET $baseUrl/pokemon?limit=151
  /// A resposta só traz nome + url. Usamos Future.wait para buscar
  /// os detalhes de cada um com fetchPokemon.
  Future<List<Pokemon>> fetchPokedex({int limit = 151, int offset = 0}) async {
    final response = await http.get(
      Uri.parse('$baseUrl/pokemon?limit=$limit&offset=$offset'),
    );
    if (response.statusCode != 200) {
      throw Exception('Falha ao buscar a Pokédex (status ${response.statusCode})');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final results = json['results'] as List<dynamic>;

    final pokemons = await Future.wait(
      results.map(
        (entry) => fetchPokemon((entry as Map<String, dynamic>)['name'] as String),
      ),
    );
    pokemons.sort((a, b) => a.id.compareTo(b.id));
    return pokemons;
  }

  /// GET $baseUrl/pokemon-species/{id}
  /// Procura em "flavor_text_entries" o texto com language.name == 'en'.
  Future<String> fetchDescription(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/pokemon-species/$id'));
    if (response.statusCode != 200) {
      throw Exception('Falha ao buscar a descrição (status ${response.statusCode})');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final entries = json['flavor_text_entries'] as List<dynamic>;

    final entry = entries.cast<Map<String, dynamic>?>().firstWhere(
          (e) => (e?['language'] as Map<String, dynamic>?)?['name'] == 'en',
          orElse: () => null,
        );

    if (entry == null) return 'Sem descrição.';
    final text = entry['flavor_text'] as String;
    return text.replaceAll('\n', ' ').replaceAll('\f', ' ');
  }
}
