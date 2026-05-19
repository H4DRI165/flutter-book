import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';

@RoutePage()
class ConstrainUnboundedPage extends StatefulWidget {
  const ConstrainUnboundedPage({super.key, this.showNextButton = false});

  final bool showNextButton;

  @override
  State<ConstrainUnboundedPage> createState() => _ConstrainUnboundedPageState();
}

class _ConstrainUnboundedPageState extends State<ConstrainUnboundedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Unbounded Constraints',
        titleSize: 16,
        subtitle: 'Drag sliders to see overflow',
        subtitleSize: 13,
      ),
      body: _BodyContent(showNextButton: widget.showNextButton),
    );
  }
}

class _BodyContent extends StatefulWidget {
  const _BodyContent({required this.showNextButton});

  final bool showNextButton;

  @override
  State<_BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<_BodyContent> {
  double _width = 50;
  double _height = 50;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          _LivePreview(width: _width, height: _height),
          const SizedBox(height: 10),
          _MetricCards(width: _width, height: _height),
          const SizedBox(height: 10),
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
          const SizedBox(height: 8),
          const _InfoCard(),
          const Spacer(),
          if (widget.showNextButton)
            AppButton(
              label: 'Main Menu',
              onTap: () {
                context.router.replace(const MainMenuRoute());
              },
            ),
        ],
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
                    child: const Text(
                      'parent: unbounded (∞)',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 200,
                  height: 120,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.5),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        top: 4,
                        right: 6,
                        child: Text(
                          'screen limit 200×120',
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey.withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                      ClipRect(
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 120),
                          width: width,
                          height: height,
                          decoration: BoxDecoration(
                            color: width > 200 || height > 110
                                ? Colors.red.withValues(alpha: 0.1)
                                : const Color(0xFFEEEDFE),
                            border: Border.all(
                              color: width > 200 || height > 110 ? Colors.red : const Color(0xFF534AB7),
                              width: 1.5,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'child ${width.toInt()}×${height.toInt()}',
                                  style: const TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF3C3489),
                                  ),
                                ),
                                if (width > 200 || height > 110)
                                  const Text(
                                    '⚠ Overflow!',
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.red,
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
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

class _MetricCards extends StatelessWidget {
  const _MetricCards({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
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
                  'min → ∞',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'W: 0 → ∞',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Container(
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
                  'min → ∞',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'H: 0 → ∞',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard();

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.withValues(alpha: 0.3),
          width: 0.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What is an unbounded constraint?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.8),
              ),
            ),
            const Text(
              'The parent sets no limit. The child can be any size even infinite.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
