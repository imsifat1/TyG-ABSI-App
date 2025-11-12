// Preset chips for quick demo / testing
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/tyg_absi_notifier.dart';
import '../../domain/controllers.dart';
import '../../domain/models.dart';

class PresetChips extends ConsumerWidget {
  const PresetChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final n = ref.read(measurementsProvider.notifier);

    final tgC      = ref.read(tgControllerProvider);
    final gluC     = ref.read(glucoseControllerProvider);
    final wtC      = ref.read(weightControllerProvider);
    final htC      = ref.read(heightControllerProvider);
    final waistC   = ref.read(waistControllerProvider);

    void applyNormal() {
      final ageC = ref.read(ageControllerProvider);
      ageC.text = '40'; ref.read(measurementsProvider.notifier).setAge('40');
      ref.read(measurementsProvider.notifier).setSex(Sex.male);
      tgC.text = '120'; n.setTriglycerides('120');
      gluC.text = '90'; n.setGlucose('90');
      wtC.text = '70'; n.setWeight('70');
      htC.text = '170'; n.setHeight('170');
      waistC.text = '84'; n.setWaist('84');
    }

    void applyElevated() {
      final ageC = ref.read(ageControllerProvider);
      ageC.text = '40'; ref.read(measurementsProvider.notifier).setAge('40');
      ref.read(measurementsProvider.notifier).setSex(Sex.male);
      tgC.text = '220'; n.setTriglycerides('220');
      gluC.text = '130'; n.setGlucose('130');
      wtC.text = '92'; n.setWeight('92');
      htC.text = '168'; n.setHeight('168');
      waistC.text = '102'; n.setWaist('102');
    }

    return Wrap(
      spacing: 8,
      runSpacing: 4,
      children: [
        _PresetChip(
          icon: Icons.flash_on_rounded,
          label: 'Preset: Normal',
          onTap: applyNormal,
        ),
        _PresetChip(
          icon: Icons.trending_up_rounded,
          label: 'Preset: Elevated',
          onTap: applyElevated,
        ),
      ],
    );
  }
}

class _PresetChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _PresetChip({required this.icon, required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: cs.secondaryContainer,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: cs.onSecondaryContainer),
            const SizedBox(width: 6),
            Text(label, style: TextStyle(color: cs.onSecondaryContainer)),
          ],
        ),
      ),
    );
  }
}