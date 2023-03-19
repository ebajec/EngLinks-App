import 'package:flutter/material.dart';

class AlignedText extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignment;
  final TextStyle style;

  const AlignedText({
    Key? key,
    required this.text,
    required this.alignment,
    this.style = const TextStyle(),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text, style: style),
      ),
    );
  }
}
