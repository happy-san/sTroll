import 'dart:math';
import 'package:flutter/material.dart';

class LayoutHelper {
  static const double borderRadiusMultiplier = 0.03,
      iconSizeMultiplier = 0.1, tappableElevation = 8, tappedElevation = 2;

  /// [height] and [width] of the screen.
  final double height, width;

  /// Returns either height or width of the [RenderBox], whichever is smaller.
  static double getVideoContainerSize(BoxConstraints constraints) =>
      min(constraints.biggest.width, constraints.biggest.height);

  const LayoutHelper._({this.height, this.width});

  factory LayoutHelper.of(BuildContext context) {
    final mq = MediaQuery.of(context);

    return LayoutHelper._(height: mq.size.height, width: mq.size.width);
  }
}
