import 'dart:io';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';

import 'working_notifier.dart';
import 'mixins/cropping_service.dart';

class FileExplorer extends WorkingNotifier with CroppingService {
  static final _instance = FileExplorer._();

  factory FileExplorer() => _instance;

  FileExplorer._();

  Future<File> openFileExplorer() async {
    isWorking = true;

    PlatformFile _selectedFile;
    File _croppedFile;

    try {
      _selectedFile = (await FilePicker.platform.pickFiles(
        type: FileType.video,
        allowMultiple: false,
      ))
          ?.files
          ?.first;
      print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>${_selectedFile?.size}');
      await Future.delayed(Duration(seconds: 2));

      if (_selectedFile != null) {
        _croppedFile = await getCroppedFile(_selectedFile);
      }
    } on PlatformException catch (e) {
      print("Unsupported operation" + e.toString());
    } catch (ex) {
      print(ex);
    } finally {
      isWorking = false;
    }

    return File(_croppedFile?.path);
  }
}
