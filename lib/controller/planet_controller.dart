import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/planet.dart';
import '../services/json_service.dart';
import 'dart:convert';

class PlanetController extends GetxController {
  var planets = <Planet>[].obs;
  var favorites = <Planet>[].obs;
  var isDarkTheme = false.obs;

  final JsonService _jsonService = JsonService();

  @override
  void onInit() {
    super.onInit();
    loadPlanets();
    loadFavorites();
    loadTheme();
  }

  void loadPlanets() async {
    var loadedPlanets = await _jsonService.loadPlanets();
    planets.assignAll(loadedPlanets);
  }

  void toggleFavorite(Planet planet) {
    if (favorites.contains(planet)) {
      favorites.remove(planet);
    } else {
      favorites.add(planet);
    }
    saveFavorites();
  }

  void saveFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> favs =
        favorites.map((planet) => json.encode(planet.toJson())).toList();
    prefs.setStringList('favorites', favs);
  }

  void loadFavorites() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favs = prefs.getStringList('favorites');
    if (favs != null) {
      favorites.value =
          favs.map((item) => Planet.fromJson(json.decode(item))).toList();
    }
  }

  void toggleTheme() {
    isDarkTheme.value = !isDarkTheme.value;
    saveTheme();
  }

  void saveTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme.value);
  }

  void loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isDarkTheme.value = prefs.getBool('isDarkTheme') ?? false;
  }
}
