import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../ui/layout_helper.dart';

class VideoContainer extends ConsumerWidget {
  final Widget child;
  final double size;
  final Key key;

  const VideoContainer({this.child, this.key, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final _borderRadius = size * LayoutHelper.borderRadiusMultiplier;

    return Container(
      height: size,
      width: size,
      margin: const EdgeInsets.only(left: 8.0, right: 8.0),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(_borderRadius),
      ),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(_borderRadius),
          clipBehavior: Clip.antiAlias,
          child: child),
    );
  }
}
