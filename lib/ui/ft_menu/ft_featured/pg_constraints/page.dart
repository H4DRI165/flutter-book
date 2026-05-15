import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';

@RoutePage()
class ConstrainIntroPage extends StatelessWidget {
  const ConstrainIntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Constraints',
        titleSize: 16,
        subtitle: 'The golden layout rule',
        subtitleSize: 13,
      ),
      body: _BodyContent(),
    );
  }
}

class _BodyContent extends StatelessWidget {
  const _BodyContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          CardItem(
            icon: Icons.arrow_downward_rounded,
            iconColor: const Color(0xFF185FA5),
            containerColor: const Color(0xFFE6F1FB),
            variant: CardVariant.featured,
            title: const CardText(
              'Step 1',
              fontSize: 12,
              color: Colors.blue,
            ),
            description: const [
              CardText(
                'Constraints go down',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              CardText('Parent passes size rules to child'),
            ],
            onTap: () {},
          ),
          const SizedBox(height: 10),
          CardItem(
            icon: Icons.arrow_upward_rounded,
            iconColor: const Color(0xFF0F6E56),
            containerColor: const Color(0xFFE1F5EE),
            variant: CardVariant.featured,
            title: const CardText(
              'Step 2',
              fontSize: 12,
              color: Colors.green,
            ),
            description: const [
              CardText(
                'Sizes go up',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              CardText(
                'Child reports its desired size back',
              ),
            ],
            onTap: () {},
          ),
          const SizedBox(height: 10),
          CardItem(
            icon: Icons.dashboard_customize_rounded,
            iconColor: const Color(0xFF534AB7),
            containerColor: const Color(0xFFEEEDFE),
            variant: CardVariant.featured,
            title: const CardText(
              'Step 3 - Key rule',
              fontSize: 12,
              color: Colors.deepPurple,
            ),
            description: const [
              CardText(
                'Parent sets position',
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              CardText(
                'Child cannot position itself',
              ),
            ],
            onTap: () {},
          ),
          const Spacer(),
          AppButton(
            label: 'Start exploring',
            onTap: () async {
              await context.pushRoute(const ConstrainTightRoute());
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
