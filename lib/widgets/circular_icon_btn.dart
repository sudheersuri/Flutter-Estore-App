import 'package:flutter/material.dart';

class CircularIconButton extends StatelessWidget {
  const CircularIconButton({
    super.key,
    required this.backgroundColor,
    required this.icon,
    this.iconSize = 20,
    this.onPressed,
  });

  final Color backgroundColor;
  final Icon icon;
  final double iconSize;
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: iconSize + 25,
      width: iconSize + 25,
      //rounded border
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(50),
      ),
      child: IconButton(
          iconSize: iconSize, icon: icon, onPressed: onPressed ?? () {}),
    );
  }
}
