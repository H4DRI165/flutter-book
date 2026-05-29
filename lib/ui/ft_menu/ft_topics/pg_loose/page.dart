import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app.dart';
import '../../pg_main_menu/bloc/main_menu_bloc.dart';

@RoutePage()
class ConstrainLoosePage extends StatefulWidget {
  const ConstrainLoosePage({
    super.key,
    required this.topicId,
    this.showNextButton = false,
  });

  final String topicId;
  final bool showNextButton;

  @override
  State<ConstrainLoosePage> createState() => _ConstrainLoosePageState();
}

class _ConstrainLoosePageState extends State<ConstrainLoosePage> {
  @override
  void initState() {
    super.initState();
    _markInProgress();
  }

  void _markInProgress() {
    context.read<MainMenuBloc>().add(
      MainMenuProgressUpdated(
        topicId: widget.topicId,
        status: ProgressStatus.inProgress,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final topic = context.read<MainMenuBloc>().state.topicById(widget.topicId);

    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Loose Constraints',
        titleSize: 16,
        subtitle: 'Drag sliders to explore the range',
        subtitleSize: 13,
      ),
      body: _BodyContent(
        showNextButton: widget.showNextButton,
        topicId: widget.topicId,
        explanation: topic?.explanation ?? '',
      ),
    );
  }
}

class _BodyContent extends StatefulWidget {
  const _BodyContent({
    required this.showNextButton,
    required this.topicId,
    this.explanation = '',
  });

  final bool showNextButton;
  final String topicId;
  final String explanation;

  @override
  State<_BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<_BodyContent> with ConstrainProgressMixin {
  @override
  String get topicId => widget.topicId;

  double _width = 170;
  double _height = 90;

  @override
  Widget build(BuildContext context) {
    return ConstrainBodyLayout(
      livePreview: _LivePreview(width: _width, height: _height),
      metricCards: ConstrainMetricCards(
        subtitle: 'min → max',
        leftValue: 'W: 0 → ${_width.toInt()}',
        rightValue: 'H: 0 → ${_height.toInt()}',
      ),
      sliders: [
        SliderRow(
          label: 'Width',
          value: _width,
          min: 0,
          max: 210,
          onChanged: (v) => setState(() => _width = v.roundToDouble()),
        ),
        const SizedBox(height: 8),
        SliderRow(
          label: 'Height',
          value: _height,
          min: 0,
          max: 130,
          onChanged: (v) => setState(() => _height = v.roundToDouble()),
        ),
      ],
      infoCardTitle: 'What is a loose constraint?',
      explanation: widget.explanation,
      topicId: widget.topicId,
      onMarkCompleted: markCompleted,
      showNextButton: widget.showNextButton,
      nextButton: AppButton(
        label: 'Next: unbounded',
        enableSuffixIcon: true,
        onTap: () {
          final looseId = context
              .read<MainMenuBloc>()
              .state
              .topics
              .firstWhere((t) => t.slug == 'constrain_unbounded')
              .id;
          context.pushRoute(
            ConstrainUnboundedRoute(
              showNextButton: widget.showNextButton,
              topicId: looseId,
            ),
          );
        },
      ),
    );
  }
}

class _LivePreview extends StatelessWidget {
  const _LivePreview({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'LIVE PREVIEW',
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: Colors.grey.withValues(alpha: 0.6),
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(height: 16),
          Center(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(
                      left: (MediaQuery.of(context).size.width - 80) / 2 - width / 2,
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF534AB7),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      'ConstrainedBox ${width.toInt()}×${height.toInt()}',
                      style: const TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                AnimatedContainer(
                  duration: const Duration(milliseconds: 120),
                  width: width,
                  height: height,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEEDFE),
                    border: Border.all(
                      color: const Color(0xFF534AB7),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Text(
                      'child ${width.toInt()}×${height.toInt()}',
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF3C3489),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
