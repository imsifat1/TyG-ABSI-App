import 'package:flutter/material.dart';

class Note extends StatelessWidget {
  const Note();

  @override
  Widget build(BuildContext context) {
    return Text(
      'Note: Values are rounded to 2 decimals. Educational use only—this does not replace professional medical advice.',
      style: Theme.of(context).textTheme.bodySmall,
      textAlign: TextAlign.center,
    );
  }
}