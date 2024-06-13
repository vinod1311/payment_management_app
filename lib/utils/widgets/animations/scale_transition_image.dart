import 'package:flutter/material.dart';

class ScaleTransitionImage extends StatefulWidget {
  final Image image;
  final Duration duration;

  const ScaleTransitionImage({
    super.key,
    required this.image,
    this.duration = const Duration(seconds: 2),
  });

  @override
  ScaleTransitionImageState createState() => ScaleTransitionImageState();
}

class ScaleTransitionImageState extends State<ScaleTransitionImage> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _animation,
      child: widget.image,
    );
  }
}
