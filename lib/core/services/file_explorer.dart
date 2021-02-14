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

      final size = _selectedFile?.size.toString();

      if (_selectedFile != null) {
        _croppedFile = await _tryCrop(
            size.length > 5 ? size.length - 5 : 1, _selectedFile);
      }
    } catch (ex) {
      print(ex);
    }

    return File(_croppedFile?.path);
  }

  Future<File> _tryCrop(int triesLeft, PlatformFile selectedFile) async {
    File croppedFile;
    if (triesLeft > 0) {
      try {
        croppedFile = await getCroppedFile(selectedFile);
        if (croppedFile != null) {
          return croppedFile;
        } else {
          throw ('Couldn\'t crop, trying again (tries left: ${triesLeft - 1})');
        }
      } on PlatformException catch (e) {
        print("Unsupported operation" + e.toString());
      } catch (e) {
        print(e);
        croppedFile = await _tryCrop(triesLeft - 1, selectedFile);
      }
    }

    return croppedFile;
  }
}
