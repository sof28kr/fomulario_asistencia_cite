import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.c5,
    required this.c6,
    required this.c7,
    required this.c8,
  });

  final Color? c1;
  final Color? c2;
  final Color? c3;
  final Color? c4;
  final Color? c5;
  final Color? c6;
  final Color? c7;
  final Color? c8;

  @override
  AppColors copyWith({
    Color? c1,
    Color? c2,
    Color? c3,
    Color? c4,
    Color? c5,
    Color? c6,
    Color? c7,
    Color? c8,
  }) =>
      AppColors(
        c1: c1 ?? this.c1,
        c2: c2 ?? this.c2,
        c3: c3 ?? this.c3,
        c4: c4 ?? this.c4,
        c5: c5 ?? this.c5,
        c6: c6 ?? this.c6,
        c7: c7 ?? this.c7,
        c8: c8 ?? this.c8,
      );

  @override
  AppColors lerp(AppColors? other, double t) {
    if (other is! AppColors) {
      return this;
    }
    return AppColors(
      c1: Color.lerp(c1, other.c1, t),
      c2: Color.lerp(c2, other.c2, t),
      c3: Color.lerp(c3, other.c3, t),
      c4: Color.lerp(c4, other.c4, t),
      c5: Color.lerp(c5, other.c5, t),
      c6: Color.lerp(c6, other.c6, t),
      c7: Color.lerp(c7, other.c7, t),
      c8: Color.lerp(c8, other.c8, t),
    );
  }
}
