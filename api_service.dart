import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/champion.dart';

/// Erro com mensagem amigável para a interface mostrar.
class ApiException implements Exception {
  final String message;
  const ApiException(this.message);

  @override
  String toString() => message;
}

/// Toda a comunicação com o Data Dragon fica aqui.
/// As telas não conhecem URL, HTTP nem JSON: só pedem objetos Champion.
class ApiService {
  static const String _baseUrl = 'https://ddragon.leagueoflegends.com';
  static const Duration _timeout = Duration(seconds: 15);

  /// 'en_US' no roteiro original; 'pt_BR' traz títulos e textos em português.
  final String language;
  final http.Client _client;

  ApiService({this.language = 'pt_BR', http.Client? client})
      : _client = client ?? http.Client();

  Future<http.Response> _get(String url) async {
    try {
      final response = await _client.get(Uri.parse(url)).timeout(_timeout);
      if (response.statusCode != 200) {
        throw ApiException(
            'Falha ao carregar campeões (HTTP ${response.statusCode}).');
      }
      return response;
    } on TimeoutException {
      throw const ApiException('O servidor demorou demais para responder.');
    } on ApiException {
      rethrow;
    } catch (_) {
      throw const ApiException('Sem conexão com a internet?');
    }
  }

  /// Desafio: em vez de fixar '13.7.1', descobre a versão mais recente.
  /// versions.json é uma lista: ["14.x.1", "14.y.1", ...] (a primeira é a atual).
  Future<String> fetchLatestVersion() async {
    final response = await _get('$_baseUrl/api/versions.json');
    final versions = json.decode(response.body) as List<dynamic>;
    return versions.isNotEmpty ? versions.first as String : ddragonVersion;
  }

  /// Etapa 3: busca a lista de campeões.
  Future<List<Champion>> fetchChampions() async {
    final version = await fetchLatestVersion();
    final response = await _get(
        '$_baseUrl/cdn/$version/data/$language/champion.json');

    // utf8.decode(bodyBytes) garante acentos corretos ("Dama da Luz").
    final Map<String, dynamic> data =
        json.decode(utf8.decode(response.bodyBytes));

    // "data" é um MAPA (nome -> campeão), não uma lista: pegamos os valores.
    final List<dynamic> championsData = data['data'].values.toList();

    return championsData.map((json) => Champion.fromJson(json)).toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }
}
