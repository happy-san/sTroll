import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

import '../../core/services/upload_service.dart';
import '../helper.dart';
import '../widgets/video_container.dart';

class VideoUploadTab extends StatefulWidget {
  @override
  _VideoUploadTabState createState() => _VideoUploadTabState();
}

class _VideoUploadTabState extends State<VideoUploadTab> {
  String _fileName;
  PlatformFile _file;
  String _extension;
  bool _showVideoPreview = false;
  TextEditingController _controller = TextEditingController();
  bool _isUploading = false;
  VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() => _extension = _controller.text);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    _videoController.dispose();
  }

  void _openFileExplorer() async {
    setState(() {
      _showVideoPreview = false;
    });
    try {
      _file = (await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files
          ?.first;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      if (_file != null) {
        _fileName = _file.name.toString();

        _videoController = VideoPlayerController.file(File(_file.path))
          ..initialize().then((_) {
            // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
            setState(() {
              _showVideoPreview = true;
            });
          });
      } else {
        _fileName = '...';
      }
    });
  }

  List<String> _getFileInfo() => [_file.name, _file.path.toString()];

  uploadFile(List<String> fileInfo) {
    _isUploading = true;
    UploadService.uploadVideoFile(fileInfo.first, fileInfo.last).then((value) {
      print(value);
      _isUploading = false;
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
                          ? AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController),
                            )
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
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: OutlineButton(
                            onPressed: () =>
                                _fileName != null ? null : _openFileExplorer(),
                            child: Text(_fileName != null
                                ? _getFileInfo()[0]
                                : 'Select the Video File'),
                            borderSide: BorderSide(color: Colors.blue),
                            shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0))),
                      ),
                      _file != null
                          ? !_isUploading
                              ? IconButton(
                                  padding: EdgeInsets.all(0),
                                  onPressed: () => uploadFile(_getFileInfo()),
                                  icon: Icon(
                                    Icons.upload_outlined,
                                    color: Colors.blue,
                                  ),
                                )
                              : const CircularProgressIndicator()
                          : const SizedBox(),
                    ],
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
