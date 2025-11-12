// lib/features/tyg_absi/presentation/widgets/demographics_inputs.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../application/tyg_absi_notifier.dart';
import '../../domain/models.dart';
import '../../domain/controllers.dart';
import 'input_field.dart';

class DemographicsInputs extends ConsumerWidget {
  const DemographicsInputs({super.key, this.resetToken});
  final Object? resetToken;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(measurementsProvider.notifier);
    final sex = ref.watch(measurementsProvider.select((m) => m.sex));
    final ageCtrl = ref.watch(ageControllerProvider);

    return Column(
      children: [
        // Age
        NumberField(
          key: ValueKey('age-$resetToken'),
          label: 'Age',
          suffix: 'years',
          kind: FieldKind.custom,        // add 'custom' to your enum, or reuse waist with a new setter
          prefixIcon: Icons.cake_outlined,
          hint: 'e.g., 40',
          onChangedOverride: notifier.setAge, // NEW: expose this in NumberField (see below)
          controllerOverride: ageCtrl,        // NEW
        ),
        const SizedBox(height: 12),

        // Sex segmented
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Sex', style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              SegmentedButton<Sex>(
                segments: const [
                  ButtonSegment(value: Sex.male,   label: Text('Male'),   icon: Icon(Icons.male_rounded)),
                  ButtonSegment(value: Sex.female, label: Text('Female'), icon: Icon(Icons.female_rounded)),
                ],
                selected: {sex},
                onSelectionChanged: (s) => notifier.setSex(s.first),
                style: const ButtonStyle(
                  visualDensity: VisualDensity.compact,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
