import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

///------------ Cache network image used for caching the image from url
class CommonCachedNetworkImage extends StatelessWidget {
  final String imgUrl;
  final double? height;
  final double? width;
  final double? shimmerRadius;
  final BoxFit? boxFit;
  const CommonCachedNetworkImage({super.key,required this.imgUrl,this.height,this.width,this.boxFit,this.shimmerRadius});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imgUrl,
      height: height,
      width: width,
      fit: boxFit,
      placeholder: (context, url) => SizedBox(
        width: width,
        height: height,
        child: Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.grey,
          child: CircleAvatar(
            radius: shimmerRadius,
            backgroundColor: Colors.white,
          ),
        ),
      ),
      errorWidget: (context, url, error) => const Icon(Icons.error),
    );
  }
}
