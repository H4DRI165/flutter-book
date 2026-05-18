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
    this.logoutButton = false,
    this.onLogout,
  });

  final String title;
  final String? subtitle;
  final double? titleSize;
  final double? subtitleSize;
  final bool fallBackButton;
  final bool logoutButton;
  final VoidCallback? onLogout;

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      elevation: 0,
      toolbarHeight: 80 + MediaQuery.of(context).padding.top,
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
      actions: logoutButton
          ? [
              GestureDetector(
                onTap: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Logout'),
                      content: const Text('Proceed to logout?'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text(
                            'Yes',
                            style: TextStyle(color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    onLogout?.call();
                  }
                },
                child: Container(
                  margin: const EdgeInsets.all(12),
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEDFE),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.logout_rounded,
                    color: Color(0xFF534AB7),
                    size: 20,
                  ),
                ),
              ),
            ]
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
