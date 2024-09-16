import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/planet.dart';

class JsonService {
  Future<List<Planet>> loadPlanets() async {
    final String response =
        await rootBundle.loadString('assets/data/planets.json');
    final List<dynamic> data = json.decode(response);
    return data.map((json) => Planet.fromJson(json)).toList();
  }
}
