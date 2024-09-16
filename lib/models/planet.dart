class Planet {
  final String name;
  final String description;
  final String image;
  final double distanceFromSun; // in million km
  final double gravity; // in m/s²

  Planet({
    required this.name,
    required this.description,
    required this.image,
    required this.distanceFromSun,
    required this.gravity,
  });

  factory Planet.fromJson(Map<String, dynamic> json) {
    return Planet(
      name: json['name'],
      description: json['description'],
      image: json['image'],
      distanceFromSun: json['distanceFromSun'].toDouble(),
      gravity: json['gravity'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'description': description,
        'image': image,
        'distanceFromSun': distanceFromSun,
        'gravity': gravity,
      };
}
