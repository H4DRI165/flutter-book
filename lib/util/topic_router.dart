import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../app.dart';

void navigateToTopic({
  required BuildContext context,
  required String slug,
  required String topicId,
  bool showNextButton = false,
}) {
  switch (slug) {
    case 'constrain_intro':
      context.pushRoute(
        ConstrainIntroRoute(
          topicId: topicId,
        ),
      );
    case 'constrain_tight':
      context.pushRoute(
        ConstrainTightRoute(
          showNextButton: showNextButton,
          topicId: topicId,
        ),
      );
    case 'constrain_loose':
      context.pushRoute(
        ConstrainLooseRoute(
          showNextButton: showNextButton,
          topicId: topicId,
        ),
      );
    case 'constrain_unbounded':
      context.pushRoute(
        ConstrainUnboundedRoute(
          showNextButton: showNextButton,
          topicId: topicId,
        ),
      );
    default:
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Coming soon!')),
      );
  }
}
