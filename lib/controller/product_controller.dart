import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:hive/hive.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/snackbar.dart';
import 'package:parcelwalaa_app/utils/url.dart';

class ProductController extends GetxController {
  RxList products = [].obs;
  RxBool isLoading = false.obs;

  String vegType = '';
  String price = '';

  Future<ServerResponse> getProduct({required String id}) async {
    String url = kMainUrl + getProductUrl + id;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    return response;
  }

  Future<ServerResponse> getProductsByShop({required String id}) async {
    String url = kMainUrl + getProductByShopUrl + id;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    return response;
  }

  Future<ServerResponse> getProductsByFilter({required Map map}) async {
    products.value = [];

    isLoading.value = true;
    String url = kMainUrl + getProductByFilterUrl;
    if (vegType.isNotEmpty) {
      map['veg_type'] = vegType;
    }
    if (price.isNotEmpty) {
      map['price'] = vegType;
    }
    ServerResponse response = await responseHandler(
      body: map,
      url: url,
    );
    if (response.body['status'] == "sucess") {
      products.value = response.body['products'];
    } else if (response.body['status'] == "fail") {
      showSnackbar(response.body['msg'].toString());
    }
    isLoading.value = false;
    return response;
  }

  Future<void> getSearchProducts({required String key}) async {
    isLoading.value = true;
    String url = kMainUrl + getSearchProductUrl + key;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );
    if (response.body['status'] == "sucess") {
      products.value = response.body['product'];
    } else if (response.body['status'] == "fail") {
      products.value = [];

      showSnackbar(response.body['msg'].toString());
    }
    isLoading.value = false;
  }
}
