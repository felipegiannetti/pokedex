import 'package:flutter/material.dart';

import 'screens/champion_list_screen.dart';
import 'theme/hextech.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // O MaterialApp cria o Navigator (a "pilha" de telas).
    // A tela em `home` é a primeira da pilha.
    return MaterialApp(
      title: 'App de Campeões de LOL',
      debugShowCheckedModeBanner: false,
      theme: Hextech.theme,
      home: const ChampionListScreen(),
    );
  }
}
