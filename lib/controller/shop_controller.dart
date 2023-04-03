import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/url.dart';

class ShopController extends GetxController {
  AddressController addressController = Get.put(AddressController());

  RxInt filter = 0.obs;
  List filterList = [
    "best seller",
    // "non veg",
    // "veg",
    // "eggs",
    "low to high",
    "high to low"
  ];
  Future<ServerResponse> getShop({required String id}) async {
    String url = kMainUrl + getShopUrl + id;
    ServerResponse response = await responseHandlerGet(
      url: url,
    );
    return response;
  }

  Future<ServerResponse> getShopByPincode() async {
    String url = kMainUrl + getShopByPincodeUrl;

    ServerResponse response = await responseHandler(
      body: {
        // 'pincode': addressController.address.isEmpty
        //     ? addressController.defaultPincode.value
        //     : addressController.address[addressController.selectedIndex.value]
        //             ['pincode']
        //         .toString()
        'pincode': "453331",
      },
      url: url,
    );

    return response;
  }

  Future<ServerResponse> getShopByCategory({required String categoryId}) async {
    String url = kMainUrl + getCategoryByShopUrl;

    ServerResponse response = await responseHandler(
      body: {
        'categories': categoryId,
        // 'pincode': addressController.address.isEmpty
        //     ? addressController.defaultPincode.value
        //     : addressController.address[addressController.selectedIndex.value]
        //             ['pincode']
        //         .toString(),
        'pincode': "453331",
      },
      url: url,
    );

    return response;
  }
}
