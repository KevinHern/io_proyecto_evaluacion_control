import 'package:flutter/material.dart';

class TextCard extends StatelessWidget {
  final double spacing;
  final List<TextSpan> textSpanList;
  const TextCard({required this.textSpanList, this.spacing = 8.0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(spacing / 2),
        child: RichText(
          text: TextSpan(
            text: '',
            children: textSpanList,
          ),
        ),
      ),
    );
  }
}
