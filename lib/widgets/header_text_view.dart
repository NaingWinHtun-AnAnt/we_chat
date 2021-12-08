import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';

class HeaderTextView extends StatelessWidget {
  final String text;

  const HeaderTextView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        color: colorWhite,
        fontWeight: FontWeight.w500,
        fontSize: textHeading2x,
      ),
    );
  }
}
