import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:video_player/video_player.dart';
import 'package:glass_kit/glass_kit.dart';

import '../../../ui/layout_helper.dart';
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

    final URL = widget.videoURL;
    if (URL != null || URL.isNotEmpty) {
      // Checking validity of the url.
      http.head(URL).then((response) {
        if (response.statusCode == 200) {
          _controller = VideoPlayerController.network(URL)
            ..initialize().then(
              (_) {
                // Ensure the first frame is shown after the video is initialized,
                // even before the play button has been pressed.
                setState(() {});
              },
            )
            ..setLooping(true);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _iconSize = widget.size * LayoutHelper.iconSizeMultiplier,
        _borderRadius = widget.size * LayoutHelper.borderRadiusMultiplier;

    return Stack(
      children: [
        SizedBox(
          // Size of VideoContainer + Size of SplashIconButton + padding in icon tray.
          height: widget.size + _iconSize + 6,
        ),

        // Icon tray
        Positioned(
          bottom: 0,
          right: 0,
          left: 0,
          child: GlassContainer(
            width: widget.size,
            height: _iconSize + _borderRadius + 6,
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            alignment: Alignment.bottomCenter,
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(_borderRadius),
              bottomRight: Radius.circular(_borderRadius),
            ),
            gradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.50),
                Colors.white.withOpacity(0.20),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderGradient: LinearGradient(
              colors: [
                Colors.white.withOpacity(0.1),
                Colors.white.withOpacity(0.06),
              ],
              begin: Alignment.topLeft,
              end: Alignment.topRight,
              stops: [0.0, 0.39],
            ),
            blur: 20,
            isFrostedGlass: true,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 3.0),
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
        ),

        // Video Container
        GestureDetector(
          onTap: () {
            if (_controller != null) {
              _controller.value.isPlaying
                  ? _controller.pause()
                  : _controller.play();
            }
          },
          child: VideoContainer(
            child: _controller == null || !_controller.value.initialized
                ? const SizedBox()
                : VideoPlayer(_controller),
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
