import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:video_player/video_player.dart';

import 'service.dart';

class VideoUploadTab extends StatefulWidget {
  @override
  _VideoUploadTabState createState() => _VideoUploadTabState();
}

class _VideoUploadTabState extends State<VideoUploadTab> {
  String _fileName;
  List<PlatformFile> _paths;
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
      _paths = (await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
        allowedExtensions: (_extension?.isNotEmpty ?? false)
            ? _extension?.replaceAll(' ', '')?.split(',')
            : null,
      ))
          ?.files;
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }
    if (!mounted) return;
    setState(() {
      if (_paths != null) {
        _fileName = _paths.map((e) => e.name).toString();

        _videoController = VideoPlayerController.file(File(_paths[0].path))
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

  List<String> _getFileInfo() {
    final bool isMultiPath = _paths != null && _paths.isNotEmpty;
    final String name = (isMultiPath
        ? _paths.map((e) => e.name).toList().first
        : _fileName ?? '...');
    final path = _paths.map((e) => e.path).toList().first.toString();
    return [name, path];
  }

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
                Padding(
                  padding: const EdgeInsets.only(top: 50.0, bottom: 20.0),
                  child: LayoutBuilder(
                    builder: (_, constraints) => GestureDetector(
                      onTap: () {
                        if (_showVideoPreview) {
                          setState(() {
                            _videoController.value.isPlaying
                                ? _videoController.pause()
                                : _videoController.play();
                          });
                        }
                      },
                      child: Container(
                        height: constraints.biggest.width,
                        width: constraints.biggest.width,
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(
                              constraints.biggest.width * 0.05),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: _showVideoPreview
                                ? AspectRatio(
                                    aspectRatio:
                                        _videoController.value.aspectRatio,
                                    child: VideoPlayer(_videoController),
                                  )
                                : Icon(
                                    Icons.video_collection,
                                    size: constraints.biggest.width,
                                    color: Colors.grey,
                                  ),
                          ),
                        ),
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
                      _paths != null && _paths.isNotEmpty
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
