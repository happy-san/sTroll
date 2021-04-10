import 'package:flutter/material.dart';

import '../layout_helper.dart';

class SplashIconButton extends StatelessWidget {
  final double size;
  final Icon icon;
  final Color splashColor;
  final Function onTap;

  const SplashIconButton(
      {Key key,
      @required this.size,
      @required this.icon,
      this.splashColor = Colors.black12,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SizedBox(
      key: key,
      height: size,
      width: size,
      child: Material(
        color: Colors.white70,
        elevation: LayoutHelper.tappableElevation,
        shape: CircleBorder(),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.all(
            Radius.circular(size),
          ),
          splashColor: splashColor,
          child: icon,
        ),
      ),
    );
  }
}
