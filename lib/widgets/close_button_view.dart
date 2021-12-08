import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';

class CloseButtonView extends StatelessWidget {
  final Function onTap;

  const CloseButtonView({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(
        left: marginMedium2,
        top: marginXLarge,
      ),
      child: GestureDetector(
        onTap: () => onTap(),
        child: const Align(
          alignment: Alignment.topLeft,
          child: Icon(
            Icons.close,
            color: colorWhite,
          ),
        ),
      ),
    );
  }
}
