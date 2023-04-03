import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/auth_controller.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:parcelwalaa_app/utils/snackbar.dart';
import 'package:parcelwalaa_app/view/auth/signup_screen.dart';
import 'package:parcelwalaa_app/view/sCurve_screens.dart';
import 'package:url_launcher/url_launcher.dart';

class OtpScreen extends StatefulWidget {
  final String number;
  final bool isNew;

  OtpScreen({
    required this.number,
    required this.isNew,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: Stack(
        children: [
          sCurveTop(),
          Column(
            children: [
              SizedBox(
                height: Get.size.height * 0.25,
                width: Get.size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      "OTP",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Verify OTP",
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: SizedBox(
                  height: Get.size.height * 0.75,
                  width: Get.size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        Row(children: const [Text("One Time Password")]),
                        const SizedBox(height: 5),
                        Container(
                          height: 55,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 0),
                            child: TextFormField(
                              controller: authController.otp,
                              cursorColor: kTextColour,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        InkWell(
                          onTap: () {
                            try {
                              String whatsappUrl =
                                  "whatsapp://send?phone=+918109437851" +
                                      "&text= ";
                              _launchUrl(whatsappUrl);
                            } catch (e) {
                              showSnackbar(e.toString());
                            }
                          },
                          child: Container(
                            height: 55,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: kPrimaryColour,
                              borderRadius: BorderRadius.all(
                                Radius.circular(15),
                              ),
                            ),
                            child: const Center(
                              child: Text(
                                "Open Whatsapp",
                                style: TextStyle(
                                  fontSize: 17,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        InkWell(
                          onTap: () => authController.verifyOtp(
                              number: widget.number, isNew: widget.isNew),
                          child: Container(
                              height: 55,
                              width: double.infinity,
                              decoration: const BoxDecoration(
                                color: kPrimaryColour,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(15),
                                ),
                              ),
                              child: Obx(
                                () => Center(
                                  child: authController.isLoading.value
                                      ? isLoading()
                                      : const Text(
                                          "Verify OTP",
                                          style: TextStyle(
                                            fontSize: 17,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                ),
                              )),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't receive OTP?  ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            InkWell(
                              onTap: () {},
                              child: const Text(
                                "Resend",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _launchUrl(String _url) async {
    if (!await launchUrl(Uri.parse(_url))) {
      throw Exception('Could not launch $_url');
    }
  }
}
