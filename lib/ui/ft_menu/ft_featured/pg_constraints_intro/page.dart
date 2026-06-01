import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app.dart';
import '../../pg_main_menu/bloc/main_menu_bloc.dart';

@RoutePage()
class ConstrainIntroPage extends StatefulWidget {
  const ConstrainIntroPage({
    super.key,
    required this.topicId,
  });

  final String topicId;

  @override
  State<ConstrainIntroPage> createState() => _ConstrainIntroPageState();
}

class _ConstrainIntroPageState extends State<ConstrainIntroPage> with ConstrainProgressMixin {
  @override
  String get topicId => widget.topicId;

  @override
  void initState() {
    super.initState();
    markInProgress();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Constraints',
        titleSize: 16,
        subtitle: 'The golden layout rule',
        subtitleSize: 13,
      ),
      body: _BodyContent(topicId: widget.topicId),
    );
  }
}

class _BodyContent extends StatefulWidget {
  const _BodyContent({required this.topicId});

  final String topicId;

  @override
  State<_BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<_BodyContent> with ConstrainProgressMixin {
  @override
  String get topicId => widget.topicId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
      child: Column(
        children: [
          const AppCard(
            child: FeaturedLayout(
              icon: Icons.arrow_downward_rounded,
              title: 'Step 1',
              titleStyle: TextStyle(fontSize: 12, color: Colors.blue),
              descriptionWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Constraints go down',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Parent passes size rules to child',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              iconColor: Color(0xFF185FA5),
              containerColor: Color(0xFFE6F1FB),
            ),
          ),
          const SizedBox(height: 10),
          const AppCard(
            child: FeaturedLayout(
              icon: Icons.arrow_upward_rounded,
              title: 'Step 2',
              titleStyle: TextStyle(fontSize: 12, color: Colors.green),
              descriptionWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sizes go up',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Child reports its desired size back',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              iconColor: Color(0xFF0F6E56),
              containerColor: Color(0xFFE1F5EE),
            ),
          ),
          const SizedBox(height: 10),
          const AppCard(
            child: FeaturedLayout(
              icon: Icons.dashboard_customize_rounded,
              title: 'Step 3 - Key rule',
              titleStyle: TextStyle(
                fontSize: 12,
                color: Color(0xFFd3bcfd),
              ),
              descriptionWidget: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Parent sets position',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Child cannot position itself',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              iconColor: Color(0xFF534AB7),
              containerColor: Color(0xFFEEEDFE),
            ),
          ),
          const Spacer(),
          BlocBuilder<MainMenuBloc, MainMenuPageState>(
            buildWhen: (prev, curr) => prev.userProgress != curr.userProgress,
            builder: (context, state) {
              final isCompleted = state.progressFor(widget.topicId) == ProgressStatus.completed;
              return AppButton(
                label: isCompleted ? 'Completed ✓' : 'Mark as complete',
                containerColor: isCompleted ? const Color(0xFF0D2E1A) : const Color(0xFF534AB7),
                onTap: isCompleted
                    ? null
                    : () async {
                        final confirmed = await showConfirmDialog(
                          context,
                          title: 'Mark as completed?',
                          content: 'Are you sure you have understood this topic?',
                        );
                        if (confirmed) markCompleted();
                      },
              );
            },
          ),
          const SizedBox(height: 8),
          AppButton(
            label: 'Start exploring',
            enableSuffixIcon: true,
            onTap: () async {
              final tightTopic = context
                  .read<MainMenuBloc>()
                  .state
                  .topics
                  .where((t) => t.slug == 'constrain_tight')
                  .firstOrNull;

              if (tightTopic == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Unable to open the next topic right now.')),
                );
                return;
              }

              await context.pushRoute(
                ConstrainTightRoute(
                  showNextButton: true,
                  topicId: tightTopic.id,
                ),
              );
            },
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
