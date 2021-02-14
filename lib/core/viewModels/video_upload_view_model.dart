import '../services/api.dart';
import 'working_notifier.dart';

class VideoUploadViewModel extends WorkingNotifier {
  Future<bool> uploadVideoFile({String videoName, String videoPath}) async {
    isWorking = true;
    var uploadSuccess;
    try {
      await Api().uploadVideoFile(videoName: videoName, videoPath: videoPath);
      uploadSuccess = true;
    } catch (e) {
      uploadSuccess = false;
    }
    isWorking = false;
    return uploadSuccess;
  }
}
