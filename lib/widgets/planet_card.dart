import 'package:flutter/material.dart';
import 'package:galaxy_planets_animator/controller/planet_controller.dart';
import 'package:galaxy_planets_animator/screens/planet_detail_screen.dart';
import 'package:get/get.dart';
import '../models/planet.dart';

class PlanetCard extends StatelessWidget {
  final Planet planet;
  final PlanetController controller = Get.find<PlanetController>();

  PlanetCard({required this.planet});

  @override
  Widget build(BuildContext context) {
    bool isFavorite = controller.favorites.contains(planet);
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isFavorite ? Colors.yellow[100] : Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          leading: Image.asset(
            planet.image,
            width: 50,
            height: 50,
          ),
          title: Text(planet.name),
          trailing: IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_border,
              color: isFavorite ? Colors.red : null,
            ),
            onPressed: () {
              controller.toggleFavorite(planet);
            },
          ),
          onTap: () {
            Get.to(() => PlanetDetailScreen(planetData: planet.toJson()));
          },
        ),
      ),
    );
  }
}
