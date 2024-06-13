import 'package:flutter/material.dart';
import 'package:animations/animations.dart';

class CustomPageTransitionSwitcher extends StatelessWidget {
  final Widget child;
  final SharedAxisTransitionType transitionType;
  final Duration transitionDuration;

  const CustomPageTransitionSwitcher({
    super.key,
    required this.child,
    this.transitionType = SharedAxisTransitionType.scaled,
    this.transitionDuration = const Duration(milliseconds: 300),
  });

  @override
  Widget build(BuildContext context) {
    return PageTransitionSwitcher(
      duration: transitionDuration,
      transitionBuilder: (
          Widget child,
          Animation<double> primaryAnimation,
          Animation<double> secondaryAnimation,
          ) {
        return SharedAxisTransition(
          animation: primaryAnimation,
          secondaryAnimation: secondaryAnimation,
          transitionType: transitionType,
          child: child,
        );
      },
      child: child,
    );
  }
}
