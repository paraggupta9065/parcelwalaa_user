import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/address_controller.dart';
import 'package:parcelwalaa_app/controller/auth_controller.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/view/homepage/address.dart';
import 'package:parcelwalaa_app/view/homepage/previousOrders.dart';
import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  const Account({Key? key}) : super(key: key);

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  AuthController authController = Get.put(AuthController());
  AddressController addressController = Get.put(AddressController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColour,
      body: SingleChildScrollView(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(30),
                bottomLeft: Radius.circular(30),
              ),
              child: Stack(
                children: [
                  SizedBox(
                    height: Get.size.height * .40,
                    width: Get.size.width,
                    child: Image.network(
                      "https://burst.shopifycdn.com/photos/flatlay-iron-skillet-with-meat-and-other-food.jpg?width=1200&format=pjpg&exif=1&iptc=1",
                      fit: BoxFit.fill,
                      errorBuilder: (context, error, stackTrace) {
                        return const Center(
                          child: Text("image not found"),
                        );
                      },
                    ),
                  ),
                  Container(
                    height: Get.size.height * .40,
                    width: Get.size.width,
                    color: Colors.black.withOpacity(.7),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 150, left: 15),
                    child: Row(
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: const Icon(
                            Icons.person_outline_rounded,
                            size: 100,
                          ),
                        ),
                        SizedBox(
                          height: 100,
                          width: 200,
                          child: ListTile(
                            title: Text(
                              authController.getUser()["name"],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              "+91 " +
                                  authController.getUser()["number"].toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            InkWell(
              onTap: () {
                Get.to(() => const PreviousOrders());
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: 70,
                  width: Get.size.width - 60,
                  child: const Center(
                    child: Text(
                      "Previous Orders",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     Get.to(() => const Address());
            //   },
            //   child: Card(
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(20),
            //     ),
            //     child: SizedBox(
            //       height: 70,
            //       width: Get.size.width - 60,
            //       child: const Center(
            //         child: Text(
            //           "Address",
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 20,
            //           ),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SizedBox(
                height: 70,
                width: Get.size.width - 60,
                child: const Center(
                  child: Text(
                    "Change Details",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                _launchUrl(
                    "https://web.whatsapp.com/send?phone=918602924462&text=Hi%2C%20I%20Want%20To%20Ask%20Something");
              },
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: SizedBox(
                  height: 70,
                  width: Get.size.width - 60,
                  child: const Center(
                    child: Text(
                      "Help",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
