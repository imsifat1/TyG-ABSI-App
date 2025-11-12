
// Glassy score card docked at the bottom of the app bar
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../application/tyg_absi_notifier.dart';

class HeaderScoreCard extends ConsumerWidget {
  const HeaderScoreCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final result = ref.watch(resultProvider);
    final cs = Theme.of(context).colorScheme;

    // Show only the “big number” when ready; otherwise a hint
    final String title = (result.error == null && result.tygAbsi != null)
        ? 'TyG-ABSI'
        : 'Ready to calculate TyG-ABSI';
    final String value = (result.error == null && result.tygAbsi != null)
        ? (result.tygAbsi!).toStringAsFixed(2)
        : 'Enter all inputs';

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: cs.surface.withOpacity(0.55),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: cs.outlineVariant.withOpacity(0.5)),
          ),
          child: Row(
            children: [
              Container(
                width: 38, height: 38,
                decoration: BoxDecoration(
                  color: cs.primary.withOpacity(0.16),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(Icons.insights_rounded, color: cs.primary),
              ),
              const SizedBox(width: 12,),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 0),
                    Text(
                      (result.error == null && result.tygAbsi != null)
                          ? 'TyG Index × ABSI'
                          : 'Fasting TG, Glucose, Weight, Height, Waist',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 220),
                child: Text(
                  value,
                  key: ValueKey(value),
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.2),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}