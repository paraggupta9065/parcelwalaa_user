import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/category_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:parcelwalaa_app/view/product/product_page.dart';
import 'package:parcelwalaa_app/controller/cart_controller.dart';
import 'package:parcelwalaa_app/controller/product_controller.dart';
import 'package:parcelwalaa_app/controller/shop_controller.dart';
import 'package:share_plus/share_plus.dart';

class CategoryStudentPage extends StatefulWidget {
  final String id;
  const CategoryStudentPage({Key? key, required this.id}) : super(key: key);

  @override
  State<CategoryStudentPage> createState() => _CategoryStudentPageState();
}

class _CategoryStudentPageState extends State<CategoryStudentPage> {
  CategoriesController categoriesController = Get.put(CategoriesController());
  final ProductController productController = Get.put(ProductController());
  final CartControllers cartControllers = Get.put(CartControllers());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder(
          future:
              categoriesController.getCategoryStudent(categoryId: widget.id),
          builder:
              (BuildContext context, AsyncSnapshot<ServerResponse> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Padding(
                padding: EdgeInsets.only(top: 100),
                child: isLoading(),
              );
            }

            Map categories = snapshot.data!.body['categorie'];

            return SingleChildScrollView(
                child: Column(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                      child: ClipRRect(
                        borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(30),
                        ),
                        child: Stack(
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: Get.size.height * .45,
                                  width: Get.size.width,
                                  child: Image.network(
                                    categories["image"],
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Center(
                                        child: Text("image not found"),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, left: 20, right: 20),
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
                                  // Card(
                                  //   color: Colors.white,
                                  //   shape: RoundedRectangleBorder(
                                  //     borderRadius: BorderRadius.circular(15),
                                  //   ),
                                  //   elevation: 1,
                                  //   child: IconButton(
                                  //     onPressed: () {},
                                  //     color: Colors.black,
                                  //     icon: const Icon(
                                  //       Icons.favorite_border_rounded,
                                  //     ),
                                  //   ),
                                  // ),
                                  const SizedBox(
                                    width: 20,
                                  ),
                                  Card(
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    elevation: 1,
                                    child: IconButton(
                                      onPressed: () {
                                        Share.share(
                                          'Check Out This Product At Bingrr',
                                        );
                                      },
                                      color: Colors.black,
                                      icon: const Icon(
                                        Icons.share,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Text(
                            categories["name"],
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          child: FutureBuilder(
                            future: categoriesController.getBrands(
                                categoryId: widget.id),
                            builder: (BuildContext context,
                                AsyncSnapshot<ServerResponse> snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 100),
                                  child: isLoading(),
                                );
                              }

                              if (categoriesController.brands.isNotEmpty) {
                                Future.delayed(const Duration(milliseconds: 10))
                                    .then((value) =>
                                        productController.getProductsByFilter(
                                          map: {
                                            "categoriesStudents": widget.id,
                                            "brand":
                                                categoriesController.brands[
                                                    categoriesController
                                                        .selectedIndex
                                                        .value]['_id'],
                                          },
                                        ));
                              }
                              List brands = snapshot.data!.body['brands'];
                              return Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ScrollPhysics(),
                                  itemCount: brands.length,
                                  scrollDirection: Axis.horizontal,
                                  itemBuilder:
                                      (BuildContext context, int index) {
                                    return Obx(
                                      () => InkWell(
                                        onTap: () async {
                                          categoriesController
                                              .selectedIndex.value = index;
                                          await productController
                                              .getProductsByFilter(
                                            map: {
                                              "categoriesStudents": widget.id,
                                              "brand":
                                                  categoriesController.brands[
                                                      categoriesController
                                                          .selectedIndex
                                                          .value]['_id'],
                                            },
                                          );
                                        },
                                        child: Card(
                                          elevation: 0.5,
                                          shape: const RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(10),
                                            ),
                                          ),
                                          color: categoriesController
                                                      .selectedIndex.value ==
                                                  index
                                              ? kPrimaryColour
                                              : Colors.white,
                                          child: SizedBox(
                                            height: 30,
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Text(
                                                brands[index]['name'],
                                                style: TextStyle(
                                                  color: categoriesController
                                                              .selectedIndex
                                                              .value ==
                                                          index
                                                      ? Colors.white
                                                      : Colors.black,
                                                ),
                                              ),
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
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 20,
                          ),
                          child: Obx(
                            () => productController.isLoading.value
                                ? isLoading()
                                : productController.products.isEmpty
                                    ? const Center(
                                        child: Text("No product found"),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: ScrollPhysics(),
                                        itemCount:
                                            productController.products.length,
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return InkWell(
                                            child: Card(
                                              elevation: 0.5,
                                              shape:
                                                  const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(20),
                                                ),
                                              ),
                                              child: SizedBox(
                                                height: 100,
                                                child: Row(
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius:
                                                          const BorderRadius
                                                              .only(
                                                        bottomRight:
                                                            Radius.circular(20),
                                                        bottomLeft:
                                                            Radius.circular(20),
                                                        topLeft:
                                                            Radius.circular(20),
                                                        topRight:
                                                            Radius.circular(20),
                                                      ),
                                                      child: Image.network(
                                                        productController
                                                                .products[index]
                                                            ['images'],
                                                        fit: BoxFit.cover,
                                                        height: 100,
                                                        width: 110,
                                                        errorBuilder: (context,
                                                            error, stackTrace) {
                                                          return const Center(
                                                            child: Text(
                                                                "image not found"),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              bottom: 10,
                                                              left: 10),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          SizedBox(
                                                            width: 150,
                                                            height: 40,
                                                            child: Text(
                                                              productController
                                                                      .products[
                                                                  index]['name'],
                                                              style: const TextStyle(
                                                                  color: Colors
                                                                      .black),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                          // SizedBox(
                                                          //   width: 100,
                                                          //   height: 20,
                                                          //   child: Text(
                                                          //     productController
                                                          //                 .products[
                                                          //             index]
                                                          //         ['description'],
                                                          //     style: const TextStyle(
                                                          //         color: Colors
                                                          //             .black,
                                                          //         fontSize: 10),
                                                          //     maxLines: 1,
                                                          //     overflow:
                                                          //         TextOverflow
                                                          //             .ellipsis,
                                                          //   ),
                                                          // ),
                                                          SizedBox(
                                                            width: 100,
                                                            child: Text(
                                                              "Price. ${productController.products[index]['price'].toString()}",
                                                              style:
                                                                  const TextStyle(
                                                                color: Colors
                                                                    .black,
                                                              ),
                                                              maxLines: 2,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Center(
                                                          child: IconButton(
                                                        onPressed: () {
                                                          cartControllers.addToCart(
                                                              productId: productController
                                                                      .products[
                                                                  index]['_id']);
                                                        },
                                                        icon: Icon(
                                                          Icons.add,
                                                          color:
                                                              Colors.grey[400],
                                                        ),
                                                      )),
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
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ));
          },
        ),
      ),
    );
  }
}
