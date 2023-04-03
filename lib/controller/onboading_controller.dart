import 'package:get/state_manager.dart';

class OnboadingController extends GetxController {
  RxList onboadingInfo = [
    {
      "image": "asset/onboading1.webp",
      "line1": "Choose A Tasty Dish",
      "line2": "Order anything you want from your Favorite restaurant.",
    },
    {
      "image": "asset/onboading2.png",
      "line1": "Easy Payment",
      "line2":
          "Payment made easy through debit card, credit card  & more ways to pay for your food",
    },
    {
      "image": "asset/onboading3.png",
      "line1": "Enjoy the Taste!",
      "line2":
          "Healthy eating means eating a variety of foods that give you the nutrients you need to maintain your health.",
    }
  ].obs;
  RxInt index = 0.obs;
}
