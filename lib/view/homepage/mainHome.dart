import 'package:auto_size_text/auto_size_text.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/controller/banner_controller.dart';
import 'package:parcelwalaa_app/controller/cart_controller.dart';
import 'package:parcelwalaa_app/controller/homepage_controller.dart';
import 'package:parcelwalaa_app/controller/notification_controller.dart';
import 'package:parcelwalaa_app/controller/product_controller.dart';
import 'package:parcelwalaa_app/controller/shop_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:parcelwalaa_app/view/address/add_address.dart';
import 'package:parcelwalaa_app/view/product/category_page.dart';
import 'package:parcelwalaa_app/view/shop/shop_page.dart';

class MainHome extends StatefulWidget {
  const MainHome({Key? key}) : super(key: key);

  @override
  State<MainHome> createState() => _MainHomeState();
}

class _MainHomeState extends State<MainHome> {
  HomepageController homepageController = Get.put(HomepageController());
  ShopController shopController = Get.put(ShopController());
  AddressController addressController = Get.put(AddressController());
  BannerController bannerController = Get.put(BannerController());
  ProductController productController = Get.put(ProductController());
  NotificationController notificationController =
      Get.put(NotificationController());
  PageController pageController = PageController();
  final CartControllers cartControllers = Get.put(CartControllers());

  @override
  Widget build(BuildContext context) {
    notificationController.socketConnect();
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomRight: Radius.circular(50),
                    ),
                    child: Stack(
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: (Get.size.height - 70) * .25,
                              width: Get.size.width,
                              child: Image.asset(
                                "asset/doodle.jpeg",
                                fit: BoxFit.fitWidth,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              color: kPrimaryColour.withOpacity(0.8),
                              height: (Get.size.height - 70) * .25,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: Get.size.height * .20,
                            width: Get.size.width,
                            child: Image.asset(
                              "asset/doodle.jpeg",
                              fit: BoxFit.fitWidth,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            color: kPrimaryColour.withOpacity(0.8),
                            height: Get.size.height * .20,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(height: Get.size.height * .224),
                  Container(
                    height: (Get.size.height - 70) * .6295,
                    // height: (Get.size.height - 70) * .7108,
                    decoration: const BoxDecoration(
                      color: kBackgroundColour,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  SizedBox(
                      height: Get.size.height * 0.20,
                      child: InkWell(
                        onTap: () {
                          productController.products.value = [];
                          Get.dialog(
                            Padding(
                              padding: EdgeInsets.symmetric(
                                vertical: 100,
                                horizontal: 50,
                              ),
                              child: Card(
                                  color: kPrimaryColour,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(15),
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 0,
                                            ),
                                            child: TextFormField(
                                              onChanged: (value) {
                                                if (value.length > 3) {
                                                  productController
                                                      .getSearchProducts(
                                                          key: value);
                                                }
                                              },
                                              keyboardType:
                                                  TextInputType.number,
                                              cursorColor: kTextColour,
                                              decoration: const InputDecoration(
                                                hintText: "Find Your Taste",
                                                prefixIcon: Icon(
                                                  FontAwesomeIcons
                                                      .magnifyingGlass,
                                                  color: Colors.black,
                                                ),
                                                border: InputBorder.none,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: EdgeInsets.all(5),
                                        child: Container(
                                            height: 380,
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(15),
                                              ),
                                            ),
                                            child: Obx(
                                              () => ListView.builder(
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                                itemCount: productController
                                                    .products.length,
                                                itemBuilder: (context, index) {
                                                  Map product =
                                                      productController
                                                          .products[index];
                                                  return InkWell(
                                                    child: Card(
                                                      elevation: 0.5,
                                                      shape:
                                                          const RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                          Radius.circular(20),
                                                        ),
                                                      ),
                                                      child: SizedBox(
                                                        height: 55,
                                                        child: Row(
                                                          children: [
                                                            ClipRRect(
                                                              borderRadius:
                                                                  const BorderRadius
                                                                      .only(
                                                                bottomRight:
                                                                    Radius
                                                                        .circular(
                                                                            20),
                                                                bottomLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topLeft: Radius
                                                                    .circular(
                                                                        20),
                                                                topRight: Radius
                                                                    .circular(
                                                                        20),
                                                              ),
                                                              child:
                                                                  Image.network(
                                                                productController
                                                                            .products[
                                                                        index]
                                                                    ['images'],
                                                                fit: BoxFit
                                                                    .cover,
                                                                height: 55,
                                                                width: 55,
                                                                errorBuilder:
                                                                    (context,
                                                                        error,
                                                                        stackTrace) {
                                                                  return const Center(
                                                                    child: Text(
                                                                      "image not found",
                                                                    ),
                                                                  );
                                                                },
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      top: 10,
                                                                      bottom:
                                                                          10,
                                                                      left: 10),
                                                              child: SizedBox(
                                                                  width: 150,
                                                                  child: Column(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .start,
                                                                    crossAxisAlignment:
                                                                        CrossAxisAlignment
                                                                            .start,
                                                                    children: [
                                                                      Text(
                                                                        productController.products[index]
                                                                            [
                                                                            'name'],
                                                                        style: const TextStyle(
                                                                            fontSize:
                                                                                10,
                                                                            color:
                                                                                Colors.black),
                                                                        maxLines:
                                                                            1,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                      Text(
                                                                        "Price. ${productController.products[index]['price'].toString()}",
                                                                        style:
                                                                            const TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color:
                                                                              Colors.black,
                                                                        ),
                                                                        maxLines:
                                                                            2,
                                                                        overflow:
                                                                            TextOverflow.ellipsis,
                                                                      ),
                                                                    ],
                                                                  )),
                                                            ),
                                                            Expanded(
                                                              child: Center(
                                                                child: isInCart(
                                                                        id: productController.products[index]
                                                                            [
                                                                            '_id'])
                                                                    ? TextButton(
                                                                        onPressed:
                                                                            () {
                                                                          homepageController
                                                                              .index
                                                                              .value = 2;

                                                                          homepageController
                                                                              .controller
                                                                              .jumpToPage(2);
                                                                          // Get.offAll(() => const Homepage());
                                                                          Get.back();
                                                                        },
                                                                        child:
                                                                            const Text(
                                                                          "Go\nTo\nCart",
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                kTextColour,
                                                                            fontSize:
                                                                                12,
                                                                          ),
                                                                        ),
                                                                      )
                                                                    : IconButton(
                                                                        onPressed:
                                                                            () async {
                                                                          await cartControllers
                                                                              .addToCart(
                                                                            productId:
                                                                                productController.products[index]['_id'],
                                                                          );
                                                                          await cartControllers
                                                                              .getCart();
                                                                        },
                                                                        icon:
                                                                            Icon(
                                                                          Icons
                                                                              .add,
                                                                          color:
                                                                              Colors.grey[400],
                                                                        ),
                                                                      ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    // onTap: () {
                                                    //   Get.to(() => ProductPage(
                                                    //       id: productController
                                                    //           .products[index]['_id']));
                                                    // },
                                                  );
                                                },
                                              ),
                                            )),
                                      ),
                                    ],
                                  )),
                            ),
                          );
                        },
                        child: Center(
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            elevation: 0.1,
                            shadowColor: Colors.white,
                            color: Colors.white,
                            child: SizedBox(
                              height: 50,
                              width: Get.size.width - 60,
                              child: Row(
                                children: const [
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(
                                    FontAwesomeIcons.magnifyingGlass,
                                    size: 20,
                                    color: Colors.black,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Find your taste",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 17,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),

                  const SizedBox(
                    height: 40,
                  ),
                  //bottom screen
                  SingleChildScrollView(
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.only(topLeft: Radius.circular(50)),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const ScrollPhysics(),
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Address
                          // Obx(
                          //   () => addressController.isLoading.value
                          //       ? isLoading()
                          //       : InkWell(
                          //           onTap: () => {
                          //             addressController.visible.value =
                          //                 !(addressController.visible.value)
                          //           },
                          //           child: Row(
                          //             children: [
                          //               const SizedBox(
                          //                 width: 30,
                          //               ),
                          //               const Icon(
                          //                 FontAwesomeIcons.locationPin,
                          //               ),
                          //               const SizedBox(
                          //                 width: 10,
                          //               ),
                          //               Column(
                          //                 crossAxisAlignment:
                          //                     CrossAxisAlignment.start,
                          //                 children: [
                          //                   Text(
                          //                     addressController.address[
                          //                         addressController
                          //                             .selectedIndex
                          //                             .value]["type"],
                          //                     style: const TextStyle(
                          //                         fontWeight: FontWeight.bold),
                          //                   ),
                          //                   SizedBox(
                          //                     width: Get.size.width - 110,
                          //                     child: Text(
                          //                       "${addressController.address[addressController.selectedIndex.value]["line1"]}, ${addressController.address[addressController.selectedIndex.value]["city"]} ${addressController.address[addressController.selectedIndex.value]["pincode"]}",
                          //                     ),
                          //                   ),
                          //                 ],
                          //               ),
                          //               const Expanded(child: SizedBox()),
                          //               const Icon(Icons.arrow_drop_down)
                          //             ],
                          //           ),
                          //         ),
                          // ),
                          // SizedBox(
                          //   width: Get.size.width,
                          //   child: Obx(
                          //     () => Visibility(
                          //       visible: addressController.visible.value,
                          //       child: addressController.isLoading.value ==
                          //               false
                          //           ? ListView.builder(
                          //               itemCount:
                          //                   addressController.address.length +
                          //                       1,
                          //               physics: const ScrollPhysics(),
                          //               shrinkWrap: true,
                          //               itemBuilder:
                          //                   (BuildContext context, int index) {
                          //                 if (index ==
                          //                     addressController
                          //                         .address.length) {
                          //                   return Padding(
                          //                     padding: const EdgeInsets.only(
                          //                         left: 20, right: 20),
                          //                     child: ListTile(
                          //                       onTap: () {
                          //                         Get.to(
                          //                             () => const AddAddress());
                          //                       },
                          //                       title:
                          //                           const Text("Add Address"),
                          //                     ),
                          //                   );
                          //                 }
                          //                 return Padding(
                          //                   padding: const EdgeInsets.only(
                          //                       left: 20, right: 20),
                          //                   child: ListTile(
                          //                     onTap: () {
                          //                       setState(() {
                          //                         addressController
                          //                             .selectedIndex
                          //                             .value = index;
                          //                         addressController
                          //                             .visible.value = false;
                          //                       });
                          //                     },
                          //                     leading: Icon(
                          //                       addressController.address[index]
                          //                                   ["type"] ==
                          //                               "home"
                          //                           ? Icons.home
                          //                           : addressController.address[
                          //                                           index]
                          //                                       ["type"] ==
                          //                                   "office"
                          //                               ? Icons
                          //                                   .local_post_office
                          //                               : Icons.family_restroom,
                          //                       color: Colors.black,
                          //                     ),
                          //                     title: Text(addressController
                          //                         .address[index]["name"]),
                          //                     subtitle: Text(addressController
                          //                         .address[index]["line1"]),
                          //                     trailing: addressController
                          //                         .address[index]["Tap"],
                          //                   ),
                          //                 );
                          //               },
                          //             )
                          //           : isLoading(),
                          //     ),
                          //   ),
                          // ),
                          //Address
                          const SizedBox(height: 10),
                          //food/grocery
                          FutureBuilder(
                            future: bannerController.getBanner(),
                            builder: (BuildContext context,
                                AsyncSnapshot<ServerResponse> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return isLoading();
                              }

                              if (snapshot.data!.body["status"] == 'fail') {
                                return Text(snapshot.data!.body["status"]);
                              }
                              List banner = snapshot.data!.body["banners"];

                              return CarouselSlider(
                                options: CarouselOptions(
                                    height: 170.0,
                                    autoPlay: true,
                                    autoPlayInterval:
                                        const Duration(seconds: 3)),
                                items: banner.map((i) {
                                  return Builder(
                                    builder: (BuildContext context) {
                                      return SizedBox(
                                        height: 170,
                                        width: Get.size.width - 40,
                                        child: Card(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15),
                                          ),
                                          elevation: 0.1,
                                          child: Center(
                                            child: SizedBox(
                                              height: 170,
                                              width: Get.size.width - 40,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  i["image"].toString(),
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Center(
                                                      child: Text(
                                                          "image not found"),
                                                    );
                                                  },
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                }).toList(),
                              );
                            },
                          ),
                          //food/grocery
                          const SizedBox(
                            height: 10,
                          ),
                          //category
                          FutureBuilder(
                            future: homepageController.getCategory(),
                            builder: (BuildContext context,
                                AsyncSnapshot<ServerResponse> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return isLoading();
                              }
                              List categories =
                                  snapshot.data!.body["categories"];

                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: GridView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 4,
                                    childAspectRatio: 0.8,
                                    crossAxisSpacing: 1,
                                  ),
                                  itemCount: categories.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      child: Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(5),
                                            child: SizedBox(
                                              height: 70,
                                              width: 70,
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                                child: Image.network(
                                                  categories[index]["image"],
                                                  errorBuilder: (context, error,
                                                      stackTrace) {
                                                    return const Center(
                                                      child: Text(
                                                          "image not found"),
                                                    );
                                                  },
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            categories[index]["name"],
                                            style: const TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                        ],
                                      ),
                                      onTap: () {
                                        Get.to(() => CategoryPage(
                                              category: categories[index],
                                            ));
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          //category
                          //Restaurent
                          const Padding(
                            padding: EdgeInsets.only(left: 30),
                            child: Text(
                              "Nearest Restaurents",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                          FutureBuilder(
                            future: shopController.getShopByPincode(),
                            builder: (BuildContext context,
                                AsyncSnapshot<ServerResponse> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return isLoading();
                              }
                              if (addressController.isLoading.value) {
                                return SizedBox();
                              }

                              List shops = snapshot.data!.body["shops"];

                              print(shops);
                              if (shops.isEmpty) {
                                return const Center(
                                  child: Text("No Shop Found At Your Area"),
                                );
                              }

                              return Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: ScrollPhysics(),
                                  itemCount: shops.length,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return InkWell(
                                      onTap: () {
                                        Get.to(
                                          () => ShopPage(
                                            id: shops[index]["_id"],
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          top: 5,
                                          bottom: 5,
                                        ),
                                        child: SizedBox(
                                          height: Get.size.width - 140,
                                          width: Get.size.width - 40,
                                          child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                            ),
                                            elevation: 0.1,
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                  child: Image.network(
                                                    shops[index]["image"],
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return const Center(
                                                        child: Text(
                                                            "image not found"),
                                                      );
                                                    },
                                                    height:
                                                        Get.size.width - 230,
                                                    width: Get.size.width - 40,
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: AutoSizeText(
                                                    shops[index]["store_name"],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: AutoSizeText(
                                                    shops[index]
                                                        ["address_line1"],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      EdgeInsets.only(left: 10),
                                                  child: AutoSizeText(
                                                    shops[index]["city"],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                          //Restaurent
                          //Restaurent
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  bool isInCart({required String id}) {
    HomepageController homepageController = Get.put(HomepageController());
    if (cartControllers.cart['cart_inventory'] != null) {
      List inventory = cartControllers.cart['cart_inventory'];

      var contains = inventory.firstWhere(
        (element) => element['product']['_id'] == id,
        orElse: () => null,
      );

      if (contains != null) {
        return true;
      }
    }
    return false;
  }
}
