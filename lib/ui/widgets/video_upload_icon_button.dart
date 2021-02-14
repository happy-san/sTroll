import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:toast/toast.dart';

import '../../main.dart';
import 'splash_icon_button.dart';

class VideoUploadIconButton extends ConsumerWidget {
  final String videoName;
  final String videoPath;
  final double size;

  const VideoUploadIconButton({this.videoName, this.videoPath, this.size});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final layout = watch(layoutHelper);
    final uploader = watch(videoUploader);

    return Padding(
      padding: const EdgeInsets.only(left: 5),
      child: videoName != null
          ? uploader.isWorking
              ? const CircularProgressIndicator()
              : SplashIconButton(
                  size: size * layout.iconSizeMultiplier,
                  onTap: () async {
                    var uploadSuccessful = await uploader.uploadVideoFile(
                        videoName: videoName, videoPath: videoPath);
                    if (uploadSuccessful) {
                      Toast.show("File Uploaded!!", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    } else {
                      Toast.show("Error Occurred while uploading!", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    }
                  },
                  icon: Icon(
                    Icons.upload_outlined,
                    color: Colors.blue,
                  ),
                )
          : const SizedBox(),
    );
  }
}
