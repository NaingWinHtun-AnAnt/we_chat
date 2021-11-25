import 'package:flutter/material.dart';
import 'package:we_chat/resources/dimens.dart';

class IconAndLabelView extends StatelessWidget {
  final IconData icon;
  final String text;
  final Function onTap;

  const IconAndLabelView({
    Key? key,
    required this.icon,
    required this.text,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
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
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
