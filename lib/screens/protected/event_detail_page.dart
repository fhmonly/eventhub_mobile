import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/event_model.dart';
import '../../services/api_service.dart';
import '../../services/favorites_service.dart';

class EventDetailPage extends StatefulWidget {
  final int id;

  const EventDetailPage({super.key, required this.id});

  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  late Future<EventModel> _future;

  @override
  void initState() {
    super.initState();
    _future = ApiService.getEventById(widget.id); // FIX
  }

  @override
  Widget build(BuildContext context) {
    final fav = Provider.of<FavoritesService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Event Detail')),
      body: FutureBuilder<EventModel>(
        future: _future,
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

          if (!snap.hasData) {
            return const Center(child: Text('Data tidak ditemukan'));
          }

          final event = snap.data!;
          final isFav = fav.isFavorite(event.id);

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// Title
                Text(
                  event.title,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                /// Date + Location
                Text(
                  '${event.startAt} • ${event.location ?? "-"}',
                  style: const TextStyle(color: Colors.grey),
                ),

                const SizedBox(height: 16),

                /// Description
                Expanded(
                  child: SingleChildScrollView(
                    child: Text(event.desc ?? "Tidak ada deskripsi"),
                  ),
                ),

                const SizedBox(height: 16),

                /// Bottom Buttons
                Row(
                  children: [
                    ElevatedButton.icon(
                      onPressed: () => fav.toggle(event.id),
                      icon: Icon(
                        isFav ? Icons.favorite : Icons.favorite_border,
                      ),
                      label: Text(isFav ? 'Favorit' : 'Tambah Favorit'),
                    ),
                    const SizedBox(width: 12),
                    OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Kembali'),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
