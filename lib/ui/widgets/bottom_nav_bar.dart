import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import '../layout_helper.dart';

const _itemDimension = kBottomNavigationBarHeight * 0.85;

class BottomNavBar extends StatefulWidget {
  final List<BottomNavItem> navItems;

  const BottomNavBar(
    this.navItems, {
    Key key,
  }) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  @override
  Widget build(BuildContext context) {
    final lh = LayoutHelper.of(context);

    return ClipPath(
      clipper: _BottomNavBarClipper(),
      child: Material(
        color: Colors.purple,
        child: Container(
          height: kBottomNavigationBarHeight,
          width: lh.width,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [Colors.white10, Colors.white12, Colors.white70],
              center: Alignment(0, 2),
              focal: Alignment(0.0, 0.99),
              focalRadius: 9,
              radius: 0.35,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: widget.navItems,
          ),
        ),
      ),
    );
  }
}

class BottomNavItem extends ConsumerWidget {
  final int index;
  final String title;
  final IconData iconData;

  const BottomNavItem(
    this.index,
    this.title,
    this.iconData, {
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    final selectedItem = watch(bottomNavIndex).state,
        borderRadius = BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
          bottomLeft: Radius.circular(8),
          bottomRight: Radius.circular(8),
        );

    return GestureDetector(
      onTap: () => context.read(bottomNavIndex).state = index,
      child: Material(
        color: Colors.blue,
        elevation: selectedItem == index
            ? LayoutHelper.tappedElevation
            : LayoutHelper.tappableElevation,
        borderRadius: borderRadius,
        child: Container(
          width: _itemDimension,
          height: _itemDimension,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: borderRadius,
              color: selectedItem == index
                  ? const Color(
                      0x60ffffff,
                    )
                  : null,
              gradient: selectedItem != index
                  ? RadialGradient(
                      colors: [
                        const Color(
                          0x90ffffff,
                        ),
                        const Color(
                          0x60ffffff,
                        ),
                      ],
                      stops: [0.6, 1],
                      center: Alignment(-0.4, -0.6),
                    )
                  : null),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(iconData),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomNavBarClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..moveTo(size.width * 0.05, size.height)
    ..quadraticBezierTo(
        size.width * 0.05, size.height * 0.2, size.width * 0.2, 0.0)
    ..lineTo(size.width * 0.8, 0.0)
    ..quadraticBezierTo(
        size.width * 0.95, size.height * 0.2, size.width * 0.95, size.height)
    ..close();

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
