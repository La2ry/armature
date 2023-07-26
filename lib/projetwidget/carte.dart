import 'package:flutter/material.dart';

// ignore: must_be_immutable
class Carte extends StatelessWidget {
  void Function()? onPressed;
  final Color color;
  final Widget child;
  Carte(
      {super.key,
      required this.onPressed,
      required this.color,
      required this.child});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: Card(
          color: color,
          child: child,
        ),
      );
}
