import 'package:flutter/material.dart';
import 'package:we_chat/resources/dimens.dart';

class LeadingView extends StatelessWidget {
  final Function onTap;
  final String text;

  const LeadingView({
    Key? key,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        children: [
          const SizedBox(
            width: marginMedium2,
          ),
          const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          const SizedBox(
            width: marginMedium,
          ),
          Text(text),
        ],
      ),
    );
  }
}
