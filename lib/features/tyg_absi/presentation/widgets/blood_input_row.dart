import 'package:flutter/material.dart';
import 'package:tyg_absi/features/tyg_absi/presentation/widgets/tg_input.dart';

import 'glucose_input.dart';

class BloodInputsRow extends StatelessWidget {
  const BloodInputsRow(this.resetToken);
  final resetToken;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, c) {
        final isWide = c.maxWidth > 560;
        if (isWide) {
          return Row(
            children: [
              Expanded(child: TGInput(resetToken,)),
              SizedBox(width: 12),
              Expanded(child: GlucoseInput(resetToken,)),
            ],
          );
        }
        return Column(
          children: [
            TGInput(resetToken),
            SizedBox(height: 12),
            GlucoseInput(ValueKey('g-$resetToken'),),
          ],
        );
      },
    );
  }
}