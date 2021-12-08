import 'package:flutter/material.dart';
import 'package:we_chat/resources/strings.dart';

class ORView extends StatelessWidget {
  const ORView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        Text(
          labelOr,
        ),
      ],
    );
  }
}
