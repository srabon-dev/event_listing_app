import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shimmer/shimmer.dart';

class CustomNetworkImage extends StatelessWidget {
  final String? imageUrl;
  final double? height;
  final double? width;
  final Border? border;
  final BorderRadius? borderRadius;
  final BoxShape boxShape;
  final Color? backgroundColor;
  final Widget? child;
  final Widget? errorWidget;
  final ColorFilter? colorFilter;
  final BoxFit? fit;

  const CustomNetworkImage({
    super.key,
    this.child,
    this.errorWidget,
    this.colorFilter,
    this.imageUrl = "https://picsum.photos/450/300",
    this.backgroundColor,
    this.height,
    this.width,
    this.border,
    this.borderRadius,
    this.fit,
    this.boxShape = BoxShape.rectangle,
  });

  bool get isSvg => imageUrl?.toLowerCase().endsWith(".svg") ?? false;

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return CachedNetworkImage(
        height: height,
        width: width,
        imageUrl: "https://picsum.photos/450/300",
        fit: BoxFit.cover,
      );
    }

    if (isSvg) {
      return Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          color: backgroundColor ?? Colors.grey.withOpacity(0.2),
          shape: boxShape,
        ),
        child: SvgPicture.network(
          imageUrl ?? "",
          fit: fit ?? BoxFit.cover,
          colorFilter: colorFilter,
          placeholderBuilder: (context) => shimmerPlaceholder(),
          height: height,
          width: width,
        ),
      );
    }

    return CachedNetworkImage(
      imageUrl: imageUrl ?? "https://picsum.photos/450/300",
      fit: fit,
      imageBuilder: (context, imageProvider) => Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          border: border,
          borderRadius: borderRadius,
          shape: boxShape,
          color: backgroundColor,
          image: DecorationImage(image: imageProvider, fit: BoxFit.cover, colorFilter: colorFilter),
        ),
        child: child,
      ),
      placeholder: (context, url) => Shimmer.fromColors(
          baseColor: Colors.grey.withValues(alpha: 0.6),
          highlightColor: Colors.grey.withValues(alpha: 0.3),
          child: Container(
            height: height,
            width: width,
            decoration: BoxDecoration(
              border: border,
              color: Colors.grey.withValues(alpha: 0.6),
              borderRadius: borderRadius,
              shape: boxShape,
            ),
          )),
      errorWidget: (context, url, error){
        return errorWidget??Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            border: border,
            color: Colors.grey.withValues(alpha: 0.6),
            borderRadius: borderRadius,
            shape: boxShape,
          ),
          child: const Icon(Icons.error),
        );
      },
    );
  }

  Widget shimmerPlaceholder() => Shimmer.fromColors(
    baseColor: Colors.grey.withValues(alpha: 0.6),
    highlightColor: Colors.grey.withValues(alpha: 0.3),
    child: Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        border: border,
        color: Colors.grey.withValues(alpha: 0.6),
        borderRadius: borderRadius,
        shape: boxShape,
      ),
    ),
  );
}
