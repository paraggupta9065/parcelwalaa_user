// import 'package:flutter/material.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
// import 'package:get/get.dart';
// import 'package:parcelwalaa_app/controller/address_controller.dart';
// import 'package:parcelwalaa_app/controller/auth_controller.dart';
// import 'package:parcelwalaa_app/model/response_model.dart';
// import 'package:parcelwalaa_app/utils/colors.dart';
// import 'package:parcelwalaa_app/utils/isLoading.dart';
// import 'package:parcelwalaa_app/view/homepage/homepage.dart';
// import 'package:parcelwalaa_app/view/homepage/mainHome.dart';
// import 'package:permission_handler/permission_handler.dart';

// class AddAddress extends StatefulWidget {
//   const AddAddress({Key? key}) : super(key: key);

//   @override
//   State<AddAddress> createState() => _AddAddressState();
// }

// class _AddAddressState extends State<AddAddress> {
//   AddressController addressController = Get.put(AddressController());
//   AuthController authController = Get.put(AuthController());

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   late List<Placemark> placemarks;

//   getLocation() async {
//     var status = await Permission.locationWhenInUse.request();
//     if (status.isGranted) {
//       Position position = await Geolocator.getCurrentPosition(
//           desiredAccuracy: LocationAccuracy.high);
//       placemarks =
//           await placemarkFromCoordinates(position.latitude, position.longitude);

//       addressController.line1.text =
//           '${placemarks[0].street!},${placemarks[0].name!},${placemarks[0].subLocality!}';
//       addressController.pincode.text = placemarks[0].postalCode!;

//       addressController.city.text = placemarks[0].administrativeArea!;
//       addressController.lat.value = position.latitude.toString();
//       addressController.long.value = position.longitude.toString();

//       addressController.contactNo.text =
//           authController.getUser()['number'].toString();
//     } else if (status.isDenied) {
//       Get.snackbar("Permissions", "Permission Denied");
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: kPrimaryColour,
//         elevation: 0,
//         centerTitle: true,
//         leading: IconButton(
//           onPressed: () {
//             Get.back();
//           },
//           color: Colors.black,
//           icon: const Icon(
//             Icons.arrow_back_ios_new_rounded,
//           ),
//         ),
//         title: const Text(
//           "Add Address ",
//           style: TextStyle(color: kTextColour),
//         ),
//       ),
//       body: FutureBuilder(
//         future: getLocation(),
//         builder: (BuildContext context, AsyncSnapshot snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return isLoading();
//           }
//           return Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               const SizedBox(
//                 height: 20,
//               ),
//               SizedBox(
//                 height: 50,
//                 child: Center(
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 0.5,
//                     shadowColor: Colors.white,
//                     color: Colors.white,
//                     child: SizedBox(
//                       height: 50,
//                       width: Get.size.width - 60,
//                       child: TextField(
//                         controller: addressController.name,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(
//                             FontAwesomeIcons.person,
//                             size: 20,
//                           ),
//                           hintText: "Name",
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//                 child: Center(
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 0.5,
//                     shadowColor: Colors.white,
//                     color: Colors.white,
//                     child: SizedBox(
//                       height: 50,
//                       width: Get.size.width - 60,
//                       child: TextField(
//                         controller: addressController.line1,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(
//                             FontAwesomeIcons.locationArrow,
//                             size: 20,
//                           ),
//                           hintText: "Line 1",
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//                 child: Center(
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 0.5,
//                     shadowColor: Colors.white,
//                     color: Colors.white,
//                     child: SizedBox(
//                       height: 50,
//                       width: Get.size.width - 60,
//                       child: TextField(
//                         controller: addressController.landmark,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(
//                             FontAwesomeIcons.landmark,
//                             size: 20,
//                           ),
//                           hintText: "Landmark(Optional)",
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               // SizedBox(
//               //   height: 50,
//               //   child: Center(
//               //     child: Card(
//               //       shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(15),
//               //       ),
//               //       elevation: 0.5,
//               //       shadowColor: Colors.white,
//               //       color: Colors.white,
//               //       child: SizedBox(
//               //         height: 50,
//               //         width: Get.size.width - 60,
//               //         child: TextField(
//               //           controller: addressController.pincode,
//               //           decoration: const InputDecoration(
//               //             prefixIcon: Icon(
//               //               FontAwesomeIcons.locationCrosshairs,
//               //               size: 20,
//               //             ),
//               //             hintText: "Pincode",
//               //             border: InputBorder.none,
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               // SizedBox(
//               //   height: 50,
//               //   child: Center(
//               //     child: Card(
//               //       shape: RoundedRectangleBorder(
//               //         borderRadius: BorderRadius.circular(15),
//               //       ),
//               //       elevation: 0.5,
//               //       shadowColor: Colors.white,
//               //       color: Colors.white,
//               //       child: SizedBox(
//               //         height: 50,
//               //         width: Get.size.width - 60,
//               //         child: TextField(
//               //           controller: addressController.city,
//               //           decoration: const InputDecoration(
//               //             prefixIcon: Icon(
//               //               FontAwesomeIcons.city,
//               //               size: 20,
//               //             ),
//               //             hintText: "City",
//               //             border: InputBorder.none,
//               //           ),
//               //         ),
//               //       ),
//               //     ),
//               //   ),
//               // ),
//               SizedBox(
//                 height: 50,
//                 child: Center(
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 0.5,
//                     shadowColor: Colors.white,
//                     color: Colors.white,
//                     child: SizedBox(
//                       height: 50,
//                       width: Get.size.width - 60,
//                       child: TextField(
//                         controller: addressController.contactNo,
//                         decoration: const InputDecoration(
//                           prefixIcon: Icon(
//                             FontAwesomeIcons.phone,
//                             size: 20,
//                           ),
//                           hintText: "Number",
//                           border: InputBorder.none,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(
//                 height: 100,
//                 child: Center(
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 0.5,
//                     shadowColor: Colors.white,
//                     color: Colors.white,
//                     child: SizedBox(
//                         width: Get.size.width - 60,
//                         child: Padding(
//                           padding: const EdgeInsets.all(15),
//                           child: TextField(
//                             controller: addressController.deliveryNote,
//                             maxLines: 2,
//                             decoration: const InputDecoration(
//                               hintText: "Delivery Note",
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         )),
//                   ),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.only(left: 30, right: 30),
//                 child: Obx(
//                   () => Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                     children: [
//                       SizedBox(
//                         height: 50,
//                         width: 100,
//                         child: InkWell(
//                           onTap: () {
//                             addressController.type.value = "home";
//                           },
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 0.5,
//                             shadowColor: Colors.white,
//                             color: addressController.type == "home"
//                                 ? kPrimaryColour
//                                 : Colors.white,
//                             child: Center(
//                               child: Text(
//                                 "Home",
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                       SizedBox(
//                           height: 50,
//                           width: 100,
//                           child: InkWell(
//                             onTap: () {
//                               addressController.type.value = "office";
//                             },
//                             child: Card(
//                               shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(15),
//                               ),
//                               elevation: 0.5,
//                               shadowColor: Colors.white,
//                               color: addressController.type == "office"
//                                   ? kPrimaryColour
//                                   : Colors.white,
//                               child: Center(
//                                 child: Text(
//                                   "Office",
//                                   style: TextStyle(
//                                     color: Colors.grey[600],
//                                   ),
//                                 ),
//                               ),
//                             ),
//                           )),
//                       SizedBox(
//                         height: 50,
//                         width: 150,
//                         child: InkWell(
//                           onTap: () {
//                             addressController.type.value = "friendOrFamily";
//                           },
//                           child: Card(
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(15),
//                             ),
//                             elevation: 0.5,
//                             shadowColor: Colors.white,
//                             color: addressController.type == "friendOrFamily"
//                                 ? kPrimaryColour
//                                 : Colors.white,
//                             child: Center(
//                               child: Text(
//                                 "Friend/Family",
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: 70,
//                 width: Get.size.width - 60,
//                 child: InkWell(
//                   onTap: () async {
//                     ServerResponse response =
//                         await addressController.addAddress();
//                     setState(() {});
//                     if (response.body["status"] == "sucess") {
//                       await addressController.getAddress();
//                       Get.offAll(() => const Homepage());
//                     } else if (response.body["status"] == "fail") {
//                       Get.snackbar(
//                           response.body["status"], response.body["msg"]);
//                     }
//                   },
//                   child: Card(
//                     shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     elevation: 0.5,
//                     shadowColor: Colors.white,
//                     color: kPrimaryColour,
//                     child: Obx(
//                       () => Center(
//                         child: addressController.isLoading.value
//                             ? isLoading()
//                             : Text(
//                                 "Add Address",
//                                 style: TextStyle(
//                                   color: Colors.grey[600],
//                                 ),
//                               ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           );
//         },
//       ),
//     );
//   }
// }
