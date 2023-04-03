import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/controller/auth_controller.dart';
import 'package:parcelwalaa_app/controller/cart_controller.dart';
import 'package:parcelwalaa_app/controller/order_controller.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/view/homepage/homepage.dart';
import 'package:parcelwalaa_app/view/splashscreen.dart';

AddressController addressController = Get.put(AddressController());

void main() async {
  await Hive.initFlutter();
  await Hive.openBox("login");
  await Firebase.initializeApp();
  await firebaseMessengerImplimentation();
  HttpOverrides.global = MyHttpOverrides();
  // addressController.getLocation();

  //TODO:uncommect
  runApp(MyApp());
}

Future<void> firebaseMessengerImplimentation() async {
  try {
    final authController = Get.put(AuthController());
    OrdersController ordersController = Get.put(OrdersController());

    if (authController.isLogin()) {
      AuthController authController = Get.put(AuthController());
      FirebaseMessaging messaging = FirebaseMessaging.instance;

      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      String? token = await messaging.getToken();
      await authController.setToken(token: token!);

      NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: false,
        badge: true,
        carPlay: false,
        criticalAlert: false,
        provisional: false,
        sound: true,
      );

      FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
        dynamic data = message.data;

        if (data["status"] != null) {
          ordersController.status.value = data["status"];
        }
        if (data["driver"] != null) {
          ordersController.driver.value = data["driver"];
        }
      });
    }
  } catch (e) {
    print(e);
  }
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  final authController = Get.put(AuthController());
  final addressController = Get.put(AddressController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bingrr',
        theme: ThemeData(
          fontFamily: 'Poppins',

          // cursorColor: kTextColour,
          primarySwatch: kPrimaryMaterialColour,
        ),
        home: authController.isLogin() == true
            ? const Homepage()
            : const SplashScreen(),
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
