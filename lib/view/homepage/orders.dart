import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:parcelwalaa_app/controller/homepage_controller.dart';
import 'package:parcelwalaa_app/controller/order_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:parcelwalaa_app/view/homepage/homepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class Order extends StatefulWidget {
  const Order({Key? key}) : super(key: key);

  @override
  State<Order> createState() => _OrderState();
}

class _OrderState extends State<Order> {
  final Completer<GoogleMapController> _controller = Completer();
  OrdersController ordersController = Get.put(OrdersController());
  HomepageController homepageController = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    List markers = ordersController.markers.value;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 300),
            child: Obx(
              () => GoogleMap(
                polylines: {
                  Polyline(
                    polylineId: const PolylineId("route"),
                    points: List<LatLng>.generate(
                        ordersController.polylineCoordinates.length,
                        (index) => ordersController.polylineCoordinates[index]),
                    color: const Color(0xFF7B61FF),
                    width: 6,
                  ),
                },
                initialCameraPosition: CameraPosition(
                  target: ordersController.sourceLocation!,
                  zoom: 14.5,
                ),
                mapType: MapType.terrain,
                zoomControlsEnabled: false,
                onMapCreated: (GoogleMapController controller) {
                  ordersController.change;
                  _controller.complete(controller);
                },
                markers: List<Marker>.generate(
                    markers.length, (index) => markers[index]).toSet(),
              ),
            ),
          ),
          Column(
            children: [
              const SizedBox(height: 10),
              Row(
                children: [
                  const SizedBox(width: 10),
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    elevation: 1,
                    child: IconButton(
                      onPressed: () {
                        Get.offAll(() => const Homepage());
                        homepageController.index.value = 0;
                        homepageController.controller.animateToPage(
                          0,
                          duration: const Duration(seconds: 1),
                          curve: Curves.ease,
                        );
                      },
                      color: Colors.black,
                      icon: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                      ),
                    ),
                  ),
                ],
              ),
              const Expanded(child: SizedBox()),
              Container(
                decoration: const BoxDecoration(
                  color: kPrimaryColour,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                ),
                child: SizedBox(
                  height: 350,
                  width: Get.size.width,
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 50,
                          ),
                          Text("Delivery time"),
                        ],
                      ),
                      Row(
                        children: const [
                          SizedBox(
                            width: 50,
                          ),
                          Icon(
                            FontAwesomeIcons.clock,
                            size: 17,
                          ),
                          SizedBox(width: 5),
                          Text(
                            "20 Min",
                            style: TextStyle(
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                      SingleChildScrollView(
                        child: Obx(
                          () => Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: ListTile(
                                  leading: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(15)),
                                    child: Card(
                                      color: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 1,
                                      child: const SizedBox(
                                        height: 40,
                                        width: 40,
                                        child: Icon(
                                          Icons.person,
                                          color: kPrimaryColour,
                                        ),
                                      ),
                                    ),
                                  ),
                                  title: const Text(
                                    "Bingrr",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "Support person",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 1,
                                    child: IconButton(
                                      onPressed: () {
                                        launchUrlString(
                                            "whatsapp://send?phone=+918109437851" +
                                                "&text= ");
                                      },
                                      color: Colors.white,
                                      icon: const Icon(
                                        FontAwesomeIcons.phone,
                                        color: kPrimaryColour,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: ListTile(
                                  leading: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    elevation: 1,
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        ordersController.status.value ==
                                                    "accepted" ||
                                                ordersController.status.value ==
                                                    "prepared" ||
                                                ordersController.status.value ==
                                                    "assigned"
                                            ? FontAwesomeIcons.check
                                            : FontAwesomeIcons.xmark,
                                        color: kPrimaryColour,
                                      ),
                                    ),
                                  ),
                                  title: const Text(
                                    "Order confirmed",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "Your order has been Confirmed",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: ListTile(
                                  leading: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    elevation: 1,
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        ordersController.status.value ==
                                                    "prepared" ||
                                                ordersController.status.value ==
                                                    "assigned"
                                            ? FontAwesomeIcons.check
                                            : FontAwesomeIcons.xmark,
                                        color: kPrimaryColour,
                                      ),
                                    ),
                                  ),
                                  title: const Text(
                                    "Order prepared",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "Your order has been prepared",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 30),
                                child: ListTile(
                                  leading: Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    elevation: 1,
                                    child: SizedBox(
                                      height: 30,
                                      width: 30,
                                      child: Icon(
                                        ordersController.status.value ==
                                                "assigned"
                                            ? FontAwesomeIcons.check
                                            : FontAwesomeIcons.xmark,
                                        color: kPrimaryColour,
                                      ),
                                    ),
                                  ),
                                  title: const Text(
                                    "Delivery in progress",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w800,
                                      fontSize: 15,
                                    ),
                                  ),
                                  subtitle: const Text(
                                    "Hang on! Your food is on the way ",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
