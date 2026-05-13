import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../app.dart';

@RoutePage()
class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Welcome back',
        subtitle: 'Flutter Book',
        fallBackButton: false,
      ),
      body: Content(),
    );
  }
}

class Content extends StatelessWidget {
  const Content({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [FeaturedSection(), TopicSection()],
      ),
    );
  }
}

class FeaturedSection extends StatelessWidget {
  const FeaturedSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'FEATURED',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          CardItem(
            icon: Icons.arrow_downward_rounded,
            variant: CardVariant.featured,
            title: const CardText(
              'Constraints',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            description: const [CardText('How parent passes size rules to child widgets')],
            progressBarValue: 0.6,
            progressBarColor: Colors.purple,
            onTap: () async {
              await context.pushRoute(const ConstrainRoute());
            },
          ),
          const SizedBox(height: 10),
          CardItem(
            icon: Icons.arrow_downward_rounded,
            variant: CardVariant.featured,
            title: const CardText(
              'Widget tree',
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            description: const [CardText('Understanding parent, child and render objects')],
            progressBarValue: 0.2,
            progressBarColor: Colors.green,
            onTap: () async {
              await context.pushRoute(const ConstrainRoute());
            },
          ),
        ],
      ),
    );
  }
}

class TopicSection extends StatelessWidget {
  const TopicSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TOPICS',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CardItem(
                    icon: Icons.arrow_downward_rounded,
                    iconColor: Colors.blue,
                    variant: CardVariant.topic,
                    title: const CardText(
                      'Tight vs Loose',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    description: const [CardText('When min equals max')],
                    enableTag: true,
                    tag: 'Layout',
                    tagColor: Colors.blueAccent,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CardItem(
                    icon: Icons.arrow_downward_rounded,
                    iconColor: Colors.green,
                    variant: CardVariant.topic,
                    title: const CardText(
                      'Unbounded',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    description: const [CardText('Infinite constraints explained')],
                    enableTag: true,
                    tag: 'Common error',
                    tagColor: Colors.yellowAccent,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
