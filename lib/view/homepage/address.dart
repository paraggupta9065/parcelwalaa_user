

 //TODO : decomment

 
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:parcelwalaa_app/controller/address_controller.dart';
// import 'package:parcelwalaa_app/controller/homepage_controller.dart';
// import 'package:parcelwalaa_app/controller/order_controller.dart';
// import 'package:parcelwalaa_app/model/response_model.dart';
// import 'package:parcelwalaa_app/utils/colors.dart';
// import 'package:parcelwalaa_app/utils/isLoading.dart';
// import 'package:parcelwalaa_app/view/address/add_address.dart';

// class Address extends StatefulWidget {
//   const Address({Key? key}) : super(key: key);

//   @override
//   State<Address> createState() => _AddressState();
// }

// class _AddressState extends State<Address> {
//   AddressController addressController = Get.put(AddressController());
//   HomepageController homepageController = Get.put(HomepageController());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       floatingActionButton: FloatingActionButton(
//         onPressed: () {
//           Get.to(() => const AddAddress());
//         },
//         backgroundColor: kPrimaryColour,
//         child: const Icon(Icons.add),
//       ),
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
//           "Address ",
//           style: TextStyle(color: kTextColour),
//         ),
//       ),
//       body: Obx(
//         () => addressController.isLoading.value == false
//             ? ListView.builder(
//                 itemCount: addressController.address.length,
//                 physics: const ScrollPhysics(),
//                 shrinkWrap: true,
//                 itemBuilder: (BuildContext context, int index) {
//                   return Padding(
//                     padding: const EdgeInsets.only(left: 20, right: 20),
//                     child: ListTile(
//                       onTap: () {
//                         addressController.selectedIndex.value = index;
//                         addressController.visible.value = false;
//                       },
//                       leading: Icon(
//                         addressController.address[index]["type"] == "home"
//                             ? Icons.home
//                             : addressController.address[index]["type"] ==
//                                     "office"
//                                 ? Icons.local_post_office
//                                 : Icons.family_restroom,
//                         color: Colors.black,
//                       ),
//                       title: Text(addressController.address[index]["name"]),
//                       subtitle: Text(addressController.address[index]["line1"]),
//                       trailing: IconButton(
//                         onPressed: () async {
//                           await addressController.deleteAddress(
//                             id: addressController.address[index]["_id"],
//                           );
//                           setState(() {});
//                         },
//                         icon: const Icon(Icons.delete),
//                       ),
//                     ),
//                   );
//                 },
//               )
//             : isLoading(),
//       ),
//     );
//   }


// }



