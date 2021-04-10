import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_container.dart';

class VideoUploadContainer extends StatefulWidget {
  final File videoFile;
  final double size;
  final bool isFileExplorerOpen;
  final Key key;

  const VideoUploadContainer(
      {@required this.videoFile,
      @required this.isFileExplorerOpen,
      this.key,
      @required this.size})
      : super(key: key);

  @override
  _VideoUploadContainerState createState() => _VideoUploadContainerState();
}

class _VideoUploadContainerState extends State<VideoUploadContainer> {
  VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    if (!widget.isFileExplorerOpen && widget.videoFile != null) {
      _controller = VideoPlayerController.file(widget.videoFile)
        ..initialize().then((_) {
          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
          setState(() {});
        })
        ..setLooping(true);
    }
  }

  @override
  void dispose() {
    if (_controller != null) _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.videoFile != null && _controller.value.initialized) {
          _controller.value.isPlaying
              ? _controller.pause()
              : _controller.play();
        }
      },
      child: VideoContainer(
        child: widget.videoFile != null && _controller.value.initialized
            ? VideoPlayer(_controller)
            : widget.isFileExplorerOpen
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: const CircularProgressIndicator(),
                  )
                : Icon(
                    Icons.video_collection,
                    size: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.grey,
                  ),
        size: widget.size,
      ),
    );
  }
}
