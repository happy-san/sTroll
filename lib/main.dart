import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'ui/screens/splash.dart';
import 'ui/screens/home.dart';

void main() {
  final app = sTroll();

  runApp(
    ProviderScope(child: app),
  );
}

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
      theme: Theme.of(context).copyWith(accentColor: Colors.deepPurpleAccent),
    );
  }
}
