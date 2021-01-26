import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../helper.dart';
import 'video_container.dart';
import 'splash_icon_button.dart';

class VideoFeedContainer extends StatelessWidget {
  final Widget child;
  final double size;
  final Key key;

  const VideoFeedContainer({this.child, this.key, @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _iconSize = size * iconSizeMultiplier;
    final _borderRadius = size * borderRadiusMultiplier;

    return Stack(
      children: [
        SizedBox(
          // Top margin of VideoContainer + Size of VideoContainer + Size of SplashIconButton
          height: 8 + size + _iconSize,
        ),
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: Container(
            width: size,
            height: _iconSize + _borderRadius,
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            alignment: Alignment.bottomCenter,
            decoration: BoxDecoration(
              color: Colors.black12,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(_borderRadius),
                bottomRight: Radius.circular(_borderRadius),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SplashIconButton(
                  key: UniqueKey(),
                  size: _iconSize,
                  icon: const Icon(Icons.thumb_up_alt_outlined),
                  onTap: () {},
                ),
                SplashIconButton(
                  key: UniqueKey(),
                  size: _iconSize,
                  icon: const Icon(Icons.mode_comment_outlined),
                  onTap: () {},
                ),
                SplashIconButton(
                  key: UniqueKey(),
                  size: _iconSize,
                  icon: const Icon(Icons.share_outlined),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
        VideoContainer(
          child: child,
          size: size,
        ),
      ],
    );
  }
}
