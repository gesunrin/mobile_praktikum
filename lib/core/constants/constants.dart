import 'package:flutter/material.dart';

class AppConstants {
  static const String appName = 'Dashboard Mahasiswa D4TI';
  static const String appVersion = '1.0.0';

  static const String userPrefsKey = 'user_prefs';

  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;

  static const double radiusSmall = 8.0;
  static const double radiusMedium = 12.0;
  static const double radiusLarge = 16.0;

  static const List<List<Color>> dashboardGradients = [
    [Color(0xFF6F60EA), Color(0xFF9A4D22)],
    [Color(0xFFFF69B4), Color(0xFFFF5760)],
    [Color(0xFF45B7D1), Color(0xFF96C93D)],
    [Color(0xFF43E97B), Color(0xFF38F9D7)],
  ];

  static const List<Color> gradientPurple = [
    Color(0xFF6F60EA),
    Color(0xFF9A4D22),
  ];

  static const List<Color> gradientPink = [
    Color(0xFFFF69B4),
    Color(0xFFFF5760),
  ];

  static const List<Color> gradientBlue = [
    Color(0xFF45B7D1),
    Color(0xFF96C93D),
  ];

  static const List<Color> gradientGreen = [
    Color(0xFF43E97B),
    Color(0xFF38F9D7),
  ];
}