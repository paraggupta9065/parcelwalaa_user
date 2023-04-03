import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parcelwalaa_app/controller/auth_controller.dart';
import 'package:parcelwalaa_app/controller/homepage_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/utils/responseHandler.dart';
import 'package:parcelwalaa_app/utils/url.dart';
import 'package:parcelwalaa_app/view/homepage/homepage.dart';
import 'package:parcelwalaa_app/view/homepage/orders.dart';

class OrdersController extends GetxController {
  RxBool isLoading = false.obs;
  RxString status = ''.obs;
  RxMap driver = {}.obs;
  RxMap order = {}.obs;
  RxBool takeaway = false.obs;
  RxList markers = [].obs;
  LatLng? sourceLocation;
  LatLng? destination;
  LatLng? driveL;

  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;

  Future getMarkers() async {
    // Map userAddress = order['delivery_address_id'];

    sourceLocation = LatLng(
        double.parse(order['order_inventory'][0]['shop_id']['lat']),
        double.parse(order['order_inventory'][0]['shop_id']['long']));

    print(sourceLocation);
    // destination = LatLng(
    //     double.parse(userAddress['lat']), double.parse(userAddress['long']));

    destination = const LatLng(22.6210224, 75.8035907);
    if (driver.keys.isNotEmpty) {
      driveL = const LatLng(23.9266282, 76.9105017);
    }

    markers.value = List.generate(
      order['order_inventory'].length,
      (int index) {
        // if (index == order['order_inventory'].length) {
        //   return Marker(
        //     markerId: const MarkerId("destination"),
        //     position: destination!,
        //   );
        // }
        String lat = order['order_inventory'][index]['shop_id']['lat'];
        String long = order['order_inventory'][index]['shop_id']['long'];
        return Marker(
          markerId: MarkerId("source${index}"),
          position: LatLng(double.parse(lat), double.parse(long)),
        );
      },
    );
    markers.add(Marker(
      markerId: const MarkerId("destination"),
      position: destination!,
    ));
    if (driver.keys.isNotEmpty) {
      markers.add(Marker(
        markerId: const MarkerId("driver"),
        position: driveL!,
      ));
    }

    await BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "asset/home.png")
        .then(
      (icon) {
        destinationIcon = icon;
      },
    );

    getPolyPoints();
  }

  RxBool change = false.obs;

  RxList polylineCoordinates = [].obs;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();
    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      "AIzaSyDnhOGFu0_fSkH1mrU7yLtxDiENQFUEMl0", // Your Google Map Key
      PointLatLng(sourceLocation!.latitude, sourceLocation!.longitude),
      PointLatLng(destination!.latitude, destination!.longitude),
    );
    if (result.points.isNotEmpty) {
      result.points.forEach(
        (PointLatLng point) => polylineCoordinates.add(
          LatLng(point.latitude, point.longitude),
        ),
      );
    }
    change.value = !change.value;
  }

  HomepageController homepageController = Get.put(HomepageController());

  Future<ServerResponse> initPayment() async {
    String url = kMainUrl + getCartUrl;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    return response;
  }

  Future sucessPayment() async {
    isLoading.value = true;
    String url = kMainUrl + sucessPaymentUrl;

    ServerResponse response = await responseHandler(
      body: {
        "order_note": "no note",
        "transaction_id": "0",
        "amount_paid": "0",
        "payment_method_id": "0",
        "order_type": takeaway.value ? "takeaway" : "delivery",
      },
      url: url,
    );
    if (response.body["status"] == "sucess") {
      order.value = response.body['order'];
      status.value = response.body['order']["status"];
      // print(order.value);
      getMarkers();

      Get.offAll(() => const Order());
      // Get.dialog(
      //   MaterialApp(
      //     home: Padding(
      //       padding: const EdgeInsets.only(
      //         left: 50,
      //         right: 50,
      //         top: 100,
      //         bottom: 150,
      //       ),
      //       child: Card(
      //         shape: RoundedRectangleBorder(
      //           borderRadius: BorderRadius.circular(30),
      //         ),
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.center,
      //           children: [
      //             const SizedBox(height: 20),
      //             const Icon(
      //               FontAwesomeIcons.checkCircle,
      //               color: kPrimaryColour,
      //               size: 200,
      //             ),
      //             const SizedBox(height: 10),
      //             const Center(
      //               child: Text(
      //                 "Order Placed Succesfully",
      //                 textAlign: TextAlign.center,
      //                 style: TextStyle(
      //                   fontSize: 30,
      //                   color: kPrimaryColour,
      //                   fontWeight: FontWeight.w400,
      //                 ),
      //               ),
      //             ),
      //             Padding(
      //                 padding: const EdgeInsets.all(10),
      //                 child: InkWell(
      //                   onTap: () {},
      //                   child: const Card(
      //                     elevation: 5,
      //                     shape: RoundedRectangleBorder(
      //                       borderRadius: BorderRadius.all(
      //                         Radius.circular(20),
      //                       ),
      //                     ),
      //                     color: kPrimaryColour,
      //                     child: SizedBox(
      //                       height: 60,
      //                       child: Padding(
      //                         padding: EdgeInsets.all(5),
      //                         child: Center(
      //                           child: Text(
      //                             "View Order",
      //                             style: TextStyle(
      //                                 color: Colors.white,
      //                                 fontWeight: FontWeight.bold,
      //                                 fontSize: 20),
      //                           ),
      //                         ),
      //                       ),
      //                     ),
      //                   ),
      //                 )),
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // );
    } else if (response.body["status"] == "fail") {
      Get.snackbar(response.body["status"], response.body["msg"]);
    }
    isLoading.value = false;
  }

  AuthController authController = Get.put(AuthController());

  Future<ServerResponse> getOrder() async {
    String url = kMainUrl + getOrderUrl;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );
    if (response.body["status"] == "sucess") {
      order.value = response.body["order"];
      status = order.value['status'];
    }

    return response;
  }

  Future<ServerResponse> getPreviousOrders() async {
    String url = kMainUrl + getPreviousOrdersUrl;

    ServerResponse response = await responseHandlerGet(
      url: url,
    );

    return response;
  }
}
