import '../models/champion.dart';

/// Dados ESTÁTICOS para construir e testar o design (Etapas 1 e 2),
/// antes de existir qualquer chamada de rede.
///
/// Os campos seguem o formato de cada campeão no champion.json do
/// Data Dragon (id, name, title, blurb, tags, info). Os textos e os
/// atributos aqui são resumos aproximados: a API traz os oficiais.
const List<Champion> championsMock = [
  Champion(
    id: 'Ahri',
    name: 'Ahri',
    title: 'a Raposa de Nove Caudas',
    blurb: 'Uma vastaya ligada à magia espiritual de Runeterra, que '
        'manipula emoções e absorve as memórias de quem encontra.',
    tags: ['Mage', 'Assassin'],
    attack: 3,
    defense: 4,
    magic: 8,
    difficulty: 5,
  ),
  Champion(
    id: 'Ashe',
    name: 'Ashe',
    title: 'a Arqueira do Gelo',
    blurb: 'Líder de Freljord, dispara flechas de gelo e sonha em unir '
        'as tribos de sua terra congelada.',
    tags: ['Marksman', 'Support'],
    attack: 7,
    defense: 3,
    magic: 2,
    difficulty: 4,
  ),
  Champion(
    id: 'Garen',
    name: 'Garen',
    title: 'o Poder de Demacia',
    blurb: 'Soldado orgulhoso da vanguarda demaciana, enfrenta a magia '
        'com armadura pesada e uma espada giratória.',
    tags: ['Fighter', 'Tank'],
    attack: 7,
    defense: 7,
    magic: 1,
    difficulty: 5,
  ),
  Champion(
    id: 'Jinx',
    name: 'Jinx',
    title: 'o Gatilho Desenfreado',
    blurb: 'Criminosa imprevisível de Zaun, espalha caos por Piltover '
        'com um arsenal barulhento e muitas explosões.',
    tags: ['Marksman'],
    attack: 9,
    defense: 2,
    magic: 4,
    difficulty: 6,
  ),
  Champion(
    id: 'LeeSin',
    name: 'Lee Sin',
    title: 'o Monge Cego',
    blurb: 'Mestre das artes marciais de Ionia que perdeu a visão, mas '
        'luta guiado pela energia espiritual ao seu redor.',
    tags: ['Fighter', 'Assassin'],
    attack: 8,
    defense: 5,
    magic: 3,
    difficulty: 6,
  ),
  Champion(
    id: 'Lux',
    name: 'Lux',
    title: 'a Dama da Luz',
    blurb: 'Maga demaciana que controla a luz, escondendo seu dom em um '
        'reino que desconfia de qualquer magia.',
    tags: ['Mage', 'Support'],
    attack: 2,
    defense: 4,
    magic: 9,
    difficulty: 5,
  ),
  Champion(
    id: 'Thresh',
    name: 'Thresh',
    title: 'o Guardião das Correntes',
    blurb: 'Espírito sombrio das Ilhas das Sombras que aprisiona almas '
        'em sua lanterna e puxa inimigos com correntes.',
    tags: ['Support', 'Fighter'],
    attack: 5,
    defense: 6,
    magic: 6,
    difficulty: 7,
  ),
  Champion(
    id: 'Yasuo',
    name: 'Yasuo',
    title: 'o Imperdoável',
    blurb: 'Espadachim de Ionia acusado de um crime que não cometeu, '
        'domina o vento para provar sua inocência.',
    tags: ['Fighter', 'Assassin'],
    attack: 8,
    defense: 4,
    magic: 4,
    difficulty: 10,
  ),
];
