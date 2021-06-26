import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:hsse/config/config.dart';

class CachedImage extends StatelessWidget {
  final String urlPath;
  final double width;
  final double height;

  const CachedImage(
      {required this.urlPath, this.width = 125.0, this.height = 125.0});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: urlPath,
      imageBuilder: (context, imageProvider) => ClipRRect(
        borderRadius: BorderRadius.circular(5.0),
        child: Container(
          width: width,
          height: height,
          child: Image(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      placeholder: (context, url) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: <Color>[Colors.white, TColor.background],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.0, 1.0]),
            borderRadius: BorderRadius.circular(5.0)),
      ),
      errorWidget: (context, url, error) => Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
            color: Colors.grey, borderRadius: BorderRadius.circular(5.0)),
        child: Center(child: Icon(Icons.error)),
      ),
    );
  }
}
