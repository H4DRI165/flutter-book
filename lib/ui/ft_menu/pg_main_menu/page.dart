import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../app.dart';
import 'bloc/main_menu_bloc.dart';

@RoutePage()
class MainMenuPage extends StatelessWidget {
  const MainMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MainMenuBloc(authRepository: AuthRepository()),
      child: BlocListener<MainMenuBloc, MainMenuState>(
        listener: (context, state) {
          if (state.status == MainMenuStatus.loggedOut) {
            context.router.replace(const LoginRoute());
          }
        },
        child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: CustomAppBar(
                title: 'Welcome back',
                subtitle: 'Flutter Book',
                fallBackButton: false,
                logoutButton: true,
                onLogout: () {
                  context.read<MainMenuBloc>().add(const MainMenuLogoutPressed());
                },
              ),
              body: const Content(),
            );
          },
        ),
      ),
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
            icon: Icons.dashboard_outlined,
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
              await context.pushRoute(const ConstrainIntroRoute());
            },
          ),
          const SizedBox(height: 10),
          CardItem(
            icon: Icons.account_tree_outlined,
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
              // await context.pushRoute(const ConstrainRoute());
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
                    icon: Icons.lock,
                    variant: CardVariant.topic,
                    title: const CardText(
                      'Tight constraints',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    description: const [CardText('When min equals max')],
                    enableTag: true,
                    tag: 'Layout',
                    tagContainerColor: Colors.blueAccent,
                    onTap: () {},
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: CardItem(
                    icon: Icons.zoom_out_map_rounded,
                    variant: CardVariant.topic,
                    title: const CardText(
                      'Loose constraints',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    description: const [CardText('Child picks its size')],
                    enableTag: true,
                    tag: 'Layout',
                    tagContainerColor: Colors.yellowAccent,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: CardItem(
                    icon: Icons.warning_amber_rounded,
                    iconColor: Color(0XFFA3323B),
                    containerColor: const Color(0xFFFCEBEB),
                    variant: CardVariant.topic,
                    title: const CardText(
                      'Unbounded Constraints',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    description: const [CardText('Infinite constraints explained')],
                    enableTag: true,
                    tag: 'Common error',
                    tagColor: const Color(0xFF932925),
                    tagContainerColor: const Color(0xFFFCEBEB),
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
