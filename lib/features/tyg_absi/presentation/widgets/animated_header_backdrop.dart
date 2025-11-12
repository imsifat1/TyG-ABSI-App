import 'package:flutter/material.dart';

// Animated gradient + soft blobs
class AnimatedHeaderBackdrop extends StatefulWidget {
  const AnimatedHeaderBackdrop({super.key});

  @override
  State<AnimatedHeaderBackdrop> createState() => _AnimatedHeaderBackdropState();
}

class _AnimatedHeaderBackdropState extends State<AnimatedHeaderBackdrop>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) {
        final t = _ctrl.value;
        return Stack(
          fit: StackFit.expand,
          children: [
            // Animated gradient
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    cs.primaryContainer,
                    cs.secondaryContainer.withOpacity(0.85),
                    cs.surface,
                  ],
                  begin: Alignment(-0.8 + 0.6 * t, -1.0),
                  end: Alignment(1.0, 0.6 - 0.4 * t),
                ),
              ),
            ),
            // Soft "blob" accents
            Positioned(
              left: 40 + 20 * t,
              top: 50,
              child: _Blob(color: cs.primary.withOpacity(0.18), size: 140),
            ),
            Positioned(
              right: 24,
              bottom: 30 + 15 * (1 - t),
              child: _Blob(color: cs.tertiary.withOpacity(0.16), size: 110),
            ),
          ],
        );
      },
    );
  }
}

class _Blob extends StatelessWidget {
  final Color color;
  final double size;
  const _Blob({required this.color, required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size, height: size,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(color: color, blurRadius: 40, spreadRadius: 10)],
      ),
    );
  }
}
