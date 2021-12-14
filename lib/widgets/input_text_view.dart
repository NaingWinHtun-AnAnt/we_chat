import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';

class InputTextView extends StatelessWidget {
  final String text;

  const InputTextView({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: textRegular2x,
        color: colorWhite,
      ),
    );
  }
}
