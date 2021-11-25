import 'package:flutter/material.dart';

class VerticalListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final bool? shrinkWrap;
  final bool? reverse;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const VerticalListView({
    required this.itemCount,
    required this.itemBuilder,
    this.padding,
    this.shrinkWrap = false,
    this.reverse = false,
    this.physics,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      reverse: reverse ?? false,
      shrinkWrap: shrinkWrap ?? false,
      physics: physics,
      padding: padding,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
    );
  }
}
