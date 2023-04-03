import 'package:flutter/material.dart';

const Color kPrimaryColour = Color.fromRGBO(247, 195, 22, 1);
const Color kSecondryColour = Color(0xff838383);
const Color kBackgroundColour = Color.fromARGB(255, 255, 247, 247);
const Color kLinkColour = Color.fromARGB(255, 225, 112, 0);
const Color kTextColour = Color(0xff373737);

Map<int, Color> colorCodes = {
  50: kPrimaryColour.withOpacity(.01),
  100: kPrimaryColour.withOpacity(.02),
  200: kPrimaryColour.withOpacity(.03),
  300: kPrimaryColour.withOpacity(.04),
  400: kPrimaryColour.withOpacity(.05),
  500: kPrimaryColour.withOpacity(.06),
  600: kPrimaryColour.withOpacity(.07),
  700: kPrimaryColour.withOpacity(.08),
  800: kPrimaryColour.withOpacity(.09),
  900: kPrimaryColour.withOpacity(1),
};
// Green color code: FF93cd48
MaterialColor kPrimaryMaterialColour = MaterialColor(0xffF7C316, colorCodes);
