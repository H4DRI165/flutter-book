import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';

@RoutePage()
class ConstrainPage extends StatelessWidget {
  const ConstrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Constraints',
        subtitle: 'The golden layout rule',
      ),
      body: BodyContent(),
    );
  }
}

class BodyContent extends StatelessWidget {
  const BodyContent({super.key});

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
          GestureDetector(
            onTap: () {},
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Start exploring',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 8),
                    Icon(Icons.arrow_forward, color: Colors.white, size: 18),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
