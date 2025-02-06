import 'package:flutter/material.dart';

class AppAssetImg extends StatelessWidget {
  const AppAssetImg({super.key, required this.imageName, this.fit, this.width, this.height});

  final String imageName;
  final BoxFit? fit;
  final double? width, height;

  @override
  Widget build(BuildContext context) => Image.asset('assets/images/$imageName', fit: fit, width: width, height: height);
}
