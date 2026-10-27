import 'package:flutter/material.dart';

import '../theme/hextech.dart';

/// Uma linha de atributo (Ataque, Defesa, Magia, Dificuldade) em escala de 0 a 10.
class InfoBar extends StatelessWidget {
  final String label;
  final int value;
  final Color color;

  const InfoBar({
    super.key,
    required this.label,
    required this.value,
    this.color = Hextech.gold,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          SizedBox(
            width: 96,
            child: Text(label, style: const TextStyle(color: Hextech.textMuted)),
          ),
          // 10 "segmentos": acesos até o valor do atributo.
          for (var i = 1; i <= 10; i++)
            Expanded(
              child: Container(
                height: 10,
                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                color: i <= value ? color : Hextech.surfaceHigh,
              ),
            ),
          SizedBox(
            width: 28,
            child: Text(
              '$value',
              textAlign: TextAlign.right,
              style: const TextStyle(
                color: Hextech.goldLight,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
