import 'package:flutter/material.dart';

Color c1 = _colorFromHex("#00154F");
Color c2 = _colorFromHex("#F2BC94");

TextStyle newstyle1 = new TextStyle(fontSize: 55, fontFamily: 'Bilbo', fontWeight: FontWeight.w900, color: c2);
TextStyle newstyle2 = new TextStyle(fontSize: 20, fontFamily: 'Bilbo', fontWeight: FontWeight.w900, color: c2, letterSpacing: 5);
TextStyle newstyle3 = new TextStyle(fontSize: 25, fontFamily: 'Bilbo', fontWeight: FontWeight.w900, color: c1, letterSpacing: 7);

Color _colorFromHex(String hexColor) {
  final hexCode = hexColor.replaceAll('#', '');
  return Color(int.parse('FF$hexCode', radix: 16));
}
