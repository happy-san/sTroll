import 'package:flutter/material.dart';
import 'package:glass_kit/glass_kit.dart';

import '../../../ui/layout_helper.dart';

class VideoContainer extends StatelessWidget {
  final Widget child;
  final double size;
  final Key key;

  const VideoContainer({this.child, this.key, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _borderRadius = size * LayoutHelper.borderRadiusMultiplier;

    return GlassContainer(
      height: size,
      width: size,
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      alignment: Alignment.center,
      gradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.40),
          Colors.white.withOpacity(0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
      borderGradient: LinearGradient(
        colors: [
          Colors.white.withOpacity(0.60),
          Colors.white.withOpacity(0.10),
        ],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        stops: [0.0, 0.39],
      ),
      blur: 20,
      isFrostedGlass: true,
      borderRadius: BorderRadius.circular(_borderRadius),
      elevation: LayoutHelper.tappableElevation,
      child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          clipBehavior: Clip.antiAlias,
          child: child),
    );
  }
}
