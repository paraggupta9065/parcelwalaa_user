import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/onboading_controller.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/view/auth/login_screen.dart';
import 'package:parcelwalaa_app/view/auth/signup_screen.dart';
import 'package:parcelwalaa_app/view/sCurve_screens.dart';

class OnboadingScreen extends StatefulWidget {
  const OnboadingScreen({Key? key}) : super(key: key);

  @override
  State<OnboadingScreen> createState() => _OnboadingScreenState();
}

class _OnboadingScreenState extends State<OnboadingScreen> {
  final controller = Get.put(OnboadingController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: Stack(
        children: [
          sCurveBottom(),
          Column(
            children: [
              SizedBox(
                height: Get.size.height * .75,
                width: Get.size.width,
                child: Column(
                  children: [
                    const SizedBox(height: 150),
                    Obx(
                      () => Image.asset(
                        controller.onboadingInfo[controller.index.value]
                            ["image"],
                        height: 150,
                        width: 150,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(
                      () => Text(
                        controller.onboadingInfo[controller.index.value]
                            ["line1"],
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 300,
                      child: Text(
                        controller.onboadingInfo[controller.index.value]
                            ["line2"],
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: kSecondryColour,
                          fontSize: 14,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: Get.size.height * .25,
                width: Get.size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      onPressed: () {
                        if (controller.index.value <
                            controller.onboadingInfo.length - 1) {
                          controller.index.value++;
                        } else {
                          Get.offAll(() => const LoginScreen());
                        }
                      },
                      child: Container(
                          height: 40,
                          width: 70,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.grey,
                                  offset: Offset(0.5, 0),
                                  blurRadius: 1
                                  // spreadRadius: 0.1,
                                  ),
                            ],
                          ),
                          child: const Center(
                            child: Text(
                              "Next",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        Get.offAll(() => SignUpScreen());
                      },
                      child: const Center(
                        child: Text(
                          "Skip",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 20),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
