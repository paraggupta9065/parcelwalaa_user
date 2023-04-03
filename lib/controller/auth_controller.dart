import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/snackbar.dart';
import 'package:parcelwalaa_app/utils/url.dart';
import 'package:parcelwalaa_app/view/auth/otp_screen.dart';
import 'package:parcelwalaa_app/view/homepage/homepage.dart';
import 'package:device_info_plus/device_info_plus.dart';

class AuthController extends GetxController {
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();
  TextEditingController otp = TextEditingController();

  RxBool isLoading = false.obs;
  sendOtp({required bool isNew}) async {
    isLoading.value = true;
    String url = kMainUrl + sendOtpUrl;

    ServerResponse response = await responseHandler(
      url: url,
      body: {"number": number.text.toString()},
      sendToken: false,
    );

    if (response.body['status'] == "sucess") {
      otp.text = response.body['code'];
      Get.off(() => OtpScreen(
            number: number.text.toString(),
            isNew: isNew,
          ));
    } else if (response.body['status'] == "fail") {
      showSnackbar(response.body['msg'].toString());
    }

    isLoading.value = false;
  }

  verifyOtp({required String number, required bool isNew}) async {
    isLoading.value = true;
    String url = kMainUrl + verifyOtpUrl;
    Map body = {
      "number": number,
      "otpCode": otp.text.toString(),
    };

    if (isNew) {
      body['name'] = name.text;
      body['role'] = "user";
    }

    ServerResponse response =
        await responseHandler(url: url, body: body, sendToken: false);

    if (response.body['status'] == "sucess" &&
        response.body['role'] != "user") {
      showSnackbar("Use ${response.body['role']} app to access rights");
    } else if (response.body['status'] == "sucess") {
      await addLoginLog(
          token: response.body['token'], user: response.body['user']);
      Get.off(() => const Homepage());
    } else if (response.body['status'] == "fail") {
      showSnackbar(response.body['msg'].toString());
    }
    isLoading.value = false;
  }

  var box = Hive.box('login');
  addLoginLog({
    required String token,
    required dynamic user,
  }) async {
    await box.put("token", token);
    await box.put("user", user);
  }

  removeLoginLog() async {
    await box.delete("token");
    await box.delete("user");
  }

  bool isLogin() {
    dynamic token = box.get("token");
    if (token != null) {
      return true;
    }
    return false;
  }

  String getToken() {
    dynamic token = box.get("token");
    return token;
  }

  dynamic getUser() {
    dynamic user = box.get("user");
    return user;
  }

  setToken({required String token}) async {
    isLoading.value = true;
    String url = kMainUrl + setTokenUrl;

    ServerResponse response = await responseHandler(
      url: url,
      body: {
        "fmc_token": token,
        "device_id": await _getId(),
      },
      sendToken: true,
    );

    if (response.body['status'] == "sucess") {
      print(response.body);
    } else if (response.body['status'] == "fail") {
      showSnackbar(response.body['msg'].toString());
    }

    isLoading.value = false;
  }

  Future<String?> _getId() async {
    var deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
}
