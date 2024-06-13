import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class FadeThroughPageRoute extends PageRouteBuilder {
  final Widget page;

  FadeThroughPageRoute({required this.page})
      : super(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      return FadeThroughTransition(
        animation: animation,
        secondaryAnimation: secondaryAnimation,
        child: child,
      );
    },
  );
}

