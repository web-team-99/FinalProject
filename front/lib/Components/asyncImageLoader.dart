import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:test_url/Components/customIndicator.dart';
import 'package:test_url/Styles/icons.dart';

class AsyncImageLoader extends StatelessWidget {
  final String imageUrl;

  AsyncImageLoader(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
            // colorFilter: ColorFilter.mode(Colors.red, BlendMode.colorBurn),
          ),
        ),
      ),
      placeholder: (context, url) => CustomIndicator(),
      errorWidget: (context, url, error) => Icon(errorIcon),
    );
  }
}
