import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';
import 'package:we_chat/widgets/input_text_view.dart';

class TextInputView extends StatelessWidget {
  final String label;
  final String hint;
  final Function(String) onTextChange;
  final TextInputType inputType;
  final bool isObscure;

  const TextInputView({
    Key? key,
    required this.label,
    required this.hint,
    required this.onTextChange,
    this.inputType = TextInputType.text,
    this.isObscure = false,
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
              flex: 3,
              child: TextField(
                obscureText: isObscure,
                keyboardType: inputType,
                decoration: InputDecoration(
                  hintText: hint,
                  hintStyle: const TextStyle(
                    fontSize: textRegular2x,
                    color: colorGrey,
                  ),
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                  border: const OutlineInputBorder(
                    borderSide: BorderSide.none,
                  ),
                ),
                style: const TextStyle(
                  fontSize: textRegular3x,
                  color: colorWhite,
                ),
                onChanged: (value) => onTextChange(value),
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
