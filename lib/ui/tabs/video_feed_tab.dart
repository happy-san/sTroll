import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../main.dart';
import '../../ui/layout_helper.dart';
import '../widgets/videoContainers/video_feed_container.dart';

class VideoFeedTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final list = watch(urlsProvider).state;

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Hero(
                tag: 'hero',
                child: FlutterLogo(),
              ),
            ),
            Text('sTroll feed'),
          ],
        ),
      ),
      body: (list.isEmpty)
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 6),
              child: ListView.separated(
                separatorBuilder: (_, __) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3),
                ),
                itemBuilder: (_, index) => LayoutBuilder(
                  builder: (_, constraints) {
                    final fileName = list[index].split("/").last;
                    final baseURL = "https://video-troll.s3.amazonaws.com/";
                    final videoURL = baseURL + fileName;

                    return VideoFeedContainer(
                      key: Key(videoURL),
                      size: LayoutHelper.getVideoContainerSize(constraints),
                      videoURL: videoURL,
                    );
                  },
                ),
                itemCount: list.length,
              ),
            ),
    );
  }
}
