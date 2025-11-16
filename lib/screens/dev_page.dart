import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../services/dev_config_service.dart';

class DevPage extends StatefulWidget {
  const DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  final baseUrlC = TextEditingController();

  bool loading = true;

  @override
  void initState() {
    super.initState();
    load();
  }

  Future<void> load() async {
    baseUrlC.text = DevConfigService.baseUrl;

    setState(() => loading = false);
  }

  Future<void> save() async {
    await DevConfigService.setBaseUrl(baseUrlC.text);

    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Saved")));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Dev Config")),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          TextField(
            controller: baseUrlC,
            decoration: const InputDecoration(labelText: "Base URL"),
          ),
          const SizedBox(height: 30),
          ElevatedButton(onPressed: save, child: const Text("Save")),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () => context.go('/'),
            child: const Text("Back"),
          ),
        ],
      ),
    );
  }
}
