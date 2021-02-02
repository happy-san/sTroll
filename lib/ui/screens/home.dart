import 'package:flutter/material.dart';

import '../tabs/video_feed_tab.dart';
import '../tabs/video_upload_tab.dart';
import '../tabs/about_tab.dart';

class Home extends StatefulWidget {
  const Home();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedTab = 0;
  static final _tabs = <Widget>[
    VideoFeedTab(),
    VideoUploadTab(),
    AboutTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
