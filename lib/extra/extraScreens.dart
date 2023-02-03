// import 'dart:async';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
//
// class Extra extends StatefulWidget {
//   const Extra({Key? key}) : super(key: key);
//
//   @override
//   State<Extra> createState() => _ExtraState();
// }
//
// class _ExtraState extends State<Extra> {
//   final _formKey = GlobalKey<FormState>();
//   final hrsController = TextEditingController(text: "0");
//   final minController = TextEditingController(text: "0");
//
//   // Completer<GoogleMapController> _controller = Completer();
//   late GoogleMapController mapController;
//   LatLng _initialPosition = LatLng(24.9517415, 67.1229219);
//   List<Marker> myMarkers = [];
//
//   MapType _currentMapType = MapType.normal;
//   Location location = Location();
//   late LocationData locationData;
//   final Set<Marker> _markers = {};
//
//   Future<Uint8List> getBytesFromAsset(String path, int width) async {
//     ByteData data = await rootBundle.load(path);
//     ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//         targetWidth: width);
//     ui.FrameInfo fi = await codec.getNextFrame();
//     return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//         .buffer
//         .asUint8List();
//   }
//
//   void _onMapCreated(GoogleMapController controller) async {
//     print("MAP CREATED");
//     print("location changes injgoogle map mapcreated");
//     bool _serviceEnabled;
//     PermissionStatus _permissionGranted;
//     _serviceEnabled = await location.serviceEnabled();
//     if (!_serviceEnabled) {
//       _serviceEnabled = await location.requestService();
//       if (!_serviceEnabled) {
//         return;
//       }
//     }
//
//     _permissionGranted = await location.hasPermission();
//     if (_permissionGranted == PermissionStatus.denied) {
//       _permissionGranted = await location.requestPermission();
//       if (_permissionGranted != PermissionStatus.granted) {
//         return;
//       }
//     }
//     locationData = await location.getLocation();
//     // _controller.complete(controller);
//     mapController = controller;
//     // location.onLocationChanged.listen((LocationData currentLocation) async {
//     //   final Uint8List markerIcon =
//     //       await getBytesFromAsset('assets/carIcon_green.png', 100);
//     //   print("location on changes is ${currentLocation.longitude} ${currentLocation.latitude}");
//     //   if (myMarkers.isNotEmpty) {
//     //
//     //
//     //     myMarkers.clear();
//     //   }
//     //   if (this.mounted) {
//     //     setState(() {
//     //       // Your state change code goes here
//     //       myMarkers.add(Marker(
//     //         //add start location marker
//     //           markerId: MarkerId(
//     //               LatLng(currentLocation.latitude!, currentLocation.longitude!).toString()),
//     //           position: LatLng(currentLocation.latitude!, currentLocation.longitude!),
//     //           //      flat: true,
//     //           rotation: currentLocation.heading!,
//     //           infoWindow: InfoWindow(
//     //             //popup info
//     //             title: '${LatLng(currentLocation.latitude!, currentLocation.longitude!)}',
//     //             // snippet: 'Start Marker',
//     //           ),
//     //           // icon: markerbitmap
//     //           icon: BitmapDescriptor.fromBytes(markerIcon),
//     //           onTap: () {
//     //             print("tap on marker");
//     //             // MarkerDetail(  lng: event.longitude!, lat: event.latitude!,);
//     //
//     //           } //Icon for Marker
//     //       ));
//     //     });
//     //   }
//     //   mapController.animateCamera(CameraUpdate.newCameraPosition(
//     //     CameraPosition(
//     //       target: LatLng(currentLocation.latitude!, currentLocation.longitude!),
//     //       zoom: 17,
//     //     ),
//     //   ));
//     //
//     //
//     // });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Extra Screens"),
//       ),
//       body: Stack(
//         children: <Widget>[
//           GoogleMap(
//             markers: Set<Marker>.from(myMarkers),
//             mapType: _currentMapType,
//             // onCameraMove: _onCameraMove,
//             onMapCreated: _onMapCreated,
//             myLocationEnabled: true,
//             initialCameraPosition: CameraPosition(
//               target: _initialPosition,
//               zoom: 17,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// // Column(
// //
// //   children: [
// //     InkWell(
// //       onTap: (){
// //         showDialog(context: context,
// //             builder: (BuildContext context){
// //               return AlertDialog(
// //                 contentPadding: EdgeInsets.zero,
// //                 insetPadding: EdgeInsets.all(10.0),
// //                 shape: RoundedRectangleBorder(
// //                     borderRadius: BorderRadius.circular(5.0)
// //                 ),
// //
// //                 content: Container(
// //                     width: size.width * 1,
// //                     child: Form(
// //                       key: _formKey,
// //                       child: Column(
// //                         mainAxisSize: MainAxisSize.min,
// //                         children: [
// //                           SizedBox(height: 20,),
// //                           Row(children: [
// //
// //                             //hours
// //                             Expanded(
// //                                 flex: 5,
// //                                 child:
// //
// //                                 Container(
// //                                   padding: EdgeInsets.only(left: 20.0,right: 20.0),
// //                                   child: TextFormField(
// //
// //                                     keyboardType: TextInputType.number,
// //                                     validator:  (value) {
// //                                       if (value == null || value.isEmpty) {
// //                                         return 'Please enter Hours';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: InputDecoration(
// //                                       contentPadding: EdgeInsets.only(left: 5),
// //                                       suffixIcon: Icon(Icons.access_time_sharp),
// //
// //
// //                                       label: Text("Hours",),
// //                                       border: OutlineInputBorder(
// //
// //                                       ),
// //                                     ),
// //
// //                                   ),
// //                                 )
// //
// //
// //
// //                             ),
// //                             //minutes
// //                             Expanded(
// //                                 flex: 5,
// //                                 child:
// //
// //                                 Container(
// //                                   padding: EdgeInsets.only(left: 20.0,right: 20.0),
// //                                   child: TextFormField(
// //
// //                                     keyboardType: TextInputType.number,
// //                                     validator:  (String? value) {
// //                                       print("length of ${value!.length}");
// //                                       if (value == null || value.isEmpty || value.length < 0) {
// //                                         return 'Please enter Minutes';
// //                                       }
// //                                       return null;
// //                                     },
// //                                     decoration: InputDecoration(
// //                                       contentPadding: EdgeInsets.only(left: 5),
// //                                       suffixIcon: Icon(Icons.access_time_sharp),
// //
// //
// //                                       label: Text("Minutes",),
// //                                       border: OutlineInputBorder(
// //
// //                                       ),
// //                                     ),
// //
// //                                   ),
// //                                 )
// //
// //
// //
// //                             ),
// //
// //                             // Expanded(
// //                             //     child: TextInputDialogWidget(
// //                             //       // initialValue: '0',
// //                             //       textEditingController: minController,
// //                             //       callback: () {},
// //                             //       label: 'Minutes',
// //                             //       icon: const Icon(Icons.lock_clock),
// //                             //       textInputType: TextInputType.number,
// //                             //       inputFormatter: [
// //                             //         FilteringTextInputFormatter.allow(
// //                             //             RegExp('[0-9]')),
// //                             //       ],
// //                             //       onChanged: (value) =>
// //                             //       createSessionViewModel.mins =
// //                             //           value /*twoDigits(int.parse(value))*/,
// //                             //     ),
// //                             //     flex: 5),
// //                           ]),
// //                         ],
// //                       )
// //
// //                     )
// //
// //
// //                 ),
// //
// //                 actions: [
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.end ,
// //                     children: [
// //                     ElevatedButton(onPressed: (){
// //                       Navigator.pop(context);
// //                     }, child: Text("Cancel")),
// //
// //                     SizedBox(width: 10,),
// //                     ElevatedButton(
// //
// //                         onPressed: (){
// //                       if(_formKey.currentState!.validate()){
// //
// //                       }
// //                     }, child: Text("Ok")),
// //                   ],)
// //
// //                 ],
// //               );
// //
// //
// //
// //             });
// //       },
// //       child:  Text("00:00",textAlign: TextAlign.center,)
// //
// //       ,
// //     ),
// //
// //     Input_Text_Form_Field(
// //       keyboardType: TextInputType.number,
// //       label: "Hours",
// //       validateData: (value) {
// //         if (value == null || value.isEmpty) {
// //           return 'Please enter First Name';
// //         }
// //         return null;
// //       },
// //       padding: EdgeInsets.only(left: 20.0,right: 20.0),
// //
// //     ),
// //     SizedBox(
// //       height: 10,
// //     ),
// //     ButtonWidget(
// //       padding: EdgeInsets.only(left: 20.0,right: 20.0),
// //       onPressed: (){
// //         if (_formKey.currentState!.validate()) {
// //           // If the form is valid, display a snackbar. In the real world,
// //           // you'd often call a server or save the information in a database.
// //           // ScaffoldMessenger.of(context).showSnackBar(
// //           //   const SnackBar(content: Text('Processing Data')),
// //           // );
// //         }
// //       }, text: 'Validate',
// //       btnWidth: size.width * 1,
// //     )
// //   ],
// // )
