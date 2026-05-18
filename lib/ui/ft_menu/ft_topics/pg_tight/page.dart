import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../app.dart';

@RoutePage()
class ConstrainTightPage extends StatefulWidget {
  const ConstrainTightPage({super.key});

  @override
  State<ConstrainTightPage> createState() => _ConstrainTightPageState();
}

class _ConstrainTightPageState extends State<ConstrainTightPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: CustomAppBar(
        title: 'Tight Constraints',
        titleSize: 16,
        subtitle: 'Drag sliders to explore the range',
        subtitleSize: 13,
      ),
      body: _BodyContent(),
    );
  }
}

class _BodyContent extends StatefulWidget {
  const _BodyContent();

  @override
  State<_BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<_BodyContent> {
  double _width = 170;
  double _height = 90;

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
            min: 80,
            max: 210,
            onChanged: (v) => setState(() => _width = v.roundToDouble()),
          ),
          const SizedBox(height: 8),
          SliderRow(
            label: 'Height',
            value: _height,
            min: 50,
            max: 130,
            onChanged: (v) => setState(() => _height = v.roundToDouble()),
          ),
          const SizedBox(height: 8),
          const _InfoCard(),
          const Spacer(),
          AppButton(
            label: 'Next: loose',
            onTap: () {
              context.pushRoute(const ConstrainLooseRoute());
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
                    child: Text(
                      'SizedBox ${width.toInt()}×${height.toInt()}',
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
                  'min == max (tight)',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'W: ${width.toInt()}',
                  style: const TextStyle(
                    fontSize: 22,
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
                  'min == max (tight)',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.withValues(alpha: 0.7),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'H: ${height.toInt()}',
                  style: const TextStyle(
                    fontSize: 22,
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
              'What is a tight constraint?',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.grey.withValues(alpha: 0.8),
              ),
            ),
            const Text(
              'The parent forces an exact size. The child has no choice — it must be exactly that width and height.',
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
