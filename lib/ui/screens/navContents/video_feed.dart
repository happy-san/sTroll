import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers.dart';
import 'nav_screen_content.dart';
import '../../layout_helper.dart';
import '../../widgets/videoContainers/video_feed_container.dart';

class VideoFeed extends NavScreenContent {
  const VideoFeed() : super('Feed', Icons.home_outlined);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(urlsProvider).state;

    if (list.isEmpty)
      return Center(
        child: CircularProgressIndicator(),
      );
    else
      return ListView.separated(
        separatorBuilder: (_, __) => Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
        ),
        itemBuilder: (_, index) => LayoutBuilder(
          builder: (_, constraints) {
            try {
              final fileName = list[index].split("/").last,
                  baseURL = "https://video-troll.s3.amazonaws.com/",
                  videoURL = baseURL + fileName;

              return Padding(
                // Last VideoFeedContainer must not be overlapped by bottom nav bar
                padding: index == list.length - 1
                    ? const EdgeInsets.only(bottom: kBottomNavigationBarHeight)
                    : const EdgeInsets.all(0),
                child: VideoFeedContainer(
                  key: Key(videoURL),
                  size: LayoutHelper.getVideoContainerSize(constraints),
                  videoURL: videoURL,
                ),
              );
            } catch (e) {
              return VideoFeedContainer(
                key: UniqueKey(),
                size: LayoutHelper.getVideoContainerSize(constraints),
                videoURL: null,
              );
            }
          },
        ),
        itemCount: list.length,
      );
  }
}
