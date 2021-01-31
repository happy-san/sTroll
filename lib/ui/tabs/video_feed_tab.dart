import 'dart:math';

import 'package:flutter/material.dart';

import '../../core/services/api.dart';
import '../helper.dart';
import '../widgets/video_feed_container.dart';

class VideoFeedTab extends StatefulWidget {
  @override
  _VideoFeedTabState createState() => _VideoFeedTabState();
}

class _VideoFeedTabState extends State<VideoFeedTab> {
  bool isLoading = false;
  int currentLength = 3;
  List videoData = [];
  bool initialLoader = true;

  void initialFetchData() {
    Api().listVideoFiles().then((value) {
      setState(() {
        videoData = value;
        initialLoader = false;
      });
    });
  }

  Future _loadData() async {
    await new Future.delayed(new Duration(seconds: 1));
    setState(() {
      currentLength += 2;
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    initialFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('sTroll feed'),
      ),
      body: initialLoader
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: <Widget>[
                Expanded(
                  child: NotificationListener<ScrollNotification>(
                      onNotification: (ScrollNotification scrollInfo) {
                        if (!isLoading &&
                            scrollInfo.metrics.pixels ==
                                scrollInfo.metrics.maxScrollExtent) {
                          _loadData();
                          setState(() {
                            isLoading = true;
                          });
                        }
                      },
                      child: ListView.builder(
                        itemBuilder: (_, index) => LayoutBuilder(
                          builder: (_, constraints) {
                            final fileName = videoData[index].split("/").last;
                            final baseURL =
                                "https://video-troll.s3.amazonaws.com/";
                            final videoURL = baseURL + fileName;

                            return VideoFeedContainer(
                              key: Key(videoURL),
                              size: getVideoContainerSize(constraints),
                              videoURL: videoURL,
                            );
                          },
                        ),
                        itemCount: min(currentLength, videoData.length),
                      )),
                ),
                Container(
                  height: isLoading ? 50.0 : 0,
                  color: Colors.transparent,
                  child: Center(
                    child: new CircularProgressIndicator(),
                  ),
                ),
              ],
            ),
    );
  }
}
