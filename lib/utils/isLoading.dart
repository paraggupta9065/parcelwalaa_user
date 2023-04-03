import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:parcelwalaa_app/utils/colors.dart';

Widget isLoading({
  Color color = kTextColour,
  double size = 50,
}) {
  return SpinKitRipple(
    color: color,
    size: size,
  );
}
