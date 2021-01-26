import 'package:flutter/material.dart';

import '../widgets/video_feed_container.dart';

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
      body: ListView.builder(
        itemBuilder: (_, __) => LayoutBuilder(
          builder: (_, constraints) => VideoFeedContainer(
            child: null,
            size: constraints.biggest.width,
          ),
        ),
        itemCount: 15,
      ),
    );
  }
}
