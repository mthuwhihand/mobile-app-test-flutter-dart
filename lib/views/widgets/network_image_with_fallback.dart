import 'package:flutter/material.dart';

class NetworkImageWithFallback extends StatelessWidget {
  final String imageUrl;
  final String placeholderAsset;

  const NetworkImageWithFallback({
    super.key,
    required this.imageUrl,
    required this.placeholderAsset,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInImage.assetNetwork(
      placeholder: placeholderAsset,
      image: imageUrl,
      imageErrorBuilder: (context, error, stackTrace) {
        return Image.asset(placeholderAsset);
      },
    );
  }
}
