import 'package:flutter/material.dart';

import 'input_field.dart';

class BodyInputs extends StatelessWidget {
  const BodyInputs(this.resetToken);
  final resetToken;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _TwoCol(
          left: NumberField(
            key: ValueKey('w-$resetToken'),
            label: 'Weight',
            suffix: 'kg',
            kind: FieldKind.weight,
            prefixIcon: Icons.monitor_weight_outlined,
            hint: 'e.g., 70.5',
          ),
          right: NumberField(
            key: ValueKey('h-$resetToken'),
            label: 'Height',
            suffix: 'cm',
            kind: FieldKind.height,
            prefixIcon: Icons.height_rounded,
            hint: 'e.g., 170',
          ),
        ),
        const SizedBox(height: 12),
        NumberField(
          key: ValueKey('wc-$resetToken'),
          label: 'Waist Circumference',
          suffix: 'cm',
          kind: FieldKind.waist,
          prefixIcon: Icons.straighten_rounded,
          hint: 'e.g., 85',
          helper: 'Measure at the midpoint between rib and hip.',
        ),
      ],
    );
  }
}

class _TwoCol extends StatelessWidget {
  final Widget left;
  final Widget right;
  const _TwoCol({required this.left, required this.right});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (_, c) {
      final isWide = c.maxWidth > 560;
      if (isWide) {
        return Row(children: [Expanded(child: left), const SizedBox(width: 12), Expanded(child: right)]);
      }
      return Column(children: [left, const SizedBox(height: 12), right]);
    });
  }
}