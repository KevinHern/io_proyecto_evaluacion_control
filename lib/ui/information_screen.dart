import 'package:flutter/material.dart';

import 'components/text_card.dart';

class InformationScreen extends StatelessWidget {
  static const double spacing = 8.0;
  const InformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(spacing * 5),
      child: Column(
        children: [
          Text(
            'Información del Proyecto',
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(
            height: spacing,
          ),
          TextCard(
            textSpanList: [
              TextSpan(
                text: "El proyecto fue realizado por:\n"
                    "- Gerson Alay\n"
                    "- René Castellanos\n"
                    "- Herbert Colindres\n"
                    "- Kevin Hernández\n"
                    "- Fredy Marroquín\n",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
