import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/cart_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';

class PromoCode extends StatefulWidget {
  @override
  State<PromoCode> createState() => _PromoCodeState();
}

class _PromoCodeState extends State<PromoCode> {
  final CartControllers cartControllers = Get.put(CartControllers());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
            child: Row(
              children: [
                Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 1,
                  child: IconButton(
                    onPressed: () => Get.back(),
                    color: Colors.black,
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
              ],
            ),
          ),
          SizedBox(
            height: 50,
            child: Center(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 5,
                shadowColor: Colors.white,
                color: Colors.white,
                child: SizedBox(
                  height: 50,
                  width: Get.size.width - 60,
                  child: const TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(
                        Icons.card_membership,
                        size: 20,
                      ),
                      hintText: "Search For Promo",
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
            ),
          ),
          FutureBuilder(
            future: cartControllers.getCoupon(),
            builder:
                (BuildContext context, AsyncSnapshot<ServerResponse> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return isLoading();
              }
              List coupons = snapshot.data!.body["coupons"];

              return ListView.builder(
                itemCount: coupons.length,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  Map coupon = coupons[index];
                  List categories = coupon['categories'];
                  List aplicableProducts = coupon['products'];
                  List restaurants = coupon['restaurants'];
                  List inv = cartControllers.cart['cart_inventory'];
                  bool valid = false;
                  String reasion = '';
                  List categoriesOfProduct = [];
                  List restaurantsOfProduct = [];
                  List products = [];
                  for (Map element in inv) {
                    products.add(element['product']['_id']);
                    restaurantsOfProduct.add(element['shop_id']['_id']);
                    categoriesOfProduct.add(element['product']['categories']);
                  }

                  List isProduct = aplicableProducts
                      .toSet()
                      .intersection(products.toSet())
                      .toList();
                  List isCategories = categoriesOfProduct
                      .toSet()
                      .intersection(categories.toSet())
                      .toList();
                  List isRestaurent = restaurants
                      .toSet()
                      .intersection(restaurantsOfProduct.toSet())
                      .toList();

                  if (products.length == isProduct.length) {
                    valid = true;
                    reasion = '';
                  } else if (restaurantsOfProduct.length ==
                      isRestaurent.length) {
                    reasion = '';
                    valid = true;
                  } else if (categoriesOfProduct.length ==
                      isCategories.length) {
                    reasion = '';
                    valid = true;
                  } else {
                    reasion =
                        'Coupon only applicable on selected product category or restaurant';
                    valid = false;
                  }

                  return Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: Card(
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          15,
                        ),
                      ),
                      child: ListTile(
                        title: Text(
                          coupon["coupon_code"],
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              coupon["description"],
                            ),
                            Text(
                              valid ? "" : reasion,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 10),
                            ),
                          ],
                        ),
                        trailing: InkWell(
                          onTap: () {
                            if (valid) {
                              cartControllers.applyCoupon(
                                id: coupon["_id"],
                              );
                            }
                          },
                          child: Text(
                            valid ? "apply" : 'not applicable',
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
