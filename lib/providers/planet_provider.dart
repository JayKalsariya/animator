import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class PlanetProvider with ChangeNotifier {
  List<dynamic> _planets = [];
  List<dynamic> get planets => _planets;

  List<dynamic> _favorites = [];
  List<dynamic> get favorites => _favorites;

  Future<void> loadPlanets() async {
    final String response =
        await rootBundle.loadString('lib/assets/planets.json');
    _planets = json.decode(response);
    notifyListeners();
  }

  void toggleFavorite(String planetName) {
    if (_favorites.contains(planetName)) {
      _favorites.remove(planetName);
    } else {
      _favorites.add(planetName);
    }
    _saveFavorites();
    notifyListeners();
  }

  Future<void> _saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setStringList('favorites', _favorites.cast<String>());
  }

  Future<void> loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _favorites = prefs.getStringList('favorites') ?? [];
    notifyListeners();
  }
}
