import 'package:flutter/material.dart';

class VideoContainer extends StatelessWidget {
  final Widget child;
  final Key key;

  const VideoContainer({this.child, this.key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) => Container(
        height: constraints.biggest.width,
        width: constraints.biggest.width,
        margin: const EdgeInsets.only(left: 8.0, top: 8.0, right: 8.0),
        padding: const EdgeInsets.all(8.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(constraints.biggest.width * 0.05),
        ),
        child: ClipRRect(
            borderRadius:
                BorderRadius.circular(constraints.biggest.width * 0.05),
            clipBehavior: Clip.antiAlias,
            child: child),
      ),
    );
  }
}
