import 'package:flutter/material.dart';

import 'ui/tabs/video_feed_tab.dart';
import 'ui/tabs/video_upload_tab.dart';
import 'ui/tabs/about_tab.dart';

void main() => runApp(new FilePickerDemo());

class FilePickerDemo extends StatefulWidget {
  @override
  _FilePickerDemoState createState() => _FilePickerDemoState();
}

class _FilePickerDemoState extends State<FilePickerDemo> {
  int _selectedTab = 0;
  static List<Widget> _tabs = <Widget>[
    VideoFeedTab(),
    VideoUploadTab(),
    AboutTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: IndexedStack(
          index: _selectedTab,
          children: _tabs,
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          showUnselectedLabels: false,
          showSelectedLabels: false,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: const Icon(
                Icons.home_outlined,
                color: Colors.lightBlue,
              ),
              activeIcon: const Icon(
                Icons.home,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Upload',
              icon: const Icon(
                Icons.cloud_upload_outlined,
                color: Colors.lightBlue,
              ),
              activeIcon: const Icon(
                Icons.cloud_upload,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              label: 'About',
              icon: const Icon(
                Icons.account_box_outlined,
                color: Colors.lightBlue,
              ),
              activeIcon: const Icon(
                Icons.account_box,
                color: Colors.blue,
              ),
            ),
          ],
          onTap: (newIndex) => setState(
            () => _selectedTab = newIndex,
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
