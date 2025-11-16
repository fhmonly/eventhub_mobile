import 'package:event_hub/widgets/dev_fab.dart';
import 'package:flutter/material.dart';

class AppShell extends StatelessWidget {
  final Widget child;

  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        const DevFloatingButton(), // FAB ngambang
      ],
    );
  }
}
