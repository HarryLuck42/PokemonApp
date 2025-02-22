import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final int? maxLines;
  final TextAlign textAlign;
  final TextStyle? textStyle;
  final String textToDisplay;
  final TextOverflow? textOverflow;

  const CustomText({
    super.key,
    this.maxLines,
    this.textStyle,
    this.textOverflow,
    required this.textToDisplay,
    this.textAlign = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      textToDisplay,
      style: textStyle,
      maxLines: maxLines,
      textAlign: textAlign,
      overflow: textOverflow ?? TextOverflow.ellipsis,
    );
  }
}
