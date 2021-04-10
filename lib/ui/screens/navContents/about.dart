import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'nav_screen_content.dart';

class About extends NavScreenContent {
  const About() : super('About', Icons.portrait_outlined);

  @override
  Widget build(BuildContext context,
      T Function<T>(ProviderBase<Object, T> provider) watch) {
    return Center(
      child: Text('HI'),
    );
  }
}
