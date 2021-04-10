import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers.dart';
import '../../core/services/api.dart';

class Splash extends StatelessWidget {
  Splash();

  @override
  Widget build(BuildContext context) {
    print('build splash');

    Api().listVideoFiles().then((list) {
      // Moves to Home when the list of videos is received.
      context.read(urlsProvider).state = list;
      Navigator.of(context).pushReplacementNamed('/',);
    });

    return Material(
      color: Colors.white,
      child: FlutterLogo(),
    );
  }
}
