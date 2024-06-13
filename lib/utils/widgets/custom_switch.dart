import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final bool value;
  final Function onChanged;
  final IconData activeIcon;
  final IconData inactiveIcon;

  const CustomToggleButton({
    super.key,
    required this.value,
    required this.onChanged,
    required this.activeIcon,
    required this.inactiveIcon,
  });

  @override
  State<CustomToggleButton> createState() => _CustomToggleState();
}

///--------------- toggle switch for theme mode
class _CustomToggleState extends State<CustomToggleButton> {
  @override
  Widget build(BuildContext context) {
    final Color activeColor = Theme.of(context).colorScheme.onSurface;
    final Color inactiveColor = Theme.of(context).colorScheme.primary;

    return IconButton(
      onPressed: (){
        widget.onChanged();
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) {
          return ScaleTransition(
            scale: animation,
            child: child,
          );
        },
        child: widget.value
            ? Icon(
          widget.activeIcon,
          color: activeColor,
          size: 24.0, // Adjust icon size
        )
            : Icon(
          widget.inactiveIcon,
          color: inactiveColor,
          size: 24.0, // Adjust icon size
        ),
      ),
    );

  }
}
