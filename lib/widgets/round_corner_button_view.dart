import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';

class RoundCornerButtonView extends StatelessWidget {
  final String? text;
  final bool isGhostButton;
  final Function onTap;

  const RoundCornerButtonView({
    Key? key,
    required this.text,
    this.isGhostButton = false,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        margin: const EdgeInsets.symmetric(
          horizontal: marginMedium2,
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: marginXXLarge,
          vertical: marginCardMedium2,
        ),
        decoration: BoxDecoration(
          color: isGhostButton ? colorWhite : colorPrimary,
          border: Border.all(
            color: colorPrimary,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(buttonBorderRadius),
        ),
        child: Center(
          child: Text(
            text ?? "-",
            style: TextStyle(
              fontSize: textRegular2x,
              color: isGhostButton ? colorPrimary : colorWhite,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
