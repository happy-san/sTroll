import 'package:flutter/material.dart';
import 'package:flutter_video/core/service.dart';
import 'package:flutter_video/ui/widgets/video_feed_container.dart';

class VideoFeedTab extends StatefulWidget {
  @override
  _VideoFeedTabState createState() => _VideoFeedTabState();
}

class _VideoFeedTabState extends State<VideoFeedTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('sTroll feed'),
        ),
        body: FutureBuilder(
          future: UploadService.listVideoFiles(),
          builder:
              (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
            if (!snapshot.hasData)
              return Center(child: CircularProgressIndicator());
            var data = snapshot.data;
            return ListView.builder(
              itemBuilder: (_, index) => LayoutBuilder(
                builder: (_, constraints) {
                  String fileName = data[index].split("/").last;
                  String URL_PREFIX = "https://video-troll.s3.amazonaws.com/";
                  String fileURL = URL_PREFIX + fileName;
                  return VideoFeedContainer(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(fileURL),
                    ),
                    size: constraints.biggest.width,
                  );
                },
              ),
              itemCount: snapshot.data.length,
            );
          },
        ));
  }
}
