import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:parcelwalaa_app/controller/order_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/utils/isLoading.dart';
import 'package:parcelwalaa_app/view/homepage/cart.dart';
import 'package:parcelwalaa_app/view/homepage/orders.dart';

class OrderCart extends StatefulWidget {
  const OrderCart({Key? key}) : super(key: key);

  @override
  State<OrderCart> createState() => _OrderCartState();
}

class _OrderCartState extends State<OrderCart> {
  OrdersController ordersController = Get.put(OrdersController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ordersController.getOrder(),
        builder:
            (BuildContext context, AsyncSnapshot<ServerResponse> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return isLoading();
          } else if (snapshot.data!.body['status'] == "fail") {
            return Center(
              child: Text(snapshot.data!.body['msg']),
            );
          } else if (snapshot.data!.body['status'] == "notFound") {
            return const Cart();
          }

          return FutureBuilder(
            future: ordersController.getMarkers(),
            builder: ((context, snapshot) {
              return const Order();
            }),
          );
        },
      ),
    );
  }
}
