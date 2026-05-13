import 'package:flutter/material.dart';

enum CardVariant { featured, topic }

class CardText {
  const CardText(
    this.text, {
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.grey,
  });

  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
}

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.icon,
    required this.variant,
    required this.title,
    required this.description,
    this.iconColor = Colors.white,
    this.containerColor = Colors.grey,
    this.onTap,
    this.padding,

    // Featured only
    this.enableProgressBar = false,
    this.progressBarValue,
    this.progressBarColor,

    // Topic only
    this.enableTag = false,
    this.tag,
    this.tagColor,
  });

  final IconData icon;
  final CardVariant variant;
  final CardText title;
  final List<CardText> description;
  final Color? iconColor;
  final Color? containerColor;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? padding;

  // Featured
  final bool enableProgressBar;
  final double? progressBarValue;
  final Color? progressBarColor;

  // Topic
  final bool enableTag;
  final String? tag;
  final Color? tagColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap ?? () {},
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: padding ?? const EdgeInsets.all(16.0),
          child: variant == CardVariant.featured
              ? FeaturedLayout(
                  icon: icon,
                  iconColor: iconColor,
                  containerColor: containerColor,
                  title: title,
                  description: description,
                  enableProgressBar: enableProgressBar,
                  progressBarValue: progressBarValue,
                  progressBarColor: progressBarColor,
                )
              : TopicLayout(
                  icon: icon,
                  iconColor: iconColor,
                  containerColor: containerColor,
                  title: title,
                  description: description,
                  enableTag: enableTag,
                  tag: tag,
                  tagColor: tagColor,
                ),
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
    required this.description,
    this.iconColor,
    this.containerColor,
    this.enableProgressBar = false,
    this.progressBarValue,
    this.progressBarColor,
  });

  final IconData icon;
  final Color? iconColor;
  final Color? containerColor;
  final CardText title;
  final List<CardText> description;
  final bool enableProgressBar;
  final double? progressBarValue;
  final Color? progressBarColor;

  @override
  Widget build(BuildContext context) {
    return Row(
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
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.text,
                style: TextStyle(
                  fontSize: title.fontSize,
                  fontWeight: title.fontWeight,
                  color: title.color,
                ),
              ),
              ...description.map(
                (desc) => Text(
                  desc.text,
                  style: TextStyle(
                    fontSize: desc.fontSize,
                    fontWeight: desc.fontWeight,
                    color: desc.color,
                  ),
                ),
              ),
              if (enableProgressBar)
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
    required this.description,
    this.iconColor,
    this.containerColor,
    this.tag,
    this.tagColor,
    this.enableTag = false,
  });

  final IconData icon;
  final CardText title;
  final List<CardText> description;
  final Color? iconColor;
  final Color? containerColor;
  final String? tag;
  final Color? tagColor;
  final bool enableTag;

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
          title.text,
          style: TextStyle(
            fontSize: title.fontSize,
            fontWeight: title.fontWeight,
            color: title.color,
          ),
        ),
        ...description.map(
          (desc) => Text(
            desc.text,
            style: TextStyle(
              fontSize: desc.fontSize,
              fontWeight: desc.fontWeight,
              color: desc.color,
            ),
          ),
        ),
        const SizedBox(height: 5),
        if (enableTag)
          DecoratedBox(
            decoration: BoxDecoration(
              color: tagColor!,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsetsGeometry.fromLTRB(10, 0, 10, 0),
              child: Text(
                tag!,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
