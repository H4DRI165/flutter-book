import 'package:flutter/material.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.icon,
    this.iconColor = Colors.white,
    this.containerColor = Colors.grey,
    this.size = 22,
  });

  final IconData icon;
  final Color? iconColor;
  final Color? containerColor;
  final double? size;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: containerColor,
      ),
      child: SizedBox(
        height: 50,
        width: 50,
        child: Icon(
          icon,
          size: 22,
          color: iconColor,
        ),
      ),
    );
  }
}
