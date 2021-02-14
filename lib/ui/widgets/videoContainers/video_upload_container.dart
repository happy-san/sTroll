import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_container.dart';

class VideoFeedContainer extends StatefulWidget {
  final String videoFilePath;
  final double size;
  final Key key;

  const VideoFeedContainer(
      {@required this.videoFilePath, @required this.key, @required this.size})
      : super(key: key);

  @override
  _VideoFeedContainerState createState() => _VideoFeedContainerState();
}

class _VideoFeedContainerState extends State<VideoFeedContainer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFilePath))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      })
      ..setLooping(true);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _controller.value.isPlaying ? _controller.pause() : _controller.play();
      },
      child: VideoContainer(
        child: _controller.value.initialized
            ? VideoPlayer(_controller)
            : const SizedBox(),
        size: widget.size,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
