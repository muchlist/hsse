import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hsse/config/config.dart';

class CachedImage extends StatelessWidget {
  const CachedImage(
      {required this.urlPath, this.width = 125.0, this.height = 125.0});
  final String urlPath;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlPath,
      imageBuilder:
          (BuildContext context, ImageProvider<Object> imageProvider) =>
              ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: SizedBox(
          width: width,
          height: height,
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (BuildContext context, String url) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient: const LinearGradient(
                colors: <Color>[Colors.white, TColor.background],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: <double>[0.0, 1.0]),
            borderRadius: BorderRadius.circular(5.0)),
      ),
      errorWidget: (BuildContext context, String url, _) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(5.0)),
        child: const Center(child: Icon(Icons.error)),
      ),
    );
  }
}
