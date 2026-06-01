import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app.dart';
import '../../pg_main_menu/bloc/main_menu_bloc.dart';

class ConstrainBodyLayout extends StatelessWidget {
  const ConstrainBodyLayout({
    super.key,
    required this.livePreview,
    required this.metricCards,
    required this.sliders,
    required this.infoCardTitle,
    required this.explanation,
    required this.topicId,
    required this.onMarkCompleted,
    this.showNextButton = false,
    this.nextButton,
  });

  final Widget livePreview;
  final Widget metricCards;
  final List<Widget> sliders;
  final String infoCardTitle;
  final String explanation;
  final String topicId;
  final VoidCallback onMarkCompleted;
  final bool showNextButton;
  final Widget? nextButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          livePreview,
          const SizedBox(height: 10),
          metricCards,
          const SizedBox(height: 10),
          ...sliders,
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: InfoCard(
              title: infoCardTitle,
              explanation: explanation,
            ),
          ),
          const Spacer(),
          BlocBuilder<MainMenuBloc, MainMenuPageState>(
            buildWhen: (prev, curr) => prev.userProgress != curr.userProgress,
            builder: (context, state) {
              final isCompleted = state.progressFor(topicId) == ProgressStatus.completed;
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
                        if (confirmed) onMarkCompleted();
                      },
              );
            },
          ),
          if (showNextButton && nextButton != null) ...[
            const SizedBox(height: 8),
            nextButton!,
          ],
        ],
      ),
    );
  }
}

// ─── Shared Metric Cards ─────────────────────────────────────────────────────
class ConstrainMetricCards extends StatelessWidget {
  const ConstrainMetricCards({
    super.key,
    required this.leftValue,
    required this.rightValue,
    this.subtitle = '',
  });

  final String leftValue;
  final String rightValue;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _MetricCard(
            label: subtitle,
            value: leftValue,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _MetricCard(
            label: subtitle,
            value: rightValue,
          ),
        ),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.label,
    required this.value,
  });

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey.withValues(alpha: 0.7),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

// ─── Shared Live Preview Container ───────────────────────────────────────────
class ConstrainLivePreviewWrapper extends StatelessWidget {
  const ConstrainLivePreviewWrapper({
    super.key,
    required this.child,
  });

  final Widget child;

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
          child,
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}

// ─── Shared markInProgress / markCompleted ───────────────────────────────────
mixin ConstrainProgressMixin<T extends StatefulWidget> on State<T> {
  String get topicId;

  void markInProgress() {
    final current = context.read<MainMenuBloc>().state.progressFor(topicId);

    if (current == ProgressStatus.completed) return;

    context.read<MainMenuBloc>().add(
      MainMenuProgressUpdated(
        topicId: topicId,
        status: ProgressStatus.inProgress,
      ),
    );
  }

  void markCompleted() {
    context.read<MainMenuBloc>().add(
      MainMenuProgressUpdated(
        topicId: topicId,
        status: ProgressStatus.completed,
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Topic marked as completed!'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
