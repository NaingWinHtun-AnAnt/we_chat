import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';

class IconAndLabelView extends StatelessWidget {
  final IconData icon;
  final String text;

  const IconAndLabelView({
    Key? key,
    required this.icon,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          color: colorGrey2,
        ),
        const SizedBox(
          height: marginMedium,
        ),
        SizedBox(
          width: 60,
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: textRegular,
              fontWeight: FontWeight.w700,
              color: colorGrey2,
            ),
          ),
        ),
      ],
    );
  }
}
