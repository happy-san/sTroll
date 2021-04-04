import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';

import '../../main.dart';
import '../../ui/layout_helper.dart';
import '../widgets/video_upload_icon_button.dart';
import '../widgets/videoContainers/video_upload_container.dart';

class VideoUploadTab extends StatefulWidget {
  const VideoUploadTab();

  @override
  _VideoUploadTabState createState() => _VideoUploadTabState();
}

class _VideoUploadTabState extends State<VideoUploadTab> {
  VideoPlayerController _controller;

  @override
  void dispose() {
    super.dispose();
    if (_controller != null) _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          child: SingleChildScrollView(
            child: Consumer(builder:
                (BuildContext context, ScopedReader watch, Widget child) {
              final picker = watch(videoPicker);
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  LayoutBuilder(
                    builder: (_, constraints) => VideoUploadContainer(
                      size: LayoutHelper.getVideoContainerSize(constraints),
                      videoFile: picker.videoFile,
                      isFileExplorerOpen: picker.isWorking,
                      controller: _controller,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Consumer(
                        builder: (BuildContext context, ScopedReader watch,
                                Widget child) =>
                            Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 20.0),
                              child: OutlineButton(
                                  onPressed: () async {
                                    if (await picker.selectVideoFile()) {
                                      _controller = VideoPlayerController.file(
                                          picker.videoFile)
                                        ..initialize().then((_) {
                                          // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                          setState(() {});
                                        })
                                        ..setLooping(true);
                                    }
                                  },
                                  child: Text(picker.videoFile != null
                                      ? picker.getName(picker.videoFile)
                                      : 'Select the Video File'),
                                  borderSide: BorderSide(color: Colors.blue),
                                  shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0))),
                            ),
                            VideoUploadIconButton(
                              size: MediaQuery.of(context).size.width,
                              videoName: picker.videoFile != null
                                  ? picker.getName(picker.videoFile)
                                  : null,
                              videoPath: picker.videoFile?.path,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
