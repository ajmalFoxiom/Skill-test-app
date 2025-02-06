import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:test_app/shared/widgets/app_svg.dart';


class CachedImage extends StatelessWidget {
  const CachedImage(
      {super.key,
      this.radius = 6.0,
      required this.imageUrl,
      this.height,
      this.width,
      this.bgClr,
      this.isAssetImg = false,
      this.isPreviewImage = false,
      this.isfileImg = false,
      this.padding,
      this.fit});

  final double radius;
  final String? imageUrl;
  final double? height, width;
  final Color? bgClr;

  final bool isAssetImg, isPreviewImage, isfileImg;
  final EdgeInsetsGeometry? padding;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Container(
        padding: padding,
        color: bgClr ?? Colors.transparent,
        child: isAssetImg
            ? Image.asset(imageUrl ?? "", fit: fit ?? BoxFit.cover)
            : isfileImg
                ? Image.file(
                    File(imageUrl ?? ""),
                    height: height,
                    width: width,
                    fit: BoxFit.cover,
                  )
                : isPreviewImage
                    ? GestureDetector(
                        // onTap: () =>
                        //     previewImage(context, imageUrl: imageUrl ?? ""),
                        child: buildCachedNetworkImage(),
                      )
                    : buildCachedNetworkImage(),
      ),
    );
  }

  CachedNetworkImage buildCachedNetworkImage() {
    return CachedNetworkImage(
        fit: fit ?? BoxFit.cover,
        height: height,
        width: width,
        imageUrl: imageUrl ?? "",
        placeholder: (context, url) =>
            const Center(child: CupertinoActivityIndicator()),
        errorWidget: (context, url, error) => imageUrl == null
            ? const AppSvg(assetName: "user")
            : const AppSvg(assetName: "logo_error"));
  }
}
