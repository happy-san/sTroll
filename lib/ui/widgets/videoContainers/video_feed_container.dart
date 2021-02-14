import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../../main.dart';
import 'video_container.dart';
import '../splash_icon_button.dart';

class VideoFeedContainer extends StatefulWidget {
  final String videoURL;
  final double size;
  final Key key;

  const VideoFeedContainer(
      {@required this.videoURL, @required this.key, @required this.size})
      : super(key: key);

  @override
  _VideoFeedContainerState createState() => _VideoFeedContainerState();
}

class _VideoFeedContainerState extends State<VideoFeedContainer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoURL)
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (BuildContext context, ScopedReader watch, Widget child) {
      final _iconSize = widget.size * watch(layoutHelper).iconSizeMultiplier;
      final _borderRadius =
          widget.size * watch(layoutHelper).borderRadiusMultiplier;

      return Stack(
        children: [
          SizedBox(
            // Size of VideoContainer + Size of SplashIconButton
            height: widget.size + _iconSize,
          ),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: Container(
              width: widget.size,
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
          GestureDetector(
            onTap: () {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            },
            child: VideoContainer(
              child: _controller.value.initialized
                  ? VideoPlayer(_controller)
                  : const SizedBox(),
              size: widget.size,
            ),
          ),
        ],
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}