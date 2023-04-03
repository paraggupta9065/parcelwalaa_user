import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/homepage_controller.dart';
import 'package:parcelwalaa_app/controller/order_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/colors.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:url_launcher/url_launcher.dart';

class PreviousOrders extends StatefulWidget {
  const PreviousOrders({Key? key}) : super(key: key);

  @override
  State<PreviousOrders> createState() => _PreviousOrdersState();
}

class _PreviousOrdersState extends State<PreviousOrders> {
  OrdersController ordersController = Get.put(OrdersController());
  HomepageController homepageController = Get.put(HomepageController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
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
                Get.back();
              },
              color: Colors.black,
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
              ),
            ),
          ),
          title: const Text(
            "Previous Orders",
            style: TextStyle(color: kTextColour),
          ),
        ),
        body: FutureBuilder(
          future: ordersController.getPreviousOrders(),
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
            List orders = snapshot.data!.body["orders"];

            if (orders.isEmpty) {
              return const Center(
                child: Text(
                  "No Previous Order Found \nExplore Some Amazing Food",
                  textAlign: TextAlign.center,
                ),
              );
            }

            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  trailing: InkWell(
                    onTap: () {
                      _launchUrl(
                          "https://web.whatsapp.com/send?phone=918602924462&text=Hi%20I%20Want%20Help%20With%20Order%20Id%20${orders[index]['_id']}");
                    },
                    child: const Text("Help"),
                  ),
                  title: Text(orders[index]['status'].toString()),
                  subtitle: ListView.builder(
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                    itemCount: orders[index]['order_inventory'].length,
                    itemBuilder: (BuildContext context, int index1) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            CircleAvatar(
                              minRadius: 10,
                              backgroundImage: NetworkImage(orders[index]
                                      ['order_inventory'][index1]['product']
                                  ['images']),
                            ),
                            SizedBox(width: 5),
                            Text(
                              orders[index]['order_inventory'][index1]
                                      ['product']['name']
                                  .toString(),
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ));
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }
}
