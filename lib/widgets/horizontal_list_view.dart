import 'package:flutter/material.dart';

class HorizontalListView extends StatelessWidget {
  final int itemCount;
  final double height;
  final IndexedWidgetBuilder itemBuilder;
  final bool? shrinkWrap;
  final ScrollPhysics? physics;
  final EdgeInsetsGeometry? padding;

  const HorizontalListView({
    required this.itemCount,
    required this.itemBuilder,
    required this.height,
    this.padding,
    this.shrinkWrap = false,
    this.physics,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        shrinkWrap: shrinkWrap ?? false,
        scrollDirection: Axis.horizontal,
        physics: physics,
        padding: padding,
        itemCount: itemCount,
        itemBuilder: itemBuilder,
      ),
    );
  }
}
