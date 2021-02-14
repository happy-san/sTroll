import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_container.dart';

class VideoUploadContainer extends StatelessWidget {
  final File videoFile;
  final double size;
  final bool isFileExplorerOpen;
  final Key key;
  final VideoPlayerController controller;

  const VideoUploadContainer(
      {@required this.videoFile,
      @required this.isFileExplorerOpen,
      @required this.controller,
      this.key,
      @required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (videoFile != null && controller.value.initialized) {
          controller.value.isPlaying ? controller.pause() : controller.play();
        }
      },
      child: VideoContainer(
        child: videoFile != null && controller.value.initialized
            ? VideoPlayer(controller)
            : isFileExplorerOpen
                ? const CircularProgressIndicator()
                : Icon(
                    Icons.video_collection,
                    size: MediaQuery.of(context).size.width * 0.9,
                    color: Colors.grey,
                  ),
        size: size,
      ),
    );
  }
}
