import 'package:flutter/material.dart';
import 'my_styles.dart';

class AlignedText extends StatelessWidget {
  final String text;
  final AlignmentGeometry alignment;
  final TextStyle style;
  final TextAlign textAlign;

  const AlignedText(
      {Key? key,
      required this.text,
      required this.alignment,
      this.style = const TextStyle(),
      this.textAlign = TextAlign.left})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          text,
          style: style,
          textAlign: textAlign,
        ),
      ),
    );
  }
}

class AlignedBar extends StatelessWidget {
  const AlignedBar({
    super.key,
    this.alignment = Alignment.centerLeft,
    required this.width,
  });

  final double width;
  final Alignment alignment;
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

class WideButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const WideButton({
    required this.label,
    required this.onPressed,
    this.height = 50,
    this.textStyle = const TextStyle(),
    this.textAlign = Alignment.center,
  });

  final double height;
  final TextStyle textStyle;
  final Alignment textAlign;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Colors.grey),
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: AlignedText(
              text: label,
              style: textStyle,
              alignment: textAlign,
            ),
          ),
        ),
      ),
    );
  }
}
