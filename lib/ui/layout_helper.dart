import 'package:flutter/material.dart';

class LayoutHelper {
  final double borderRadiusMultiplier = 0.03;
  final double iconSizeMultiplier = 0.1;

  /// Returns either height or width of the [RenderBox], whichever is smaller.
  double getVideoContainerSize(BoxConstraints constraints) {
    final width = constraints.biggest.width;
    final height = constraints.biggest.height;

    return width < height ? width : height;
  }
}
