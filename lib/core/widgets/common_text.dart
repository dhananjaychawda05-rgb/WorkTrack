import 'package:flutter/material.dart';

class CommonText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? align;
  final Color? color;
  final int? maxLines;
  final TextOverflow? overflow;
  final bool translate;

  const CommonText(
    this.text, {
    super.key,
    this.style,
    this.align,
    this.color,
    this.maxLines,
    this.overflow,
    this.translate = true,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      maxLines: maxLines,
      overflow: overflow,
      style: style?.copyWith(color: color),
    );
  }
}
