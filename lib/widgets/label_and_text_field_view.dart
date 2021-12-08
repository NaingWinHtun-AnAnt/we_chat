import 'package:flutter/material.dart';
import 'package:we_chat/resources/dimens.dart';

class LabelAndTextFieldView extends StatelessWidget {
  final String hint;
  final String label;
  final bool isSecure;
  final Function(String) onChanged;

  const LabelAndTextFieldView({
    Key? key,
    required this.hint,
    required this.label,
    required this.onChanged,
    this.isSecure = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: Colors.black),
        ),
        const SizedBox(
          height: marginMedium,
        ),
        TextField(
          onChanged: (text) {
            onChanged(text);
          },
          obscureText: isSecure,
          decoration: InputDecoration(
            hintText: hint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                marginMedium,
              ),
            ),
          ),
        )
      ],
    );
  }
}
