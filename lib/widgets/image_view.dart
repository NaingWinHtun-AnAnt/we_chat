import 'package:flutter/material.dart';
import 'package:we_chat/resources/strings.dart';

class ImageView extends StatelessWidget {
  final String imageUrl;
  final double? radius;
  final double width;
  final double height;

  const ImageView({
    Key? key,
    required this.imageUrl,
    this.radius,
    required this.width,
    required this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(
        radius ?? 0.0,
      ),
      child: FadeInImage.assetNetwork(
        placeholder: dummyAssetImage,
        image: imageUrl,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
