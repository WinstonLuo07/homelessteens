import 'dart:async';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

Color fromHexcode(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}


