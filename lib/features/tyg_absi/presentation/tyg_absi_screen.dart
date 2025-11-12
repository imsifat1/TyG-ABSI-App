import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../application/tyg_absi_notifier.dart';
import '../domain/controllers.dart';
import 'widgets/animated_header_backdrop.dart';
import 'widgets/blood_input_row.dart';
import 'widgets/body_inputs.dart';
import 'widgets/demographics_inputs.dart';
import 'widgets/header_score_card.dart';
import 'widgets/note.dart';
import 'widgets/preset_chips.dart';
import 'widgets/result_card.dart';
import 'widgets/section_card.dart';

final resetTriggerProvider = StateProvider<int>((ref) => 0);
class TygAbsiScreen extends ConsumerWidget {
  const TygAbsiScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final resetToken = ref.watch(resetTriggerProvider);
    final result = ref.watch(resultProvider);

    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: CustomScrollView(
          slivers: [
            SliverAppBar.large(
              title: const Text('TyG-ABSI'),
              centerTitle: false,
              pinned: true,
              actions: [

                IconButton(
                  tooltip: 'Info',
                  onPressed: () {
                    showAboutDialog(
                      context: context,
                      applicationName: 'TyG-ABSI Calculator',
                      applicationVersion: '1.0.0',
                      children: const [
                        Text(
                            'Enter fasting triglycerides and glucose with correct units, plus weight, height and waist. '
                                'We convert units automatically and compute BMI → TyG → ABSI → TyG-ABSI.'
                        ),
                      ],
                    );
                  },
                  icon: const Icon(Icons.info_outline_rounded),
                ),
                IconButton(
                  tooltip: 'Reset',
                  onPressed: ()=> _reset(ref),
                  icon: const Icon(Icons.refresh_rounded),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: AnimatedHeaderBackdrop(),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(130),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 16, 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      HeaderScoreCard(), // glass card with current score (if ready)

                      const SizedBox(height: 8),

                      PresetChips(),     // quick demo inputs
                    ],
                  ),
                ),
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(12, 12, 16, 12),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  SectionCard(
                    title: 'Demographics',
                    subtitle: 'Optional fields to describe the user.',
                    child: DemographicsInputs(resetToken: resetToken),
                  ),

                  const SizedBox(height: 14),

                  SectionCard(
                    title: 'Blood Tests',
                    subtitle: 'Enter fasting values and pick the units.',
                    child: BloodInputsRow(resetToken),
                  ),

                  const SizedBox(height: 14),

                  SectionCard(
                    title: 'Body Measurements',
                    subtitle: 'Weight, height, and waist in centimeters/kilograms.',
                    child: BodyInputs(resetToken),
                  ),

                  const SizedBox(height: 14),

                  ResultsCard(result: result),

                  const SizedBox(height: 18),

                  const Note(),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _reset(WidgetRef ref) {
    ref.read(measurementsProvider.notifier).reset();

    ref.read(ageControllerProvider).clear();
    ref.read(tgControllerProvider).clear();
    ref.read(glucoseControllerProvider).clear();
    ref.read(weightControllerProvider).clear();
    ref.read(heightControllerProvider).clear();
    ref.read(waistControllerProvider).clear();

    ref.read(resetTriggerProvider.notifier).state++; // force rebuild of TextFields
  }
}
