import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/url.dart';

class CartControllers extends GetxController {
  RxInt index = 0.obs;
  RxBool isTakeawayPosible = false.obs;

  RxInt delivery = 1.obs;

  RxMap cart = {}.obs;
  AddressController addressController = Get.put(AddressController());

  Future<void> addToCart({required String productId}) async {
    String url = kMainUrl + addCartUrl;

    ServerResponse response = await responseHandler(
      url: url,
      body: {
        "productId": productId,
        // "delivery_address_id": addressController
        //     .address[addressController.selectedIndex.value]['_id'],
        "coupon_code_id": "na",
      },
      sendToken: true,
    );

    if (response.body["status"] == "sucess") {
      Get.snackbar(response.body["status"], response.body["msg"]);
      cart.value = response.body['cart'];
    } else if (response.body["status"] == "fail") {
      Get.snackbar(response.body["status"], response.body["msg"]);
    }
  }

  Future<ServerResponse> getCart() async {
    String url = kMainUrl + getCartUrl;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    if (response.body['status'] == 'sucess') {
      cart.value = response.body['cart'];
    } else {
      cart.value = {};
    }

    return response;
  }

  Future<void> updateQty({
    required String productId,
    required String qty,
  }) async {
    String url = kMainUrl + updateQtyCartUrl;

    ServerResponse response = await responseHandler(url: url, body: {
      "productId": productId,
      "quantity": qty,
    });
    print(response.body);

    if (response.body["status"] == "sucess" || response.body["code"] == "0") {
      cart.value = {};
    }
    if (response.body["status"] == "sucess") {
      cart.value = response.body['cart'];
    }
    if (response.body["status"] == "fail") {
      Get.snackbar(response.body["status"], response.body["msg"]);
    }
  }

  Future<ServerResponse> getCoupon() async {
    String url = kMainUrl + getCouponUrl;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    return response;
  }

  Future<void> applyCoupon({required String id}) async {
    String url = kMainUrl + applyCouponUrl;

    ServerResponse response =
        await responseHandler(url: url, body: {"couponId": id});

    if (response.body["status"] == "sucess") {
      if (response.body['cart'] != null) {
        cart.value = response.body['cart'];
      }
      Get.back();
    } else if (response.body["status"] == "fail") {
      Get.snackbar(response.body["status"], response.body["msg"]);
    }
  }

  Future<void> updatePoint() async {
    String url = kMainUrl + updateCartUrl;

    ServerResponse response = await responseHandler(
      url: url,
      body: {
        "point": delivery.value,
      },
      sendToken: true,
    );

    if (response.body["status"] == "sucess") {
      Get.snackbar(response.body["status"], response.body["msg"]);
    } else if (response.body["status"] == "fail") {
      Get.snackbar(response.body["status"], response.body["msg"]);
    }
  }
}
