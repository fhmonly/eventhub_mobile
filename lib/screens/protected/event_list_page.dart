import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../services/api_service.dart';
import '../../models/event_model.dart';
import '../../widgets/event_card.dart';

class EventListPage extends StatelessWidget {
  final ApiService api;

  const EventListPage({super.key, required this.api});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Events')),
      body: SafeArea(
        child: FutureBuilder<List<EventModel>>(
          future: ApiService.getEvents(),
          builder: (context, snap) {
            if (snap.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snap.hasError) {
              return Center(
                child: Text(
                  'Error: ${snap.error}',
                  style: const TextStyle(color: Colors.red),
                ),
              );
            }

            if (!snap.hasData || snap.data!.isEmpty) {
              return const Center(child: Text('No events'));
            }

            final events = snap.data!;

            return ListView.separated(
              padding: const EdgeInsets.all(12),
              itemCount: events.length,
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemBuilder: (context, idx) {
                final e = events[idx];
                return EventCard(
                  event: e,
                  onTap: () => context.push('/events/${e.id}'),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
