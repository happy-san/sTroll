import 'dart:math';
import 'package:flutter/material.dart';

class LayoutHelper {
  static const double borderRadiusMultiplier = 0.03, iconSizeMultiplier = 0.1;

  final double height, width;

  /// Returns either height or width of the [RenderBox], whichever is smaller.
  static double getVideoContainerSize(BoxConstraints constraints) {
    final width = constraints.biggest.width;
    final height = constraints.biggest.height;

    return min(width, height);
  }

  const LayoutHelper._({this.height, this.width});

  factory LayoutHelper.of(BuildContext context) {
    final mq = MediaQuery.of(context);
    final height = mq.size.height - mq.padding.top - mq.padding.bottom,
        width = mq.size.width - mq.padding.left - mq.padding.right;

    return LayoutHelper._(height: height, width: width);
  }
}
