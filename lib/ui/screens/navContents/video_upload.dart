import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../providers.dart';
import 'nav_screen_content.dart';
import '../../layout_helper.dart';
import '../../widgets/video_upload_icon_button.dart';
import '../../widgets/videoContainers/video_upload_container.dart';

class VideoUpload extends NavScreenContent {
  const VideoUpload() : super('Upload', Icons.cloud_upload_outlined);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final picker = watch(videoPicker);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Video Placeholder
          LayoutBuilder(
            builder: (_, constraints) => VideoUploadContainer(
              size: LayoutHelper.getVideoContainerSize(constraints),
              videoFile: picker.videoFile,
              isFileExplorerOpen: picker.isWorking,
            ),
          ),

          // Video Selector and Uploader
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Consumer(
                builder:
                    (BuildContext context, ScopedReader watch, Widget child) =>
                        Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20.0),
                      child: ElevatedButton(
                        onPressed: () => picker.selectVideoFile(),
                        child: Text(picker.videoFile != null
                            ? picker.getName(picker.videoFile)
                            : 'Select the Video File'),
                      ),
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
      ),
    );
  }
}
