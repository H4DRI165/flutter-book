import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.subtitle,
    this.titleSize = 12,
    this.subtitleSize = 16,
    this.fallBackButton = true,
  });

  final String title;
  final String? subtitle;
  final double? titleSize;
  final double? subtitleSize;
  final bool fallBackButton;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 80,
      leading: fallBackButton
          ? GestureDetector(
              onTap: () => context.router.maybePop(),
              child: Container(
                margin: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            )
          : null,
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: titleSize,
              color: const Color(0xFFEFEEEB),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (subtitle != null)
            Text(
              subtitle!,
              style: TextStyle(
                fontSize: subtitleSize,
                color: const Color(0xFFC2C0B6),
                fontWeight: FontWeight.w400,
              ),
            ),
        ],
      ),
    );
  }
}
