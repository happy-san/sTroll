import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';

import 'navContents/nav_screen_content.dart';
import 'navContents/video_feed.dart';
import 'navContents/video_upload.dart';
import 'navContents/about.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/nav_screen_container.dart';

final _navScreenContents = <NavScreenContent>[
      VideoFeed(),
      VideoUpload(),
      About(),
    ],
    _bottomNavBar = BottomNavBar(
      _navScreenContents
          .map(
            (content) => BottomNavItem(
              _navScreenContents.indexOf(content),
              content.title,
              content.iconData,
              key: Key(content.title),
            ),
          )
          .toList(growable: false),
    );

class Home extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Material(
      child: IndexedStack(
        index: watch(bottomNavIndex).state,
        children: _navScreenContents
            .map(
              (content) => NavScreen(content),
            )
            .toList(growable: false),
      ),
    );
  }
}

class NavScreen extends StatelessWidget {
  final NavScreenContent content;

  const NavScreen(this.content, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: Alignment.topCenter,
          child: NavScreenContainer(child: content),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: _bottomNavBar,
        )
      ],
    );
  }
}
