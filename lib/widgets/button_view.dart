import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';

class ButtonView extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Function onTap;

  const ButtonView({
    Key? key,
    required this.text,
    required this.backgroundColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: marginXLarge,
          vertical: marginCardMedium2,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: backgroundColor,
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: textRegular3x,
            color: colorWhite,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}
