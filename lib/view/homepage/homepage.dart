import 'package:app_links/app_links.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/controller/cart_controller.dart';
import 'package:parcelwalaa_app/controller/homepage_controller.dart';
import 'package:parcelwalaa_app/controller/order_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:parcelwalaa_app/view/address/add_address.dart';
import 'package:parcelwalaa_app/view/homepage/account.dart';
import 'package:parcelwalaa_app/view/homepage/mainHome.dart';
import 'package:parcelwalaa_app/view/homepage/order_cart.dart';
import 'package:parcelwalaa_app/view/homepage/students.dart';

class Homepage extends StatefulWidget {
  const Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  HomepageController homepageController = Get.put((HomepageController()));
  final addressController = Get.put(AddressController());
  final cartControllers = Get.put(CartControllers());
  final ordersController = Get.put(OrdersController());
  final _appLinks = AppLinks();

// Subscribe to all events when app is started.
// (Use allStringLinkStream to get it as [String])

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   _appLinks.allUriLinkStream.listen((uri) {
  //     // Do something (navigation, ...)
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    cartControllers.getCart();
    Map cart = cartControllers.cart;

    return Scaffold(
      body: FutureBuilder(
        future: addressController.getAddress(),
        builder:
            (BuildContext context, AsyncSnapshot<ServerResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return isLoading();
          }

          //  else if (snapshot.data!.statusCode == 0) {
          //   return const AddAddress();
          // } else if (snapshot.data!.body["status"] == "sucess" &&
          //     addressController.address.isEmpty) {
          //   return const AddAddress();
          // }

          return Scaffold(
            backgroundColor: kBackgroundColour,
            bottomNavigationBar: Obx(
              () => Container(
                  height: cart.keys.isEmpty ||
                          homepageController.index.value == 2 ||
                          homepageController.index.value == 3
                      ? 70
                      : 120,
                  color: Colors.white,
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          homepageController.index.value = 2;
                          homepageController.controller.jumpToPage(
                            2,
                          );
                        },
                        child: Container(
                          height: cart.keys.isEmpty ||
                                  homepageController.index.value == 2 ||
                                  homepageController.index.value == 3
                              ? 0
                              : 50,
                          color: kLinkColour,
                          child: Row(
                            children: [
                              const SizedBox(
                                width: 30,
                              ),
                              Obx(
                                () => Text(
                                  cart['cart_inventory'] != null
                                      ? cart['cart_inventory'].length.toString()
                                      : "",
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 2,
                              ),
                              const Padding(
                                padding: EdgeInsets.only(top: 5),
                                child: Text(
                                  "item",
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                              const Expanded(child: SizedBox()),
                              const Text(
                                "View Cart",
                                style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Container(
                                height: 40,
                                width: 70,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Center(
                                  child: Obx(
                                    () => Text(
                                      "₹ ${cart['net_amt'].toString()}",
                                      style: const TextStyle(
                                        fontSize: 17,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                            ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: Obx(
                          () => Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              homepageController.index.value == 0
                                  ? Card(
                                      color: kPrimaryColour,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          homepageController.index.value = 0;
                                          homepageController.controller
                                              .jumpToPage(
                                            0,
                                          );
                                        },
                                        color: Colors.white,
                                        icon: const Icon(
                                          FontAwesomeIcons.house,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        homepageController.index.value = 0;
                                        homepageController.controller
                                            .jumpToPage(
                                          0,
                                        );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.house,
                                      ),
                                    ),
                              homepageController.index.value == 1
                                  ? Card(
                                      color: kPrimaryColour,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          homepageController.index.value = 1;
                                          homepageController.controller
                                              .jumpToPage(
                                            1,
                                          );
                                        },
                                        color: Colors.white,
                                        icon: const Icon(
                                          FontAwesomeIcons.basketShopping,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        homepageController.index.value = 1;
                                        homepageController.controller
                                            .jumpToPage(
                                          1,
                                        );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.basketShopping,
                                      ),
                                    ),
                              homepageController.index.value == 2
                                  ? Card(
                                      color: kPrimaryColour,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          homepageController.index.value = 2;
                                          homepageController.controller
                                              .jumpToPage(
                                            2,
                                          );
                                        },
                                        color: Colors.white,
                                        icon: const Icon(
                                          FontAwesomeIcons.bagShopping,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        homepageController.index.value = 2;
                                        homepageController.controller
                                            .jumpToPage(
                                          2,
                                        );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.bagShopping,
                                      ),
                                    ),
                              homepageController.index.value == 3
                                  ? Card(
                                      color: kPrimaryColour,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      elevation: 10,
                                      child: IconButton(
                                        onPressed: () {
                                          homepageController.index.value = 3;
                                          homepageController.controller
                                              .jumpToPage(
                                            3,
                                          );
                                        },
                                        color: Colors.white,
                                        icon: const Icon(
                                          FontAwesomeIcons.userNinja,
                                        ),
                                      ),
                                    )
                                  : IconButton(
                                      onPressed: () {
                                        homepageController.index.value = 3;
                                        homepageController.controller
                                            .jumpToPage(
                                          3,
                                        );
                                      },
                                      icon: const Icon(
                                        FontAwesomeIcons.userNinja,
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
            body: PageView(
              controller: homepageController.controller,
              onPageChanged: (index) {
                homepageController.index.value = index;
              },
              children: const [
                MainHome(),
                Students(),
                OrderCart(),
                Account(),
              ],
            ),
          );
        },
      ),
    );
  }
}
