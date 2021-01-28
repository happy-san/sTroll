import 'package:flutter/material.dart';

import '../helper.dart';
import '../../core/service.dart';
import '../widgets/video_feed_container.dart';

class VideoFeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sTroll feed'),
      ),
      body: FutureBuilder(
        future: UploadService.listVideoFiles(),
        builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            var data = snapshot.data;

            return ListView.builder(
              itemBuilder: (_, index) => LayoutBuilder(
                builder: (_, constraints) {
                  final fileName = data[index].split("/").last;
                  final baseURL = "https://video-troll.s3.amazonaws.com/";
                  final videoURL = baseURL + fileName;

                  return VideoFeedContainer(
                    key: Key(videoURL),
                    size: getVideoContainerSize(constraints),
                    videoURL: videoURL,
                  );
                },
              ),
              itemCount: data.length,
            );
          } else {
            return Text("OOPssss!");
          }
        },
      ),
    );
  }
}
