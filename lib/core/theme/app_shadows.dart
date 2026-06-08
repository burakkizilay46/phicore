import 'package:flutter/material.dart';

/// PhiCore gölge / elevation sistemi.
class AppShadows {
  AppShadows._();

  static List<BoxShadow> get subtle => [
        const BoxShadow(
          color: Color(0x15FFFFFF),
          blurRadius: 8,
          offset: Offset(0, 2),
        ),
      ];

  static List<BoxShadow> get soft => [
        const BoxShadow(
          color: Color(0x10FFFFFF),
          blurRadius: 16,
          offset: Offset(0, 4),
        ),
      ];

  static List<BoxShadow> get medium => [
        const BoxShadow(
          color: Color(0x0DFFFFFF),
          blurRadius: 24,
          offset: Offset(0, 8),
        ),
      ];

  static List<BoxShadow> get glass => [
        const BoxShadow(
          color: Color(0x0AFFFFFF),
          blurRadius: 20,
          offset: Offset(0, 8),
          spreadRadius: -4,
        ),
      ];

  static List<BoxShadow> get primaryGlow => [
        const BoxShadow(
          color: Color(0x20FFFFFF),
          blurRadius: 24,
          offset: Offset(0, 4),
        ),
      ];
}
