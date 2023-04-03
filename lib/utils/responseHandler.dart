import 'package:dio/dio.dart';
import 'package:get/route_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:parcelwalaa_app/controller/auth_controller.dart';
import 'package:parcelwalaa_app/model/response_model.dart';
import 'package:parcelwalaa_app/view/auth/login_screen.dart';

Future<ServerResponse> responseHandler({
  required String url,
  required Map body,
  bool sendToken = true,
}) async {
  Response? rawResponse;
  try {
    Dio dio = Dio(BaseOptions(
        responseType: ResponseType.json,
        validateStatus: (_) => true,
        headers: {"token": sendToken ? authController.getToken() : ""}));
    rawResponse = await dio.post(
      url,
      data: body,
    );

    if (rawResponse.data['status'] == "logout") {
      authController.removeLoginLog();

      Get.offAll(() => const LoginScreen());
    }
  } catch (e) {
    print(e);
  }
  if (rawResponse == null) {
    return ServerResponse(
        statusCode: 401,
        body: {"status": "fail", "msg": "Something went rent"});
  }

  return ServerResponse(
      statusCode: rawResponse.statusCode!, body: rawResponse.data);
}

AuthController authController = Get.put(AuthController());
Future<ServerResponse> responseHandlerGet({
  required String url,
  bool sendToken = true,
}) async {
  Response? rawResponse;
  try {
    Dio dio = Dio(BaseOptions(
        responseType: ResponseType.json,
        validateStatus: (_) => true,
        headers: {"token": authController.getToken()}));
    rawResponse = await dio.get(
      url,
    );

    if (rawResponse.data['status'] == "logout") {
      authController.removeLoginLog();

      Get.offAll(() => const LoginScreen());
    }
  } catch (e) {
    print(e);
  }

  if (rawResponse == null) {
    return ServerResponse(
        statusCode: 401,
        body: {"status": "fail", "msg": "Something went rent"});
  }

  return ServerResponse(
      statusCode: rawResponse.statusCode!, body: rawResponse.data);
}

//category 
//add to cart



