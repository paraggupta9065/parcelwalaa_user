import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:parcelwalaa_app/controller/auth_controller.dart';
import 'package:parcelwalaa_app/controller/order_controller.dart';
import 'package:parcelwalaa_app/utils/url.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class NotificationController extends GetxController {
  AuthController authController = Get.put(AuthController());
  OrdersController ordersController = Get.put(OrdersController());
  // FirebaseMessaging messaging = FirebaseMessaging.instance;

  IO.Socket socket = IO.io(kMainUrl, {
    'autoConnect': true,
    'transports': ['websocket'],
  });

  void socketConnect() async {
    Map user = authController.getUser();

    try {
      socket.onConnect((_) async {
        socket.emit('customer_join', user['_id']);
        socket.on(
          'customer_update',
          (data) async {
            ordersController.status.value = data;
          },
        );
      });
    } catch (e) {
      print(e);
    }
  }
}
