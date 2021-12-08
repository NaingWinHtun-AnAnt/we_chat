import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/widgets/input_text_view.dart';

class RegionInputView extends StatelessWidget {
  final String label;
  final String text;
  final Function onTap;

  const RegionInputView({
    Key? key,
    required this.label,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            Expanded(
              flex: 1,
              child: InputTextView(
                text: label,
              ),
            ),
            const SizedBox(
              width: marginMedium2,
            ),
            Flexible(
              flex: 2,
              child: GestureDetector(
                onTap: () => onTap(),
                child: InputTextView(text: text),
              ),
            ),
          ],
        ),
        const Divider(
          color: colorGrey,
        ),
      ],
    );
  }
}
