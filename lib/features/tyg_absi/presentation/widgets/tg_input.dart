import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/tyg_absi_notifier.dart';
import '../../domain/controllers.dart';
import '../../domain/models.dart';
import 'input_field.dart';

/// TG input with segmented units (mg/dL | mmol/L)
class TGInput extends ConsumerWidget {
  const TGInput(this.resetToken, {super.key});
  final resetToken;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(measurementsProvider);
    final notifier = ref.read(measurementsProvider.notifier);
    final ctrl = ref.watch(tgControllerProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Fasting Triglycerides', style: Theme.of(context).textTheme.labelLarge),
      const SizedBox(height: 8),
      NumberTextField(
        controller: ctrl,
        key: ValueKey('tg-$resetToken'),
        hint: 'e.g., 150 or 1.7',
        prefixIcon: Icons.opacity_rounded,
        onChanged: notifier.setTriglycerides,
        trailing: UnitSegmented<TGUnit>(
          value: m.tgUnit,
          segments: const {
            TGUnit.mgdl: 'mg/dL',
            TGUnit.mmoll: 'mmol/L',
          },
          onChanged: notifier.setTGUnit,
        ),
        helper: 'Enter mg/dL or switch to mmol/L (auto × 88.57).',
      ),
    ]);
  }
}