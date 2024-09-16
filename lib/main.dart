import 'package:flutter/material.dart';
import 'package:galaxy_planets_animator/controller/planet_controller.dart';
import 'package:galaxy_planets_animator/screens/splash_screen.dart';
import 'package:get/get.dart';
import 'utils/themes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final PlanetController planetController = Get.put(PlanetController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => GetMaterialApp(
          title: 'Galaxy Planets (Animator)',
          debugShowCheckedModeBanner: false,
          theme: Themes.lightTheme,
          darkTheme: Themes.darkTheme,
          themeMode: planetController.isDarkTheme.value
              ? ThemeMode.dark
              : ThemeMode.light,
          home: SplashScreen(),
        ));
  }
}
