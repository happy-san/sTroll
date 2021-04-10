import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Base class to be extended by a Navigation Screen.
abstract class NavScreenContent extends ConsumerWidget {
  /// [title] of the Navigation Screen.
  final String title;

  /// Icon associated with Navigation Screen.
  final IconData iconData;

  const NavScreenContent(
    this.title,
    this.iconData,
  );

  @override
  Widget build(BuildContext context, ScopedReader watch);
}
