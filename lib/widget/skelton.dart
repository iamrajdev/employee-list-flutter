import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Skelton extends StatelessWidget {
  final double height;
  final double width;
  final ShapeBorder shape;

  const Skelton.rectangular(
      {Key? key,
      required this.height,
      this.width = double.infinity,
      this.shape = const RoundedRectangleBorder()})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Container(
          height: height,
          width: width,
          decoration: ShapeDecoration(
            shape: shape,
            color: Colors.grey[300]!,
          ),
        ),
      ),
    );
  }
}
