// controllers.dart (or at top of your header file)
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final tgControllerProvider      = Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController(); ref.onDispose(c.dispose); return c;
});
final glucoseControllerProvider = Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController(); ref.onDispose(c.dispose); return c;
});
final weightControllerProvider  = Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController(); ref.onDispose(c.dispose); return c;
});
final heightControllerProvider  = Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController(); ref.onDispose(c.dispose); return c;
});
final waistControllerProvider   = Provider.autoDispose<TextEditingController>((ref) {
  final c = TextEditingController(); ref.onDispose(c.dispose); return c;
});
