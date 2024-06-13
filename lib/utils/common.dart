import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

/// ----for generating random colors
Color generateRandomLightColor() {
  const minLightness = 0.7;
  const maxLightness = 0.9;

  final hslColor = HSLColor.fromColor(Color.fromARGB(255, Random().nextInt(256), Random().nextInt(256), Random().nextInt(256)));
  final lightness = (Random().nextDouble() * (maxLightness - minLightness)) + minLightness;
  return hslColor.withLightness(lightness).toColor();
}

/// ----for generating random uuid
String getUUID(){
  return const Uuid().v1();
}
