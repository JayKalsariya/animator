import 'package:flutter/material.dart';
import 'dart:math';
import 'package:get/get.dart'; // For navigation

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    // Animation controller for continuous circular orbit animation
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat(); // Make the animation repeat indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Sun at the center
          Center(
            child: Image.asset(
              'assets/images/sun.png', // Replace with your sun image
              width: 120,
              height: 120,
            ),
          ),
          // Animated orbit of planets
          AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Stack(
                children: [
                  _buildPlanet(100, 'Mercury', 'assets/images/mercury.png', 0),
                  _buildPlanet(150, 'Venus', 'assets/images/venus.png', pi / 4),
                  _buildPlanet(200, 'Earth', 'assets/images/earth.png', pi / 2),
                  _buildPlanet(
                      250, 'Mars', 'assets/images/mars.png', 3 * pi / 4),
                  _buildPlanet(300, 'Jupiter', 'assets/images/jupiter.png', pi),
                  _buildPlanet(
                      350, 'Saturn', 'assets/images/saturn.png', 5 * pi / 4),
                  _buildPlanet(
                      400, 'Uranus', 'assets/images/uranus.png', 3 * pi / 2),
                  _buildPlanet(
                      450, 'Neptune', 'assets/images/neptune.png', 7 * pi / 4),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  // Function to build individual planets with proper circular orbit and tap detection
  Widget _buildPlanet(
      double radius, String planetName, String imagePath, double startAngle) {
    // Calculate the angle based on the controller's value to animate the planet in a circle
    final double angle = _controller.value * 2 * pi + startAngle;
    return Positioned(
      left: radius * cos(angle) - 20,
      top: radius * sin(angle) - 20,
      child: GestureDetector(
        onTap: () {
          // Get.to(() => DetailScreen(planetName: planetName));
          Get.toNamed('/detail', arguments: planetName);
        },
        child: Image.asset(
          imagePath, // Replace with your planet image
          width: 40,
          height: 40,
        ),
      ),
    );
  }
}
