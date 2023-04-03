import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/view/onboading/onboading_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1))
        .then((value) => Get.offAll(() => const OnboadingScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: kPrimaryColour,
      body: Center(
        child: CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage(
            "asset/logo.png",
          ),
        ),
      ),
    );
  }
}
