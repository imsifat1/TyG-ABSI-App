import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/tyg_absi_notifier.dart';
import '../../domain/controllers.dart';
import '../../domain/models.dart';
import 'input_field.dart';

/// Glucose input with segmented units (mg/dL | mmol/L)
class GlucoseInput extends ConsumerWidget {
  const GlucoseInput(this.resetToken, {super.key});
  final resetToken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final m = ref.watch(measurementsProvider);
    final notifier = ref.read(measurementsProvider.notifier);
    final ctrl = ref.watch(glucoseControllerProvider);

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('Fasting Glucose', style: Theme.of(context).textTheme.labelLarge),
      const SizedBox(height: 8),
      NumberTextField(
        controller: ctrl,
        hint: 'e.g., 90 or 5.0',
        key: ValueKey('fg-$resetToken'),
        prefixIcon: Icons.bloodtype_rounded,
        onChanged: notifier.setGlucose,
        trailing: UnitSegmented<GlucoseUnit>(
          value: m.glucoseUnit,
          segments: const {
            GlucoseUnit.mgdl: 'mg/dL',
            GlucoseUnit.mmoll: 'mmol/L',
          },
          onChanged: notifier.setGlucoseUnit,
        ),
        helper: 'Enter mg/dL or switch to mmol/L (auto × 18).',
      ),
    ]);
  }
}