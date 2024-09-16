import 'package:flutter/material.dart';

class PlanetDetailScreen extends StatefulWidget {
  final Map<String, dynamic> planetData; // Planet data

  PlanetDetailScreen({required this.planetData});

  @override
  _PlanetDetailScreenState createState() => _PlanetDetailScreenState();
}

class _PlanetDetailScreenState extends State<PlanetDetailScreen>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  List<Animation<double>> _animations = [];

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    // Create staggered animations
    for (int i = 0; i < 9; i++) {
      final startDelayFraction = i * 0.1;
      final endDelayFraction = startDelayFraction + 0.5;
      _animations.add(Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(startDelayFraction, endDelayFraction,
              curve: Curves.easeOut),
        ),
      ));
    }

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final planetData = widget.planetData;
    final String planetName = planetData['name'];

    return Scaffold(
      appBar: AppBar(
        title: Text(planetName),
        backgroundColor: Colors.deepPurple,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Hero(
                tag: planetName,
                child: Image.asset(
                  'assets/images/${planetName.toLowerCase()}.png', // Planet image
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            const SizedBox(height: 20),
            _buildAnimatedDetailCard(
                "Mass", "${planetData['mass']} Earth masses", _animations[0]),
            _buildAnimatedDetailCard("Radius",
                "${planetData['radius']} Earth radii", _animations[1]),
            _buildAnimatedDetailCard("Orbital Period",
                "${planetData['period']} days", _animations[2]),
            _buildAnimatedDetailCard("Semi-major Axis",
                "${planetData['semi_major_axis']} AU", _animations[3]),
            _buildAnimatedDetailCard("Temperature",
                "${planetData['temperature']} K", _animations[4]),
            _buildAnimatedDetailCard(
                "Distance from Earth",
                "${planetData['distance_light_year']} light years",
                _animations[5]),
            _buildAnimatedDetailCard("Host Star Mass",
                "${planetData['host_star_mass']} Solar masses", _animations[6]),
            _buildAnimatedDetailCard("Host Star Temperature",
                "${planetData['host_star_temperature']} K", _animations[7]),
          ],
        ),
      ),
    );
  }

  // Method to build an animated card with staggered effect
  Widget _buildAnimatedDetailCard(
      String label, String value, Animation<double> animation) {
    return FadeTransition(
      opacity: animation,
      child: Card(
        elevation: 3,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                value,
                style: TextStyle(fontSize: 16, color: Colors.deepPurple),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
