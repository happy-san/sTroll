import 'dart:io';

import 'package:flutter/material.dart';
import 'package:toast/toast.dart';
import 'package:video_player/video_player.dart';

import '../../core/services/api.dart';
import '../../core/services/file_explorer.dart';
import '../helper.dart';
import '../widgets/video_container.dart';

class VideoUploadTab extends StatefulWidget {
  const VideoUploadTab();

  @override
  _VideoUploadTabState createState() => _VideoUploadTabState();
}

class _VideoUploadTabState extends State<VideoUploadTab> {
  File _selectedFile;
  bool _showVideoPreview = false;
  bool _isUploading = false;
  VideoPlayerController _videoController;

  @override
  void dispose() {
    super.dispose();
    _videoController.dispose();
  }

  List<String> _getFileInfo() =>
      [FileExplorer().getName(_selectedFile), _selectedFile.path];

  uploadFile(List<String> fileInfo) {
    setState(() {
      _isUploading = true;
    });
    Api()
        .uploadVideoFile(videoName: fileInfo.first, videoPath: fileInfo.last)
        .then((value) {
      print(value);
      setState(() {
        _isUploading = false;
        Toast.show("File Uploaded!!", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      });
    }).catchError((error) {
      Toast.show("Error Occurred while uploading!", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    });
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    if (_showVideoPreview) {
                      setState(() {
                        _videoController.value.isPlaying
                            ? _videoController.pause()
                            : _videoController.play();
                      });
                    }
                  },
                  child: LayoutBuilder(
                    builder: (_, constraints) => VideoContainer(
                      size: getVideoContainerSize(constraints),
                      child: _showVideoPreview
                          ? VideoPlayer(_videoController)
                          : Icon(
                              Icons.video_collection,
                              size: MediaQuery.of(context).size.width * 0.9,
                              color: Colors.grey,
                            ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: OutlineButton(
                              onPressed: () async {
                                setState(() {
                                  _showVideoPreview = false;
                                });

                                // TODO: Show toast of failure when null is returned.
                                _selectedFile =
                                    await FileExplorer().openFileExplorer();

                                _videoController =
                                    VideoPlayerController.file(_selectedFile)
                                      ..initialize().then((_) {
                                        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
                                        setState(() {
                                          _showVideoPreview = true;
                                        });
                                      })
                                      ..setLooping(true);
                              },
                              child: Text(_selectedFile != null
                                  ? _getFileInfo()[0]
                                  : 'Select the Video File'),
                              borderSide: BorderSide(color: Colors.blue),
                              shape: new RoundedRectangleBorder(
                                  borderRadius:
                                      new BorderRadius.circular(30.0))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: _selectedFile != null
                              ? !_isUploading
                                  ? IconButton(
                                      padding: EdgeInsets.all(0),
                                      onPressed: () =>
                                          uploadFile(_getFileInfo()),
                                      icon: Icon(
                                        Icons.upload_outlined,
                                        color: Colors.blue,
                                      ),
                                    )
                                  : const CircularProgressIndicator()
                              : const SizedBox(),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
