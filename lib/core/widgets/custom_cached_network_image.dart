import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'custom_loading_animation.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  const CustomCachedNetworkImage({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.fill,
        imageBuilder: (context, imageProvider) => Image(
          image: imageProvider,
          fit: BoxFit.fill,
        ),
        placeholder: (context, url) =>  const CustomLoadingAnimation(),
        errorWidget: (context, url, error) {
          print(error.toString());
          return  const CustomLoadingAnimation();
        });
  }
}
