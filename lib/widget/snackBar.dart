import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> snackBar(
    {required BuildContext context, required String title}) {
  final colorScheme = Theme.of(context).colorScheme;
  final textTheme = Theme.of(context).textTheme;
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: colorScheme.secondary,
      elevation: 0,
      behavior: SnackBarBehavior.fixed,
      duration: const Duration(seconds: 2),
      content: Text(
        title,
      ),
    ),
  );
}
