import 'package:flutter/material.dart';
import 'package:galaxy_planets_animator/controller/planet_controller.dart';
import 'package:get/get.dart';

class FavoriteScreen extends StatelessWidget {
  final PlanetController planetController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorites')),
      body: Obx(() {
        if (planetController.favorites.isEmpty) {
          return const Center(child: Text('No favorites yet!'));
        }
        return ListView.builder(
          itemCount: planetController.favorites.length,
          itemBuilder: (context, index) {
            String planetName = planetController.favorites[index] as String;
            return ListTile(
              title: Text(planetName),
            );
          },
        );
      }),
    );
  }
}
