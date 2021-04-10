import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/viewModels/video_picker_view_model.dart';
import 'core/viewModels/video_upload_view_model.dart';

final urlsProvider = StateProvider<List<String>>((_) => []);
final videoPicker =
ChangeNotifierProvider<VideoPickerViewModel>((_) => VideoPickerViewModel());
final videoUploader =
ChangeNotifierProvider<VideoUploadViewModel>((_) => VideoUploadViewModel());

final bottomNavIndex = StateProvider<int>((_) => 0);