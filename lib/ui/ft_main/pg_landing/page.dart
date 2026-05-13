import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';

@RoutePage()
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            _handleTap(context);
          },
          child: const Text('Landing Page'),
        ),
      ),
    );
  }

  Future<void> _handleTap(BuildContext context) async {
    await context.pushRoute(const MainMenuRoute());
  }
}
