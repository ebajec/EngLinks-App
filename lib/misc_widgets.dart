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

class AlignedBar extends StatelessWidget {
  const AlignedBar({
    super.key,
    required this.width,
  });

  final double width;
  final Alignment alignment = Alignment.centerLeft;
  final Color color = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: width,
        child: Divider(
          color: color, //color of divider
          height: 5, //height spacing of divider
          thickness: 3, //thickness of divider line
          indent: 5, //spacing at the start of divider
          endIndent: 15, //spacing at the end of divider
        ),
      ),
    );
  }
}
