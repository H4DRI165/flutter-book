import 'package:flutter/material.dart';

import '../../app.dart';

class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.onTap,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget child;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: padding,
          child: child,
        ),
      ),
    );
  }
}

class FeaturedLayout extends StatelessWidget {
  const FeaturedLayout({
    super.key,
    required this.icon,
    required this.title,
    required this.descriptionWidget,
    this.titleStyle,
    this.descriptionStyle,
    this.iconColor,
    this.containerColor,
    this.progressLabel,
    this.progressBarValue,
    this.progressBarColor,
  });

  final IconData icon;
  final String title;
  final Widget descriptionWidget;
  final TextStyle? titleStyle;
  final TextStyle? descriptionStyle;
  final Color? iconColor;
  final Color? containerColor;
  final String? progressLabel;
  final double? progressBarValue;
  final Color? progressBarColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        AppIcon(
          icon: icon,
          iconColor: iconColor,
          containerColor: containerColor,
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style:
                    titleStyle ??
                    const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
              ),
              descriptionWidget,
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    progressLabel ?? '',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                  Text(
                    progressBarValue != null ? '${(progressBarValue! * 100).toInt()}%' : '',
                    style: const TextStyle(fontSize: 11, color: Colors.grey),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              if (progressBarValue == 1.0)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF0D2E1A),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    'Completed ✓',
                    style: TextStyle(fontSize: 11, color: Colors.green),
                  ),
                )
              else
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progressBarValue ?? 0.2,
                    minHeight: 4,
                    backgroundColor: Colors.grey.withValues(alpha: 0.2),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      progressBarColor ?? Colors.grey,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class TopicLayout extends StatelessWidget {
  const TopicLayout({
    super.key,
    required this.icon,
    required this.title,
    required this.descriptionWidget,
    this.iconColor,
    this.containerColor,
    this.tag,
    this.tagColor,
    this.tagContainerColor,
  });

  final IconData icon;
  final String title;
  final Widget descriptionWidget;
  final Color? iconColor;
  final Color? containerColor;
  final String? tag;
  final Color? tagColor;
  final Color? tagContainerColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DecoratedBox(
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
        ),
        const SizedBox(height: 5),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        descriptionWidget,
        const SizedBox(height: 5),
        DecoratedBox(
          decoration: BoxDecoration(
            color: tagContainerColor ?? const Color(0xFFEEEDFE),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: Text(
              tag!,
              style: TextStyle(
                fontSize: 15,
                color: tagColor ?? Colors.black,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InfoCard extends StatelessWidget {
  const InfoCard({
    super.key,
    required this.title,
    required this.explanation,
  });

  final String title;
  final String explanation;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.8),
              ),
            ),
            Text(
              explanation,
              style: const TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
