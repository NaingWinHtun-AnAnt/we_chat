import 'package:flutter/material.dart';
import 'package:we_chat/resources/colors.dart';
import 'package:we_chat/resources/dimens.dart';

class SeparatedVerticalListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final EdgeInsetsGeometry? padding;
  final Color? separatorColor;

  const SeparatedVerticalListView({
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    Key? key,
    this.separatorColor = colorGrey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      separatorBuilder: (BuildContext context, int index) => Divider(
        indent: weChatViewImageSize,
        color: separatorColor,
      ),
    );
  }
}
