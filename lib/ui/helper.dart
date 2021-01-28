import 'package:flutter/material.dart';

const double borderRadiusMultiplier = 0.03;
const double iconSizeMultiplier = 0.1;

/// Returns either height or width of the [RenderBox], whichever is smaller.
double getVideoContainerSize(BoxConstraints constraints) {
  final height = constraints.biggest.height;
  final width = constraints.biggest.width;

  return height > width ? width : height;
}
