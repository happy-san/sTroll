import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_ffmpeg/flutter_ffmpeg.dart';

mixin CroppingService {
  Future<File> getCroppedFile(PlatformFile inputFile) async {
    var map = await _getVideoDimensions(filePath: inputFile.path);
    final width = map['width'], height = map['height'];

    if (width != height) {
      FlutterFFmpeg()
          .executeWithArguments(
              _generateArguments(inputFile, width: width, height: height))
          .then((rc) => print("FFmpeg process exited with rc $rc"));

      final outputFilePath = _getOutputFilePath(inputFile);

      // TODO: delete *_cropped file after upload finishes.
      return File(outputFilePath);
    }

    return File(inputFile.path);
  }

  Future<Map<String, int>> _getVideoDimensions({String filePath}) async {
    try {
      final info = await FlutterFFprobe().getMediaInformation(filePath);
      final map = info.getAllProperties();

      if (map == null || map.isEmpty)
        throw ('Could not get information about $filePath');
      return {
        'width': map['streams'][0]['width'],
        'height': map['streams'][0]['height'],
      };
    } catch (e) {
      print(e);
      return null;
    }
  }

  /// Generates the arguments for `ffmpeg` command.
  ///
  /// ffmpeg -i input.mp4 -filter:v "crop=w:h:x:y" output.mp4
  ///
  /// -i input.mp4 specifies the input video (input.mp4 being the input /
  /// original video in this case)
  ///
  /// -filter:v (can be abbreviated to -vf) specifies we're using a video filter
  ///
  /// "crop=W:H:X:Y" means we're using the "crop" video filter, with 4 values:
  ///
  /// w the width of the output video (so the width of the cropped region),
  /// which defaults to the input video width (input video width = iw, which is
  /// the same as in_w); out_w may also be used instead of w
  ///
  /// h the height of the output video (the height of the cropped region), which
  /// defaults to the input video height (input video height = ih, with in_h
  /// being another notation for the same thing); out_h may also be used instead
  /// of h
  ///
  /// x the horizontal position from where to begin cropping, starting from the
  /// left (with the absolute left margin being 0)
  ///
  /// y the vertical position from where to begin cropping, starting from the
  /// top of the video (the absolute top being 0)
  ///
  /// output.mp4 is the new, cropped video file
  ///
  /// https://www.linuxuprising.com/2020/01/ffmpeg-how-to-crop-videos-with-examples.html
  List<String> _generateArguments(PlatformFile inputFile,
      {int width, int height}) {
    final shouldCropHeight = width < height;
    final outputFileDimension = shouldCropHeight ? width : height;
    final croppingStartPoint = (width - height).abs() ~/ 2;

    final list = [
      '-i',
      inputFile.path,
      '-filter:v',
      'crop=$outputFileDimension:$outputFileDimension:${shouldCropHeight ? '0' : '$croppingStartPoint'}:${shouldCropHeight ? '$croppingStartPoint' : '0'}',
      _getOutputFilePath(inputFile)
    ];

    print('Generated Arguments: $list');

    return list;
  }

  String _getOutputFilePath(PlatformFile file) =>
      '${_getDirectory(file)}${_getNameWithoutExtension(file)}_cropped.${_getExtension(file)}';

  String _getExtension(PlatformFile file) => file.name.split('.').last;

  String _getNameWithoutExtension(PlatformFile file) =>
      file.name.replaceAll(RegExp(r'\.\w+$'), '');

  String _getDirectory(PlatformFile file) =>
      file.path.replaceAll(RegExp(r'[\w+\-\.]+\.[a-zA-z0-9]+$'), '');

  String getName(File file) => file.path.split('/').last;
}
