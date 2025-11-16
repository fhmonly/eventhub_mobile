import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesService extends ChangeNotifier {
  static const _key = 'favorite_event_ids';
  final Set<int> _ids = {};

  Set<int> get ids => _ids;

  FavoritesService() {
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList(_key) ?? [];
    _ids.clear();
    _ids.addAll(list.map((s) => int.tryParse(s) ?? -1).where((v) => v >= 0));
    notifyListeners();
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(_key, _ids.map((e) => e.toString()).toList());
  }

  bool isFavorite(int id) => _ids.contains(id);

  Future<void> toggle(int id) async {
    if (_ids.contains(id)) {
      _ids.remove(id);
    } else {
      _ids.add(id);
    }
    notifyListeners();
    await _save();
  }
}
