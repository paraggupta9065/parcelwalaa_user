import 'package:easy_upi_payment/easy_upi_payment.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/controller/cart_controller.dart';
import 'package:parcelwalaa_app/controller/homepage_controller.dart';
import 'package:parcelwalaa_app/controller/order_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:parcelwalaa_app/view/cart/promo.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final CartControllers cartControllers = Get.put(CartControllers());
  AddressController addressController = Get.put(AddressController());
  OrdersController ordersController = Get.put(OrdersController());
  HomepageController homepageController = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: kBackgroundColour,
        body: FutureBuilder(
          future: cartControllers.getCart(),
          builder:
              (BuildContext context, AsyncSnapshot<ServerResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return isLoading();
            }
            if (snapshot.data!.body["status"] == "fail") {
              return Center(
                child: Text(snapshot.data!.body["msg"]),
              );
            }

            Map cart = cartControllers.cart;

            List cartInventory = cart["cart_inventory"];

            List products = snapshot.data!.body['products'];

            bool isTakeawayPosible = cartControllers.isTakeawayPosible.value;

            String previousShopId = cartInventory[0]['shop_id']['_id'];

            for (var element in cartInventory) {
              if (element['shop_id']['_id'] != previousShopId) {
                isTakeawayPosible = false;
                break;
              } else if (element['shop_id']['takeaway'] == false) {
                isTakeawayPosible = false;
                break;
              }
              isTakeawayPosible = true;
            }

            Map shop = cartInventory[0]['shop_id'];

            return SingleChildScrollView(
                child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
                  child: Column(
                    children: [
                      AppBar(
                        backgroundColor: const Color(0x00FFFFFF),
                        elevation: 0,
                        centerTitle: true,
                        leading: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 1,
                          child: IconButton(
                            onPressed: () {
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
                        title: const Text(
                          "Cart",
                          style: TextStyle(color: kTextColour),
                        ),
                      ),
                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: kLinkColour,
                        child: SizedBox(
                          height: 50,
                          width: Get.size.width,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Obx(
                                    () => Checkbox(
                                      checkColor: kLinkColour,
                                      fillColor:
                                          MaterialStateProperty.resolveWith(
                                              (s) => Colors.white),
                                      value: ordersController.takeaway.value,
                                      shape: CircleBorder(),
                                      onChanged: (bool? value) {
                                        if (isTakeawayPosible) {
                                          ordersController.takeaway.value =
                                              value!;
                                        } else {
                                          ordersController.takeaway.value =
                                              false;
                                        }
                                      },
                                    ),
                                  ),
                                  const Text(
                                    "Takeaway",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Visibility(
                          visible: !isTakeawayPosible,
                          child: Row(
                            children: const [
                              SizedBox(width: 10),
                              Text(
                                "Takeaway is not possible",
                                style: TextStyle(
                                  color: kTextColour,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          )),
                      // Obx(
                      //   () => addressController.isLoading.value
                      //       ? isLoading()
                      //       : Visibility(
                      //           visible: !ordersController.takeaway.value,
                      //           child: InkWell(
                      //             onTap: () {
                      //               addressController.visible.value =
                      //                   !(addressController.visible.value);
                      //             },
                      //             child: Card(
                      //               elevation: 0,
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius:
                      //                       BorderRadius.circular(20)),
                      //               color: kLinkColour,
                      //               child: SizedBox(
                      //                 height: addressController.visible.value
                      //                     ? 430
                      //                     : 105,
                      //                 width: Get.size.width,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(20),
                      //                   child: Column(
                      //                     children: [
                      //                       Row(
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.start,
                      //                         children: [
                      //                           const Icon(
                      //                             FontAwesomeIcons.locationPin,
                      //                             color: Colors.white,
                      //                           ),
                      //                           const SizedBox(width: 10),
                      //                           Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               const Text(
                      //                                 "Deliver to",
                      //                                 style: TextStyle(
                      //                                   color: Colors.white,
                      //                                 ),
                      //                               ),
                      //                               Obx(() => addressController
                      //                                       .isLoading.value
                      //                                   ? isLoading()
                      //                                   : SizedBox(
                      //                                       width: 150,
                      //                                       child: Text(
                      //                                         "${addressController.address[addressController.selectedIndex.value]["line1"]}, ${addressController.address[addressController.selectedIndex.value]["city"]} ${addressController.address[addressController.selectedIndex.value]["pincode"]}",
                      //                                         overflow:
                      //                                             TextOverflow
                      //                                                 .ellipsis,
                      //                                         maxLines: 2,
                      //                                         style:
                      //                                             const TextStyle(
                      //                                           color: Colors
                      //                                               .white,
                      //                                           fontWeight:
                      //                                               FontWeight
                      //                                                   .bold,
                      //                                         ),
                      //                                       ),
                      //                                     )),
                      //                             ],
                      //                           ),
                      //                           const Expanded(
                      //                               child: SizedBox()),
                      //                           Column(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.center,
                      //                             children: const [
                      //                               Icon(
                      //                                 Icons
                      //                                     .keyboard_arrow_down_outlined,
                      //                                 color: Colors.white,
                      //                               )
                      //                             ],
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       Visibility(
                      //                           visible: addressController
                      //                               .visible.value,
                      //                           child:
                      //                               addressController.isLoading
                      //                                           .value ==
                      //                                       false
                      //                                   ? SizedBox(
                      //                                       height: 300,
                      //                                       child: ListView
                      //                                           .builder(
                      //                                         itemCount:
                      //                                             addressController
                      //                                                 .address
                      //                                                 .length,
                      //                                         physics:
                      //                                             ScrollPhysics(),
                      //                                         itemBuilder:
                      //                                             (BuildContext
                      //                                                     context,
                      //                                                 int index) {
                      //                                           return Padding(
                      //                                             padding: const EdgeInsets
                      //                                                     .only(
                      //                                                 left: 20,
                      //                                                 right:
                      //                                                     20),
                      //                                             child:
                      //                                                 ListTile(
                      //                                               onTap: () {
                      //                                                 addressController
                      //                                                     .selectedIndex
                      //                                                     .value = index;
                      //                                                 addressController
                      //                                                     .visible
                      //                                                     .value = false;
                      //                                               },
                      //                                               leading:
                      //                                                   Icon(
                      //                                                 addressController.address[index]["type"] ==
                      //                                                         "home"
                      //                                                     ? Icons
                      //                                                         .home
                      //                                                     : addressController.address[index]["type"] == "office"
                      //                                                         ? Icons.local_post_office
                      //                                                         : Icons.family_restroom,
                      //                                                 color: Colors
                      //                                                     .white,
                      //                                               ),
                      //                                               title: Text(
                      //                                                 addressController
                      //                                                         .address[index]
                      //                                                     [
                      //                                                     "name"],
                      //                                                 style:
                      //                                                     const TextStyle(
                      //                                                   color: Colors
                      //                                                       .white,
                      //                                                 ),
                      //                                               ),
                      //                                               subtitle:
                      //                                                   Text(
                      //                                                 addressController
                      //                                                         .address[index]
                      //                                                     [
                      //                                                     "line1"],
                      //                                                 style:
                      //                                                     const TextStyle(
                      //                                                   color: Colors
                      //                                                       .white,
                      //                                                 ),
                      //                                               ),
                      //                                               trailing: addressController
                      //                                                       .address[index]
                      //                                                   ["Tap"],
                      //                                             ),
                      //                                           );
                      //                                         },
                      //                                       ),
                      //                                     )
                      //                                   : isLoading()),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      // ),

                      // Obx(
                      //   () => addressController.isLoading.value
                      //       ? isLoading()
                      //       : Visibility(
                      //           visible: !ordersController.takeaway.value,
                      //           child: InkWell(
                      //             onTap: () {
                      //               addressController.visible.value =
                      //                   !(addressController.visible.value);
                      //             },
                      //             child: Card(
                      //               elevation: 0,
                      //               shape: RoundedRectangleBorder(
                      //                   borderRadius:
                      //                       BorderRadius.circular(20)),
                      //               color: kLinkColour,
                      //               child: SizedBox(
                      //                 height: addressController.visible.value
                      //                     ? 430
                      //                     : 105,
                      //                 width: Get.size.width,
                      //                 child: Padding(
                      //                   padding: const EdgeInsets.all(20),
                      //                   child: Column(
                      //                     children: [
                      //                       Row(
                      //                         crossAxisAlignment:
                      //                             CrossAxisAlignment.start,
                      //                         children: [
                      //                           const Icon(
                      //                             FontAwesomeIcons.locationPin,
                      //                             color: Colors.white,
                      //                           ),
                      //                           const SizedBox(width: 10),
                      //                           Column(
                      //                             crossAxisAlignment:
                      //                                 CrossAxisAlignment.start,
                      //                             children: [
                      //                               const Text(
                      //                                 "Deliver to",
                      //                                 style: TextStyle(
                      //                                   color: Colors.white,
                      //                                 ),
                      //                               ),
                      //                               Obx(() => addressController
                      //                                       .isLoading.value
                      //                                   ? isLoading()
                      //                                   : SizedBox(
                      //                                       width: 150,
                      //                                       child: Text(
                      //                                         "${addressController.address[addressController.selectedIndex.value]["line1"]}, ${addressController.address[addressController.selectedIndex.value]["city"]} ${addressController.address[addressController.selectedIndex.value]["pincode"]}",
                      //                                         overflow:
                      //                                             TextOverflow
                      //                                                 .ellipsis,
                      //                                         maxLines: 2,
                      //                                         style:
                      //                                             const TextStyle(
                      //                                           color: Colors
                      //                                               .white,
                      //                                           fontWeight:
                      //                                               FontWeight
                      //                                                   .bold,
                      //                                         ),
                      //                                       ),
                      //                                     )),
                      //                             ],
                      //                           ),
                      //                           const Expanded(
                      //                               child: SizedBox()),
                      //                           Column(
                      //                             mainAxisAlignment:
                      //                                 MainAxisAlignment.center,
                      //                             children: const [
                      //                               Icon(
                      //                                 Icons
                      //                                     .keyboard_arrow_down_outlined,
                      //                                 color: Colors.white,
                      //                               )
                      //                             ],
                      //                           ),
                      //                         ],
                      //                       ),
                      //                       Visibility(
                      //                           visible: addressController
                      //                               .visible.value,
                      //                           child:
                      //                               addressController.isLoading
                      //                                           .value ==
                      //                                       false
                      //                                   ? SizedBox(
                      //                                       height: 300,
                      //                                       child: ListView
                      //                                           .builder(
                      //                                         itemCount:
                      //                                             addressController
                      //                                                 .address
                      //                                                 .length,
                      //                                         physics:
                      //                                             ScrollPhysics(),
                      //                                         itemBuilder:
                      //                                             (BuildContext
                      //                                                     context,
                      //                                                 int index) {
                      //                                           return Padding(
                      //                                             padding: const EdgeInsets
                      //                                                     .only(
                      //                                                 left: 20,
                      //                                                 right:
                      //                                                     20),
                      //                                             child:
                      //                                                 ListTile(
                      //                                               onTap: () {
                      //                                                 addressController
                      //                                                     .selectedIndex
                      //                                                     .value = index;
                      //                                                 addressController
                      //                                                     .visible
                      //                                                     .value = false;
                      //                                               },
                      //                                               leading:
                      //                                                   Icon(
                      //                                                 addressController.address[index]["type"] ==
                      //                                                         "home"
                      //                                                     ? Icons
                      //                                                         .home
                      //                                                     : addressController.address[index]["type"] == "office"
                      //                                                         ? Icons.local_post_office
                      //                                                         : Icons.family_restroom,
                      //                                                 color: Colors
                      //                                                     .white,
                      //                                               ),
                      //                                               title: Text(
                      //                                                 addressController
                      //                                                         .address[index]
                      //                                                     [
                      //                                                     "name"],
                      //                                                 style:
                      //                                                     const TextStyle(
                      //                                                   color: Colors
                      //                                                       .white,
                      //                                                 ),
                      //                                               ),
                      //                                               subtitle:
                      //                                                   Text(
                      //                                                 addressController
                      //                                                         .address[index]
                      //                                                     [
                      //                                                     "line1"],
                      //                                                 style:
                      //                                                     const TextStyle(
                      //                                                   color: Colors
                      //                                                       .white,
                      //                                                 ),
                      //                                               ),
                      //                                               trailing: addressController
                      //                                                       .address[index]
                      //                                                   ["Tap"],
                      //                                             ),
                      //                                           );
                      //                                         },
                      //                                       ),
                      //                                     )
                      //                                   : isLoading()),
                      //                     ],
                      //                   ),
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      // ),

                      Card(
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        color: kLinkColour,
                        child: SizedBox(
                          height: 50,
                          width: Get.size.width,
                          child: Visibility(
                            visible: !isTakeawayPosible,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20, right: 30),
                              child: Obx(
                                () => DropdownButton<int>(
                                  isExpanded: true,
                                  iconEnabledColor: Colors.white,
                                  iconDisabledColor: Colors.white,
                                  underline: const SizedBox(),
                                  borderRadius: BorderRadius.circular(20),
                                  dropdownColor: kLinkColour,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  value: cartControllers.delivery.value,
                                  items: <int>[1, 2, 3, 4].map((int value) {
                                    return DropdownMenuItem<int>(
                                      value: value,
                                      child: Text("Kanopy ${value.toString()}"),
                                    );
                                  }).toList(),
                                  onChanged: (_) async {
                                    cartControllers.delivery.value = _!;
                                    cartControllers.updatePoint();
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),

                      Obx(
                        () => Visibility(
                          visible: ordersController.takeaway.value,
                          child: InkWell(
                            onTap: () {
                              addressController.visible.value =
                                  !(addressController.visible.value);
                            },
                            child: Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              color: kLinkColour,
                              child: SizedBox(
                                height: 110,
                                width: Get.size.width,
                                child: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const Icon(
                                            FontAwesomeIcons.locationPin,
                                            color: Colors.white,
                                          ),
                                          const SizedBox(width: 10),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              const Text(
                                                "Pickup from",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                              Obx(() => addressController
                                                      .isLoading.value
                                                  ? isLoading()
                                                  : SizedBox(
                                                      width: 150,
                                                      height: 40,
                                                      child: Text(
                                                        "${shop["store_name"]}, ${shop["address_line1"]}, ${shop["city"]} ${shop["pincode"]}",
                                                        style: const TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                    )),
                                            ],
                                          ),
                                          const Expanded(child: SizedBox()),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            child: Card(
                              elevation: 0.5,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              color: Colors.white,
                              child: SizedBox(
                                height: 100,
                                child: Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          child: Image.network(
                                            products[index]["images"],
                                            fit: BoxFit.cover,
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return const Center(
                                                child: Text("image not found"),
                                              );
                                            },
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(left: 10),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: SizedBox(
                                                  width: 200,
                                                  child: Text(
                                                    products[index]["name"],
                                                    maxLines: 2,
                                                    overflow: TextOverflow.clip,
                                                  ),
                                                ),
                                              ),
                                              Card(
                                                color: kBackgroundColour,
                                                elevation: 0.5,
                                                shape:
                                                    const RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                    Radius.circular(10),
                                                  ),
                                                ),
                                                child: SizedBox(
                                                  height: 30,
                                                  width: 70,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      InkWell(
                                                        onTap: () async {
                                                          await cartControllers
                                                              .updateQty(
                                                            productId: cartInventory[
                                                                            index]
                                                                        [
                                                                        "product"]
                                                                    ['_id']
                                                                .toString(),
                                                            qty: (cartInventory[
                                                                            index]
                                                                        [
                                                                        "quantity"] -
                                                                    1)
                                                                .toString(),
                                                          );
                                                          setState(() {});
                                                        },
                                                        child: const Icon(
                                                          Icons.remove,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                      Text(
                                                        cartInventory[index]
                                                                ["quantity"]
                                                            .toString(),
                                                      ),
                                                      InkWell(
                                                        onTap: () async {
                                                          await cartControllers
                                                              .updateQty(
                                                            productId: cartInventory[
                                                                            index]
                                                                        [
                                                                        "product"]
                                                                    ['_id']
                                                                .toString(),
                                                            qty: (cartInventory[
                                                                            index]
                                                                        [
                                                                        "quantity"] +
                                                                    1)
                                                                .toString(),
                                                          );

                                                          setState(() {});
                                                        },
                                                        child: const Icon(
                                                          Icons.add,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                              ),
                            ),
                          );
                        },
                      ),
                      InkWell(
                        onTap: () => Get.to(() => PromoCode()),
                        child: Card(
                          elevation: 0.5,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          color: Colors.white,
                          child: SizedBox(
                            height: 60,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: [
                                  const SizedBox(width: 20),
                                  Obx(
                                    () => Text(
                                      cartControllers.cart["coupon_code_id"] ==
                                              'na'
                                          ? "PROMO CODE"
                                          : cartControllers
                                              .cart["coupon_code_id"],
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  const Icon(
                                    Icons.add,
                                    color: Colors.grey,
                                  ),
                                  const SizedBox(width: 20),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Stack(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        Container(
                          width: 100,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: kPrimaryColour,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        Container(
                          width: Get.size.width,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: kBackgroundColour,
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: Get.size.width,
                  height: 300,
                  decoration: const BoxDecoration(
                    color: kPrimaryColour,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(50),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 50,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Item total",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "₹ ${cart["inventory_total_amt"]}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Delivery Charges",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "₹ ${cart["delivery_total_amt"]}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Discount",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "₹ ${cart["discount_amt"]}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Tax",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "₹ ${cart["total_gst"].toString()}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Total",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                            ),
                            Obx(
                              () => Text(
                                "₹ ${cart["net_amt"]}",
                                style: const TextStyle(
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        InkWell(
                          onTap: () async {
                            {
                              await ordersController.sucessPayment();
                              // try {
                              //   final res = await EasyUpiPaymentPlatform
                              //       .instance
                              //       .startPayment(
                              //     const EasyUpiPaymentModel(
                              //       payeeVpa: '8319905007@upi',
                              //       payeeName: 'Bingrr',
                              //       amount: 10.00,
                              //       description: 'orderid',
                              //     ),
                              //   );

                              //   // print(res);
                              // } catch (e) {
                              //   Get.snackbar('payment', 'payment failed');
                              // }
                            }
                          },
                          child: Card(
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                            ),
                            color: Colors.white,
                            child: SizedBox(
                              height: 60,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Obx(
                                  () => ordersController.isLoading.value
                                      ? isLoading()
                                      : const Center(
                                          child: Text(
                                            "Continue",
                                            style: TextStyle(
                                                color: kTextColour,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20),
                                          ),
                                        ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
