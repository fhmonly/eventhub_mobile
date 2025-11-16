import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class DevFloatingButton extends StatelessWidget {
  const DevFloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return const SizedBox.shrink();

    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        mini: true,
        backgroundColor: Colors.redAccent,
        onPressed: () => context.go('/dev-page'),
        child: const Icon(Icons.developer_mode),
      ),
    );
  }
}
