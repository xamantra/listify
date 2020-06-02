import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class BetterText extends StatelessWidget {
  final String data;
  final TextStyle style;
  final TextAlign textAlign;
  final int maxLines;
  final int minFontSize;

  const BetterText(
    this.data, {
    Key key,
    this.style,
    this.textAlign,
    this.maxLines,
    this.minFontSize,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(
      data,
      style: style ?? DefaultTextStyle.of(context).style,
      textAlign: textAlign,
      maxLines: maxLines ?? 1,
      minFontSize: minFontSize ?? 1,
    );
  }
}
