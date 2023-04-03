import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/url.dart';

class BannerController extends GetxController {
  RxBool isLoading = false.obs;
  AddressController addressController = Get.put(AddressController());

  Future<ServerResponse> getBanner() async {
    isLoading.value = true;

    String url = '${kMainUrl}${getBannerByPlacementUrl}home';

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

    isLoading.value = false;

    return response;
  }

  Future<ServerResponse> getBannerStudents() async {
    isLoading.value = true;
    String url = '${kMainUrl}${getBannerByPlacementUrl}header';

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

    isLoading.value = false;

    return response;
  }
}
