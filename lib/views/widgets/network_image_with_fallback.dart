import 'package:flutter/material.dart';


// NetworkImageWithFallback functions as a widget to handle image errors when
// main imageUrl is the error url or image not found or other error
class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final String placeholderAsset;
  final double height;
  final double width;
  final BoxFit fit;

  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.placeholderAsset,
    required this.height,
    required this.width,
    required this.fit,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: placeholderAsset,
      image: imageUrl,
      height: height,
      width: width,
      fit: fit,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(
          placeholderAsset,
          height: height,
          width: width,
          fit: fit,
        );
      },
    );
  }
}
