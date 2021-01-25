import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'video_container.dart';
import 'splash_icon_button.dart';

class VideoFeedContainer extends StatefulWidget {
  final Widget child;
  final Key key;

  const VideoFeedContainer({this.child, this.key}) : super(key: key);

  @override
  _VideoFeedContainerState createState() => _VideoFeedContainerState();
}

class _VideoFeedContainerState extends State<VideoFeedContainer> {
  final _color = Colors.black12;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        VideoContainer(
          child: widget.child,
        ),
        LayoutBuilder(
          builder: (_, constraints) => Container(
            width: constraints.biggest.width,
            margin: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            decoration: BoxDecoration(
              color: _color,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(constraints.biggest.width * 0.05),
                bottomRight: Radius.circular(constraints.biggest.width * 0.05),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SplashIconButton(
                  key: UniqueKey(),
                  size: constraints.biggest.width * 0.1,
                  icon: Icon(Icons.thumb_up_alt_outlined),
                  onTap: () {},
                ),
                SplashIconButton(
                  key: UniqueKey(),
                  size: constraints.biggest.width * 0.1,
                  icon: Icon(Icons.mode_comment_outlined),
                  onTap: () {},
                ),
                SplashIconButton(
                  key: UniqueKey(),
                  size: constraints.biggest.width * 0.1,
                  icon: Icon(Icons.share_outlined),
                  onTap: () {},
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
