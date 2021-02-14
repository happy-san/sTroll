import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/viewModels/video_picker_view_model.dart';
import 'core/viewModels/video_upload_view_model.dart';

import 'ui/layout_helper.dart';
import 'ui/screens/splash.dart';
import 'ui/screens/home.dart';

void main() {
  final app = sTroll();

  runApp(
    ProviderScope(child: app),
  );
}

final layoutHelper = Provider<LayoutHelper>((_) => LayoutHelper());
final urlsProvider = StateProvider<List<String>>((_) => []);
final videoPicker =
    ChangeNotifierProvider<VideoPickerViewModel>((_) => VideoPickerViewModel());
final videoUploader =
    ChangeNotifierProvider<VideoUploadViewModel>((_) => VideoUploadViewModel());

class sTroll extends StatelessWidget {
  final _home = Home(), _splash = Splash();

  @override
  Widget build(BuildContext context) {
    print('build sTroll');
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/splash',
      routes: {
        '/': (_) => _home,
        '/splash': (_) => _splash,
      },
    );
  }
}
