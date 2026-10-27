// TODO (Etapa 3): implementar o acesso à PokéAPI.
//
// 1. Adicione o pacote:      flutter pub add http
// 2. Descomente os imports e complete os métodos abaixo.
//
// Documentação da API: https://pokeapi.co/docs/v2

// import 'dart:convert';
// import 'package:http/http.dart' as http;

import '../models/pokemon.dart';

class PokeApiService {
  static const String baseUrl = 'https://pokeapi.co/api/v2';

  /// GET $baseUrl/pokemon/{idOuNome}
  /// Dica: http.get(Uri.parse(...)), confira statusCode == 200,
  /// jsonDecode(response.body) e Pokemon.fromJson(...).
  Future<Pokemon> fetchPokemon(String idOrName) async {
    throw UnimplementedError('Etapa 3: implemente fetchPokemon');
  }

  /// GET $baseUrl/pokemon?limit=151
  /// A resposta só traz nome + url. Use Future.wait para buscar
  /// os detalhes de cada um com fetchPokemon.
  Future<List<Pokemon>> fetchPokedex({int limit = 151, int offset = 0}) async {
    throw UnimplementedError('Etapa 3: implemente fetchPokedex');
  }

  /// GET $baseUrl/pokemon-species/{id}
  /// Procure em "flavor_text_entries" o texto com language.name == 'en'.
  Future<String> fetchDescription(int id) async {
    throw UnimplementedError('Etapa 4: implemente fetchDescription');
  }
}
