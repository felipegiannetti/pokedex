import 'package:material_ui/material_ui.dart';

import 'screens/pokedex_screen.dart';
import 'theme/type_colors.dart';

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
      title: 'Pokédex',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: pokedexRed,
        useMaterial3: true,
      ),
      home: const PokedexScreen(),
    );
  }
}
