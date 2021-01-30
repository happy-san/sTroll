import 'dart:io';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import 'mixins/cropping_service.dart';

class FileExplorer with CroppingService {
  static final _instance = FileExplorer._();

  factory FileExplorer() => _instance;

  FileExplorer._();

  Future<File> openFileExplorer() async {
    PlatformFile _selectedFile;
    File _croppedFile;

    try {
      _selectedFile = (await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      ))
          ?.files
          ?.first;

      if (_selectedFile != null) {
        _croppedFile = await getCroppedFile(_selectedFile);
        print(_croppedFile.path);
        return _croppedFile;
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    }

    return null;
  }
}
