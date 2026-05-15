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
        subtitle: 'Drag sliders to feel it',
        subtitleSize: 13,
      ),
      body: _BodyContent(),
    );
  }
}

class _BodyContent extends StatefulWidget {
  const _BodyContent({super.key});

  @override
  State<_BodyContent> createState() => _BodyContentState();
}

class _BodyContentState extends State<_BodyContent> {
  double _width = 170;
  double _height = 90;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(20),
      child: Column(
        children: [
          SizedBox(),
          SliderRow(
            label: 'Width',
            value: _width,
            min: 80,
            max: 210,
            onChanged: (v) => setState(() => _width = v),
          ),
          SliderRow(
            label: 'Height',
            value: _height,
            min: 50,
            max: 130,
            onChanged: (v) => setState(() => _height = v),
          ),
          const SizedBox(height: 10),
          const Spacer(),
          AppButton(
            label: 'Next: loose',
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
