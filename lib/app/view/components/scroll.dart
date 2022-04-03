import 'package:flutter/material.dart';

class Scroll extends StatelessWidget {
  final Widget child;

  const Scroll({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: child,
        )
      ],
    );
  }
}
