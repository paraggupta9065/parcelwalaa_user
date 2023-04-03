import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:parcelwalaa_app/controller/cart_controller.dart';
import 'package:parcelwalaa_app/controller/product_controller.dart';
import 'package:parcelwalaa_app/controller/shop_controller.dart';
import 'package:parcelwalaa_app/view/product/category_store_product.dart';
import 'package:parcelwalaa_app/view/shop/shop_page.dart';

class CategoryPage extends StatefulWidget {
  final Map category;
  const CategoryPage({Key? key, required this.category}) : super(key: key);

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final ShopController shopController = Get.put(ShopController());
  final ProductController productController = Get.put(ProductController());
  final CartControllers cartControllers = Get.put(CartControllers());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          widget.category['name'],
          style:
              const TextStyle(fontWeight: FontWeight.w200, color: Colors.white),
        ),
      ),
      body: FutureBuilder(
        future: shopController.getShopByCategory(
            categoryId: widget.category['_id']),
        builder:
            (BuildContext context, AsyncSnapshot<ServerResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return isLoading();
          }
          if (snapshot.data!.body["status"] == 'fail') {
            return Center(
              child: Text(snapshot.data!.body["msg"]),
            );
          }

          List shops = snapshot.data!.body["shops"];

          return Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ListView.builder(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              itemCount: shops.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                  onTap: () {
                    Get.to(
                      () => CategoryStoreProduct(
                        shop_id: shops[index]["_id"],
                        category: widget.category,
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
                          borderRadius: BorderRadius.circular(15),
                        ),
                        elevation: 0.1,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                shops[index]["image"],
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return const Center(
                                    child: Text("image not found"),
                                  );
                                },
                                height: Get.size.width - 230,
                                width: Get.size.width - 40,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                shops[index]["store_name"],
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                shops[index]["address_line1"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(left: 10),
                              child: AutoSizeText(
                                shops[index]["city"],
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
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
    );
  }
}
