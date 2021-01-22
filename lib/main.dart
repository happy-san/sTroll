import 'package:flutter/material.dart';

import 'video_feed_tab.dart';
import 'video_upload_tab.dart';
import 'about_tab.dart';

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
        body: _tabs[_selectedTab],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedTab,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home_outlined,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Upload',
              icon: Icon(
                Icons.upload_outlined,
                color: Colors.blue,
              ),
            ),
            BottomNavigationBarItem(
              label: 'About',
              icon: Icon(
                Icons.account_box_outlined,
                color: Colors.blue,
              ),
            ),
          ],
          onTap: (newIndex) => setState(
            () {
              _selectedTab = newIndex;
            },
          ),
          backgroundColor: Colors.white,
        ),
      ),
    );
  }
}
