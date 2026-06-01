import 'package:flutter/material.dart';

class TopicUi {
  const TopicUi({
    required this.icon,
    required this.iconColor,
    required this.containerColor,
    this.progressBarColor,
  });
  final IconData icon;
  final Color iconColor;
  final Color containerColor;
  final Color? progressBarColor;
}

TopicUi topicUiFromSlug(String slug) => switch (slug) {
  'constrain_intro' => const TopicUi(
    icon: Icons.dashboard_outlined,
    iconColor: Color(0xFF534AB7),
    containerColor: Color(0xFFEEEDFE),
  ),
  'widget_tree' => const TopicUi(
    icon: Icons.account_tree_outlined,
    iconColor: Color(0xFF534AB7),
    containerColor: Color(0xFFEEEDFE),
  ),
  'constrain_tight' => const TopicUi(
    icon: Icons.lock,
    iconColor: Color(0xFF534AB7),
    containerColor: Color(0xFFEEEDFE),
  ),
  'constrain_loose' => const TopicUi(
    icon: Icons.zoom_out_map_rounded,
    iconColor: Color(0xFF534AB7),
    containerColor: Color(0xFFEEEDFE),
  ),
  'constrain_unbounded' => const TopicUi(
    icon: Icons.warning_amber_rounded,
    iconColor: Color(0xFFA3323B),
    containerColor: Color(0xFFFCEBEB),
  ),

  _ => const TopicUi(
    icon: Icons.widgets_outlined,
    iconColor: Color(0xFF534AB7),
    containerColor: Color(0xFFEEEDFE),
  ),
};
