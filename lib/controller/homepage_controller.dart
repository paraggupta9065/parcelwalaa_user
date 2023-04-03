import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/url.dart';

class HomepageController extends GetxController {
  AddressController addressController = Get.put(AddressController());

  RxInt index = 0.obs;
  PageController controller = PageController();

  Future<ServerResponse> getCategory() async {
    String url = kMainUrl + getCategoryUrl;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    return response;
  }

  Future<ServerResponse> getCategoryStudents() async {
    String url = kMainUrl + getCategoryStudentsUrl;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    return response;
  }
}
