import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import '../helper.dart';
import 'video_container.dart';
import 'splash_icon_button.dart';

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
      });
  }

  @override
  Widget build(BuildContext context) {
    final _iconSize = widget.size * iconSizeMultiplier;
    final _borderRadius = widget.size * borderRadiusMultiplier;

    return Stack(
      children: [
        SizedBox(
          // Top margin of VideoContainer + Size of VideoContainer + Size of SplashIconButton
          height: 8 + widget.size + _iconSize,
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
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
            size: widget.size,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
