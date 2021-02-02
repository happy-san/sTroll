import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_video/main.dart';

import '../helper.dart';
import '../widgets/video_feed_container.dart';

class VideoFeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
      body: Consumer(
        builder: (_, watch, __) {
          final list = watch(urlsProvider).state;

          if (list.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return ListView.builder(
              itemBuilder: (_, index) => LayoutBuilder(
                builder: (_, constraints) {
                  final fileName = list[index].split("/").last;
                  final baseURL = "https://video-troll.s3.amazonaws.com/";
                  final videoURL = baseURL + fileName;

                  return VideoFeedContainer(
                    key: Key(videoURL),
                    size: getVideoContainerSize(constraints),
                    videoURL: videoURL,
                  );
                },
              ),
              itemCount: list.length,
            );
          }
        },
      ),
    );
  }
}
