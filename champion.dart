/// Endereço da CDN do Data Dragon (API estática da Riot Games).
const String ddragonCdn = 'https://ddragon.leagueoflegends.com/cdn';

/// Versão usada no roteiro. A versão mais recente pode ser obtida em
/// https://ddragon.leagueoflegends.com/api/versions.json
const String ddragonVersion = '13.7.1';

/// Modelo de dados de um campeão.
///
/// A MESMA classe atende às duas fontes de dados da aula:
///  * dados estáticos  -> construtor `const Champion(...)` (data/champions_mock.dart)
///  * Data Dragon      -> construtor de fábrica `Champion.fromJson(...)`
class Champion {
  final String id; // 'LeeSin': usado nas URLs de imagem
  final String name; // 'Lee Sin': usado na tela
  final String title;
  final String blurb;
  final List<String> tags; // ['Fighter', 'Assassin']

  // Atributos de 0 a 10 (objeto "info" do JSON).
  final int attack;
  final int defense;
  final int magic;
  final int difficulty;

  /// Versão do Data Dragon de onde o campeão veio (usada na URL do ícone).
  final String version;

  const Champion({
    required this.id,
    required this.name,
    required this.title,
    required this.blurb,
    this.tags = const [],
    this.attack = 0,
    this.defense = 0,
    this.magic = 0,
    this.difficulty = 0,
    this.version = ddragonVersion,
  });

  // ---------- Etapa 4: imagens ----------
  // No roteiro, imageUrl é montada dentro do fromJson. Aqui ela é um getter:
  // assim os dados ESTÁTICOS também ganham imagem, sem repetir a URL.

  /// Ícone quadrado (120 x 120).
  String get imageUrl => '$ddragonCdn/$version/img/champion/$id.png';

  /// Arte de fundo (splash). Não depende da versão.
  String get splashUrl => '$ddragonCdn/img/champion/splash/${id}_0.jpg';

  // ---------- Etapa 3: JSON da API -> objeto Dart ----------

  /// Converte um item de data{} do champion.json em um Champion.
  /// O operador ?? define um valor padrão se o campo vier nulo.
  factory Champion.fromJson(Map<String, dynamic> json) {
    final Map<String, dynamic> info = json['info'] ?? const {};
    return Champion(
      id: json['id'] ?? '',
      name: json['name'] ?? 'Nome não disponível',
      title: json['title'] ?? 'Título não disponível',
      blurb: json['blurb'] ?? 'Descrição não disponível',
      tags: List<String>.from(json['tags'] ?? const []),
      attack: info['attack'] ?? 0,
      defense: info['defense'] ?? 0,
      magic: info['magic'] ?? 0,
      difficulty: info['difficulty'] ?? 0,
      version: json['version'] ?? ddragonVersion,
    );
  }
}
