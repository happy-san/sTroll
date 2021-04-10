import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../layout_helper.dart';
import '../screens/navContents/nav_screen_content.dart';

/// Sets the gradient background for the [NavScreenContent].
class NavScreenContainer extends StatelessWidget {
  final NavScreenContent child;

  const NavScreenContainer({Key key, @required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lh = LayoutHelper.of(context);

    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
            height: lh.height,
            width: lh.width,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment(-0.3, -0.6),
                colors: [
                  const Color(0xffff4081),
                  Colors.transparent,
                ],
                radius: 2,
              ),
            ),
          ),
          Container(
            height: lh.height,
            width: lh.width,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                end: Alignment.topLeft,
                colors: [
                  Color(0xc0e040fb),
                  Colors.transparent,
                  // Colors.purple,
                ],
              ),
            ),
          ),
          Container(
            height: lh.height,
            width: lh.width,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top,
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
