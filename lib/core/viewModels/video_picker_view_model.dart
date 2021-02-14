import 'dart:io';

import '../services/file_explorer.dart';
import 'working_notifier.dart';

class VideoPickerViewModel extends WorkingNotifier {
  File videoFile;

  Future<bool> selectVideoFile() async {
    isWorking = true;
    videoFile = await FileExplorer().openFileExplorer();
    isWorking = false;
    return videoFile == null ? false : true;
  }

  String getName(File file) => FileExplorer().getName(file);
}
