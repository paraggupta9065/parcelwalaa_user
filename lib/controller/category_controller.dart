import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/url.dart';

class CategoriesController extends GetxController {
  RxInt selectedIndex = 0.obs;
  List brands = [];

  AddressController addressController = Get.put(AddressController());

  Future<ServerResponse> getCategoryStudent(
      {required String categoryId}) async {
    String url = kMainUrl + getCategoryStudentUrl + categoryId;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    return response;
  }

  Future<ServerResponse> getBrands({required String categoryId}) async {
    String url = kMainUrl + getBrandUrl + categoryId;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );
    brands = response.body['brands'];

    return response;
  }
}
