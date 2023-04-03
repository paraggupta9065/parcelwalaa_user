import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/url.dart';
import 'package:parcelwalaa_app/view/address/add_address.dart';
import 'package:permission_handler/permission_handler.dart';

class AddressController extends GetxController {
  // TextEditingController name = TextEditingController();
  // TextEditingController line1 = TextEditingController();
  // TextEditingController landmark = TextEditingController();
  // TextEditingController pincode = TextEditingController();
  // TextEditingController city = TextEditingController();
  // TextEditingController contactNo = TextEditingController();
  // String state = "Madhya Pradesh";
  // TextEditingController deliveryNote = TextEditingController();
  // RxString type = "friendOrFamily".obs;
  RxBool isLoading = false.obs;
  RxBool visible = false.obs;
  // RxInt selectedIndex = 0.obs;
  // RxString lat = "".obs;
  // RxString long = "".obs;
  // RxString defaultPincode = "465674".obs;
  // List address = [
  //   {
  //     {
  //       "_id": "63d3738104f0b843bf7eb0e4",
  //       "name": "parag gupta",
  //       "line1": " Tiwaris 55,Vardhman Green City,Ayodhya Nagar",
  //       "landmark": "narela jod",
  //       "pincode": "465674",
  //       "user_id": "634006db836adad6d541861a",
  //       "contact_no": "8319905007",
  //       "state": "Madhya Pradesh",
  //       "city": "Madhya Pradesh",
  //       "delivery_note": "",
  //       "lat": " 23.2710713",
  //       "long": "77.4725984",
  //       "type": "friendOrFamily",
  //     }
  //   }
  // ];

  // Future<void> getLocation() async {
  //   isLoading.value = true;

  //   var status = await Permission.locationWhenInUse.request();
  //   if (status.isGranted) {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);
  //     lat.value = position.latitude.toString();
  //     long.value = position.longitude.toString();
  //   } else if (status.isDenied) {
  //     Get.snackbar("Permissions", "Permission Denied");
  //   }

  //   isLoading.value = false;
  // }

  Future<ServerResponse> getAddress() async {
    isLoading.value = true;
    String url = kMainUrl + getAddressUrl;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );
    // address = response.body["addressList"];

    if (response.body["status"] == "fail") {
      Get.snackbar(response.body["status"], response.body["msg"]);
    }

    isLoading.value = false;
    return response;
  }

  // Future<ServerResponse> addAddress() async {
  //   isLoading.value = true;
  //   String url = kMainUrl + addAddressUrl;
  //   ServerResponse response = ServerResponse(statusCode: 0, body: {});
  //   if (name.text.isEmpty) {
  //     Get.snackbar("Wrong Input", 'Name cannot be empty');
  //   }
  //   if (line1.text.isEmpty) {
  //     Get.snackbar("Wrong Input", 'Address cannot be empty');
  //   }
  //   if (pincode.text.isEmpty) {
  //     Get.snackbar("Wrong Input", 'Pincode cannot be empty');
  //   }
  //   if (contactNo.text.isEmpty) {
  //     Get.snackbar("Wrong Input", 'Number cannot be empty');
  //   }
  //   if (state.isEmpty) {
  //     Get.snackbar("Wrong Input", 'State cannot be empty');
  //   }
  //   if (city.text.isEmpty) {
  //     Get.snackbar("Wrong Input", 'City cannot be empty');
  //   }
  //   if (lat.isEmpty) {
  //     Get.snackbar("Wrong Input", 'Lat cannot be empty');
  //   }
  //   if (long.isEmpty) {
  //     Get.snackbar("Wrong Input", 'Long cannot be empty');
  //   } else {
  //     response = await responseHandler(url: url, body: {
  //       "name": name.text,
  //       "line1": line1.text,
  //       "landmark": landmark.text,
  //       "pincode": pincode.text,
  //       "contact_no": contactNo.text,
  //       "state": state,
  //       "city": city.text,
  //       'lat': lat.value,
  //       'long': long.value,
  //       "delivery_note": deliveryNote.text,
  //       "type": type.value,
  //     });
  //   }

  //   isLoading.value = false;
  //   return response;
  // }

  //TODO:decomment

  // Future<void> deleteAddress({required String id}) async {
  //   isLoading.value = true;
  //   String url = kMainUrl + deleteAddressUrl + id;

  //   ServerResponse response = await responseHandlerGet(
  //     url: url,
  //   );
  //   print(response.body);
  //   if (response.body["status"] == "sucess" && address.isEmpty) {
  //     Get.to(() => const AddAddress());
  //   } else if (response.body["status"] == "fail") {
  //     Get.snackbar(response.body["status"], response.body["msg"]);
  //   }
  //   isLoading.value = false;
  // }
}
