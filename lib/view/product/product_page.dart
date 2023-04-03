import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/product_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';

class ProductPage extends StatefulWidget {
  final String id;
  ProductPage({required this.id});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final ProductController productController = Get.put(ProductController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: productController.getProduct(id: widget.id),
        builder:
            (BuildContext context, AsyncSnapshot<ServerResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return isLoading();
          }
          dynamic product = snapshot.data!.body['product'];
          return SingleChildScrollView(
              child: Column(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 20),
                    child: ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomRight: Radius.circular(30),
                        bottomLeft: Radius.circular(30),
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30),
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
                                  product["images"],
                                  fit: BoxFit.fill,
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
                                Card(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  elevation: 1,
                                  child: IconButton(
                                    onPressed: () {},
                                    color: Colors.black,
                                    icon: const Icon(
                                      Icons.favorite_border_rounded,
                                    ),
                                  ),
                                ),
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
                                    onPressed: () {},
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
                  Container(
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product["name"],
                            style: const TextStyle(
                              fontSize: 30,
                            ),
                          ),
                          SizedBox(
                            width: 150,
                            child: Text(
                              "Price. ${product['price'].toString()}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 25),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Text(
                            product["description"],
                            style: const TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          const Divider(color: Colors.black),
                          const SizedBox(height: 10),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ));
        },
      ),
    );
  }
}
