// import 'dart:async';
// import 'dart:math';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geocoder2/geocoder2.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';
// import 'package:novus_guard_pro_flutter/Ui_elements/decoration.dart';
// import 'package:novus_guard_pro_flutter/network/app_url.dart';
// import 'package:novus_guard_pro_flutter/network/response/general_response.dart';
// import 'package:novus_guard_pro_flutter/providers/trip_provider.dart';
// import 'package:novus_guard_pro_flutter/services/background_service.dart';
// import 'package:novus_guard_pro_flutter/theme/color.dart';
// import 'package:novus_guard_pro_flutter/utility/current_location.dart';
// import 'package:novus_guard_pro_flutter/utility/providers_utility.dart';
// import 'package:novus_guard_pro_flutter/utility/shared_preference.dart';
// import 'package:novus_guard_pro_flutter/utility/top_level_variables.dart';
// import 'package:novus_guard_pro_flutter/widgets/app_bar.dart';
// import 'package:provider/provider.dart';
// import 'package:slider_button/slider_button.dart';
// class StartTrip extends StatefulWidget {
//   // final String vrn;
//   // final String vrd;
//   // final String vehicle_id;
//   // final String make;
//   // final String? dateTime;
//   // final int? tripId;
//
//
//   const StartTrip({Key? key}) : super(key: key);
//
//   @override
//   State<StartTrip> createState() => _StartTripState();
// }
//
// class _StartTripState extends State<StartTrip> {
//   late GoogleMapController mapController;
//   Set<Marker> _markers = new Set();
//   String maxSpeedvalue = "0";
//   int idleTime = UserPreferences.idleTime;
//   int duration = UserPreferences.Tripduration;
//   bool isTripdismiss=false;
//   late TripProvider tripProvider;
//   Location location = Location();
//   late LocationData locationData;
//
//   void dispose() {
//     // TODO: implement initState
//     super.dispose();
//     // triptimer!.cancel();
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     tripProvider=ProvidersUtility.tripProvider!;
//     super.initState();
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size=MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBarWidget.getAppBar("Start Trip"),
//
//       body: Stack(
//           children: [
//
//             Consumer<TripProvider>(
//                 builder: (context,tripsDetails,child){
//                   print("getUpdated in tripscreen${tripsDetails.getUpdated!.isNotEmpty}");
//
//
//                   if(tripsDetails.getUpdated!.isNotEmpty){
//                     child=Stack(
//                       children: [
//                         FutureBuilder(
//                             future: CurrentLocation().getCurrentLocation(),
//                             builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat ){
//                               return   GoogleMap(
//                                 markers: _markers,
//                                 myLocationEnabled: true,
//                                 onMapCreated: (GoogleMapController googleController)  async {
//                                   mapController=googleController;
//                                   print("Google map forground");
//
//
//
//
//                                   location.onLocationChanged.listen((event)  async {
//                                     print("location in goigle is ${event}");
//                                     BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
//                                       ImageConfiguration(),
//                                       "assets/carimage.png",
//                                     );
//
//                                     if(this.mounted){
//                                       WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                                         setState(() {
//                                           // idleTime=tripsDetails.getUpdated!['idleSec1'];
//                                           if(_markers.isNotEmpty){
//                                             _markers.clear();
//                                           }
//                                           else{
//                                             // print("else condition markers ${tripsDetails.getUpdated!['idleSec1']}");
//                                             _markers.add(Marker(
//                                               //add first marker
//                                                 rotation: event.heading!,
//                                                 markerId: MarkerId("${LatLng(event.latitude!,event.longitude!)}"),
//                                                 position: LatLng(event.latitude!,event.longitude!), //position of marker
//                                                 icon: markerbitmap
//                                               //markerbitmap, //Icon for Marker
//                                             ));
//
//                                           }
//                                         });
//                                       });
//
//                                     }
//                                     mapController.animateCamera(CameraUpdate.newCameraPosition(
//                                       CameraPosition(
//                                         target: LatLng(event.latitude!,event.longitude!),
//                                         zoom: 17,
//                                       ),
//                                     ));
//
//                                   });
//
//
//
//                                 }, initialCameraPosition: CameraPosition(
//                                   target: LatLng(tripsDetails.getUpdated!['latitude'],tripsDetails.getUpdated!['longitude']),
//                                   // tilt: 50.0,
//                                   zoom: 14
//                               ),
//                               );
//
//
//                             })
//                         ,
//                         //1st section
//                         Row(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Container(
//                               // alignment: Alignment.topLeft,
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                                 color: CustomColor.secondary,
//                               ),
//
//                               margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
//                               padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//
//                               width: 250,
//                               height: 70,
//                               child: Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/roadimage.png",
//                                     width: 50,
//                                   ),
//                                   Container(
//                                     width: 180,
//                                     padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
//                                     child: Text(
//                                       "${tripsDetails.getUpdated!['address']}",
//                                       style:
//                                       TextStyle(color: CustomColor.white, fontSize: 12),
//                                       // maxLines: 20
//                                       // overflow: TextOverflow.ellipsis,
//                                       // softWrap: true,
//                                     ),
//                                   )
//                                 ],
//                               ),
//
//
//                             ),
//                             Container(
//                               margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
//                               padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
//                               child: Container(
//                                   width: 60,
//                                   height: 60,
//                                   decoration: BoxDecoration(
//                                       color: Colors.white,
//                                       shape: BoxShape.circle,
//                                       border: Border.all(color: Colors.red, width: 4)),
//                                   child: Container(
//                                       alignment: Alignment.center,
//                                       child: Text(
//                                         "${tripsDetails.getUpdated!['maxSpeed']}",
//                                         style: TextStyle(
//                                             color: CustomColor.primary,
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18),
//                                       ))),
//                             )
//                           ],
//                         ),
//                         Positioned(
//                           bottom: 130,
//                           left: 5,
//                           right: 5,
//                           child: Container(
//                             child: Row(
//                               children: [
//                                 Container(
//                                     padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
//                                     alignment: Alignment.center,
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.center,
//                                       children: [
//                                         //driver
//                                         Container(
//                                           //width: 200,
//                                           child: Text(
//                                             "Idle time: ${tripsDetails.getUpdated!['idleSec1']}",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: CustomColor.primary),
//                                           ),
//                                         ),
//                                         Container(
//
//                                           // color: Colors.orange,
//                                           //width: 200,
//                                           child: Text(
//                                             "Angle ${tripsDetails.getUpdated!['heading'].round()} deg",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: CustomColor.primary),
//                                           ),
//                                         ),
//                                         //started at
//                                       ],
//                                     )),
//                                 Spacer(),
//                                 //image
//                                 Container(
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         //driver
//                                         Container(
//
//                                           padding: EdgeInsets.only(bottom: 5),
//                                           //width: 200,
//                                           child: Stack(
//                                             children: [
//                                               Image.asset(
//                                                 "assets/speedmeter.png",
//                                                 height: 130,
//                                                 fit: BoxFit.contain,
//                                               ),
//                                               Positioned(
//                                                   top: 15,
//                                                   bottom: 15,
//                                                   left: 10,
//                                                   right: 10,
//                                                   child: Container(
//                                                     alignment: Alignment.center,
//                                                     child: Text(
//                                                       "${double.parse(tripsDetails.getUpdated!['speed'].toString()).toStringAsFixed(2)}",
//                                                       style: TextStyle(
//                                                         fontWeight: FontWeight.bold,
//                                                         fontSize: 18,
//                                                       ),
//                                                     ),
//                                                   ))
//                                             ],
//                                           ),
//                                         ),
//                                         //started at
//                                       ],
//                                     )),
//                                 Spacer(),
//                                 //angle text
//                                 Container(
//                                     padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         //angle
//                                         Container(
//                                           // color: Colors.orange,
//                                           //width: 200,
//                                           child: Text(
//                                             "Angle ${tripsDetails.getUpdated!['heading'].round()} deg ",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: CustomColor.primary),
//                                           ),
//                                         ),
//                                         //gcc
//                                         Container(
//                                           // color: Colors.orange,
//                                           //width: 200,
//                                           child: Text(
//                                             "G-Acc:  ${double.parse(tripsDetails.getUpdated!['GCC'].toString()).toStringAsFixed(2)}",
//                                             style: TextStyle(
//                                                 fontWeight: FontWeight.w500,
//                                                 color: CustomColor.primary),
//                                           ),
//                                         ),
//                                       ],
//                                     )),
//                               ],
//                             ),
//                           ),
//                         ),
//                         //3rd section
//
//                         Positioned(
//                             bottom: 60,
//                             child:
//                             Container(
//                               padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
//                               width: size.width * 1,
//                               //alignment: Alignment.bottomCenter,
//                               // height: 100,
//                               decoration: boxDecoration(CustomColor.white),
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   Flexible(
//                                       flex:1,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                           padding: EdgeInsets.only(right: 5.0),
//
//                                           decoration: BoxDecoration(
//                                               border: Border(
//                                                 right: BorderSide(
//                                                   color: CustomColor.backgroundColor,
//                                                   width: 2,
//                                                 ),
//                                               )
//                                           ),
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Driver",
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                         fontWeight: FontWeight.bold),
//                                                   ),
//                                                   Text(
//                                                     "${UserPreferences.get_Login()['name']}",
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,),
//                                                   ),
//
//
//                                                 ],
//                                               ),
//                                               SizedBox(height: 5,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Started At",
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                         fontWeight: FontWeight.bold),
//                                                   ),
//                                                   Text(
//                                                     "${UserPreferences.getVehicleDetails()['dateTime']}",
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                               SizedBox(height: 5,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Duration",
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                         fontWeight: FontWeight.bold),
//                                                   ),
//                                                   Text(
//                                                     "${double.parse((tripsDetails.getUpdated!['duration'] / 60).toString()).round()} min",
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//                                                 ],
//                                               ),
//                                             ],
//                                           )
//                                       )
//                                   ),
//
//                                   Flexible(
//                                       flex:1,
//                                       fit: FlexFit.tight,
//                                       child: Container(
//                                           padding: EdgeInsets.only(left: 5.0),
//
//                                           child: Column(
//                                             children: [
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "VRN ",
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                         fontWeight: FontWeight.bold),
//                                                   ),
//                                                   Text(
//                                                     "${UserPreferences.getVehicleDetails()['vrn']}",
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//
//
//                                                 ],
//                                               ),
//                                               SizedBox(height: 5,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Started From",
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                         fontWeight: FontWeight.bold),
//                                                   ),
//
//                                                   Text(
//
//                                                     "${UserPreferences.getVehicleDetails()['startedFrom'].toString().length > 12 ? UserPreferences.getVehicleDetails()['startedFrom'].toString().substring(0,12) : ""}",
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                     ),
//                                                   ),
//
//                                                 ],
//                                               ),
//                                               SizedBox(height: 5,),
//                                               Row(
//                                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                                 children: [
//                                                   Text(
//                                                     "Distance",
//                                                     style: TextStyle(
//                                                         fontSize: 12,
//                                                         color: Colors.black,
//                                                         fontWeight: FontWeight.bold),
//                                                   ),
//                                                   //not dialog
//                                                   //(distanceValue[0]!.abs() * 0.000621371).toStringAsFixed(2).toString()
//                                                   Text(
//                                                     "${ double.parse((tripsDetails.getUpdated!['distance'] / 1.6).toString()).toStringAsFixed(2) } miles",
//                                                     style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                     ),
//                                                   )
//                                                 ],
//                                               ),
//                                             ],
//                                           )
//                                       )
//                                   ),
//
//                                 ],
//                               ),
//                               //  alignment: Alignment.bottomCenter,
//                             )),
//
//                         isTripdismiss ==true ?
//                         Container(
//                           alignment: Alignment.center,
//                           child: CircularProgressIndicator(
//                             color: CustomColor.primary,
//
//
//                           ),
//                         ):
//                         SizedBox(),
//                         Container(
//                           width: size.width * 1,
//                           alignment: Alignment.bottomCenter,
//                           padding: EdgeInsets.symmetric(horizontal: 10.0),
//                           child:     SliderButton(
//                             label: Text(
//                               "Slide to Complete Trip",
//                               textAlign: TextAlign.center,
//                               style: TextStyle(
//                                   color: Colors.white, fontSize: 14),
//                             ),
//                             icon: Image.asset("assets/SOSIcon.png"),
//                             buttonColor: CustomColor.white,
//                             buttonSize: 40.0,
//                             shimmer:false,
//                             width: size.width * 0.9,
//                             height: size.width * 0.12,
//                             alignLabel: Alignment.center,
//                             backgroundColor: CustomColor.subBtn,
//                             vibrationFlag: true,
//                             dismissible: isTripdismiss,
//                             action: () async {
//                               setState(() {
//                                 isTripdismiss=!isTripdismiss;
//
//                               });
//                               print("end trip ${UserPreferences.tripId} ${isTripdismiss}");
//                               print("trip details is  ${UserPreferences.tripId} ${isTripdismiss}");
//
//
//                               try{
//                                 print("trip is ${UserPreferences.tripId}");
//                                 GeoData data = await Geocoder2.getDataFromCoordinates(
//                                     latitude: tripsDetails.getUpdated!['latitude'],
//                                     longitude: tripsDetails.getUpdated!['longitude'],
//                                     googleMapApiKey:  "${AppUrl.google_api}");
//                                 final reqBody={
//                                   "organisation_id": UserPreferences.OrganizationId,
//                                   "status": 2,
//                                   "tripId": UserPreferences.tripId,
//                                   "roadName": data.address,
//                                   "getMaxSpeed": "true",
//                                   "coordinates": [
//                                     {
//                                       "lat": tripsDetails.getUpdated!['latitude'].toString(),
//                                       "lng": tripsDetails.getUpdated!['longitude'].toString(),
//                                       "distance": tripsDetails.getUpdated!['distance'],
//                                       "speed": tripsDetails.getUpdated!['speed'],
//                                       "timestamp":DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())
//                                     },
//                                   ]
//                                 };
//                                 print("End trip req body is ${reqBody}");
//                                 GeneralResponse response=await AppUrl.apiService.progresstrip(reqBody);
//                                 print("Response of end trip is ${response.toJson()}");
//                                 if(response.error == 0){
//                                   TopFunctions.showToast("${response.message}");
//
//                                   Future.delayed(Duration(seconds: 2),(){
//                                     print("After 3 seconds pop");
//                                     mapController.dispose();
//                                     TopVariables.service.invoke('stopService');
//                                     print("background service has been stopped");
//                                     // UserPreferences.removePrefs('VehicleDetails');
//                                     UserPreferences.removePrefs('tripId');
//                                     print("trip Id has been removed");
//                                     Navigator.pop(context);
//                                   });
//
//                                 }
//
//                               }
//                               catch(e){
//                                 print("Exception trip is ${e}");
//
//                               }
//
//
//
//
//                             },
//
//                           )
//
//
//                           ,
//                         )
//
//
//
//                       ],
//                     );
//
//
//                   }
//                   else{
//                     child=Center(
//                       child: CircularProgressIndicator(
//                         color: CustomColor.primary,
//                       ),
//                     );
//
//                   }
//
//                   ;
//                   return child;
//                 }
//             ),
//
//           ]
//       ),
//     );
//   }
//
//
// //
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     tripProvider = Provider.of<TripProvider>(context);
// //     Size size=MediaQuery.of(context).size;
// //     return Scaffold(
// //       appBar: AppBarWidget.getAppBar("Start Trip"),
// //       // body:Consumer<TripProvider>(
// //       //     builder:(context, trip, child){
// //       //       child=Text("GCC TRIP ${trip.GCC} ${G_ACCValue}",style: TextStyle(fontSize: 40),);
// //       //       return child;
// //       //     }
// //       // ),
// // body:
// //       Stack(
// //         children: [
// //           FutureBuilder<LocationData?>(
// //               future: CurrentLocation().getCurrentLocation(),
// //               builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat){
// //
// //                 if(snapchat.hasData){
// //                   final  LocationData currentLocation = snapchat.data;
// //                   return Stack(
// //                     children: [
// //
// //                       GoogleMap(
// //                           markers: _markers,
// //                           myLocationEnabled: true,
// //                           onMapCreated: (GoogleMapController googleController) async{
// //                             mapController=googleController;
// //
// //                             BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
// //                               ImageConfiguration(),
// //                               "assets/carimage.png",
// //                             );
// //                             //  locationData = await location.getLocation();
// //                             //
// //                             // location.onLocationChanged.listen((event) async {
// //                             //   GeoData data = await Geocoder2.getDataFromCoordinates(
// //                             //       latitude: event.latitude!,
// //                             //       longitude: event.longitude!,
// //                             //       googleMapApiKey: "${AppUrl.google_api}");
// //                             //   if(this.mounted){
// //                             //     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
// //                             //       setState(() {
// //                             //         if(_markers.isNotEmpty){
// //                             //           _markers.clear();
// //                             //         }
// //                             //         else{
// //                             //           _markers.add(Marker(
// //                             //             //add first marker
// //                             //             rotation: event.heading!,
// //                             //             markerId: MarkerId("${LatLng(event.latitude!,event.longitude!)}"),
// //                             //             position: LatLng(event.latitude!,event.longitude!), //position of marker
// //                             //             icon: markerbitmap, //Icon for Marker
// //                             //           ));
// //                             //           getAddress= data.address;
// //                             //         }
// //                             //       });
// //                             //     });
// //                             //
// //                             //   }
// //                             //   mapController.animateCamera(CameraUpdate.newCameraPosition(
// //                             //     CameraPosition(
// //                             //       target: LatLng(event.latitude!, event.longitude!),
// //                             //       zoom: 17,
// //                             //     ),
// //                             //   ));
// //                             // });
// //
// //                           },
// //                           //mapToolbarEnabled: true,
// //                           initialCameraPosition: CameraPosition(
// //                               target: LatLng(currentLocation.latitude!,currentLocation.longitude!),
// //                               // tilt: 50.0,
// //                               zoom: 14
// //                           )
// //                       ),
// //
// //                       //1st section
// //                       Row(
// //                         crossAxisAlignment: CrossAxisAlignment.center,
// //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                         children: [
// //
// //                           Container(
// //                             // alignment: Alignment.topLeft,
// //                             decoration: BoxDecoration(
// //                               borderRadius: BorderRadius.all(Radius.circular(10.0)),
// //                               color: CustomColor.secondary,
// //                             ),
// //
// //                             margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
// //                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
// //
// //                             width: 250,
// //                             height: 70,
// //                             child: Row(
// //                               children: [
// //                                 Image.asset(
// //                                   "assets/roadimage.png",
// //                                   width: 50,
// //                                 ),
// //                                 Container(
// //                                   width: 180,
// //                                   padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
// //                                   child: Text(
// //                                     "${getAddress}  ",
// //                                     style:
// //                                     TextStyle(color: CustomColor.white, fontSize: 12),
// //
// //                                     // maxLines: 20
// //                                     // overflow: TextOverflow.ellipsis,
// //                                     // softWrap: true,
// //                                   ),
// //                                 )
// //                               ],
// //                             ),
// //
// //                             // child: ElevatedButton.icon(
// //                             //     label:Text("Road trip"),
// //                             //     icon: Image.asset("assets/roadimage.png", width: 50,),
// //                             //     style: ButtonStyle(
// //                             //         backgroundColor: MaterialStateProperty.all(CustomColor.secondary),
// //                             //         foregroundColor: MaterialStateProperty.all(CustomColor.white),
// //                             //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
// //                             //             RoundedRectangleBorder(
// //                             //               // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
// //                             //                 borderRadius: BorderRadius.circular(10.0)))
// //                             //
// //                             //     ),
// //                             //     onPressed: null),
// //                           ),
// //                           Container(
// //                             margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
// //                             padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
// //                             child: Container(
// //                                 width: 60,
// //                                 height: 60,
// //                                 decoration: BoxDecoration(
// //                                     color: Colors.white,
// //                                     shape: BoxShape.circle,
// //                                     border: Border.all(color: Colors.red, width: 4)),
// //                                 child: Container(
// //                                     alignment: Alignment.center,
// //                                     child: Text(
// //                                       "${maxSpeedvalue}",
// //                                       style: TextStyle(
// //                                           color: CustomColor.primary,
// //                                           fontWeight: FontWeight.bold,
// //                                           fontSize: 18),
// //                                     ))),
// //                           )
// //                         ],
// //                       ),
// //                       //2nd section
// //
// //                       Positioned(
// //                         bottom: 130,
// //                         left: 5,
// //                         right: 5,
// //                         child: Container(
// //                           child: Row(
// //                             children: [
// //                               Container(
// //                                   padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
// //                                   alignment: Alignment.center,
// //                                   child: Column(
// //                                     crossAxisAlignment: CrossAxisAlignment.center,
// //                                     children: [
// //                                       //driver
// //                                       Container(
// //                                         //width: 200,
// //                                         child: Text(
// //                                           "Idle time: ${UserPreferences.idleTime}",
// //                                           style: TextStyle(
// //                                               fontWeight: FontWeight.w500,
// //                                               color: CustomColor.primary),
// //                                         ),
// //                                       ),
// //                                       Container(
// //
// //                                         // color: Colors.orange,
// //                                         //width: 200,
// //                                         child: Text(
// //                                           "Angle ${headingAngle.round()} deg",
// //                                           style: TextStyle(
// //                                               fontWeight: FontWeight.w500,
// //                                               color: CustomColor.primary),
// //                                         ),
// //                                       ),
// //                                       //started at
// //                                     ],
// //                                   )),
// //                               Spacer(),
// //                               //image
// //                               Container(
// //                                   child: Column(
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //                                       //driver
// //                                       Container(
// //
// //                                         padding: EdgeInsets.only(bottom: 5),
// //                                         //width: 200,
// //                                         child: Stack(
// //                                           children: [
// //                                             Image.asset(
// //                                               "assets/speedmeter.png",
// //                                               height: 130,
// //                                               fit: BoxFit.contain,
// //                                             ),
// //                                             Positioned(
// //                                                 top: 15,
// //                                                 bottom: 15,
// //                                                 left: 10,
// //                                                 right: 10,
// //                                                 child: Container(
// //                                                   alignment: Alignment.center,
// //                                                   child: Text(
// //                                                     "${speed.toStringAsFixed(0)}",
// //                                                     style: TextStyle(
// //                                                       fontWeight: FontWeight.bold,
// //                                                       fontSize: 18,
// //                                                     ),
// //                                                   ),
// //                                                 ))
// //                                           ],
// //                                         ),
// //                                       ),
// //                                       //started at
// //                                     ],
// //                                   )),
// //                               Spacer(),
// //                               //angle text
// //                               Container(
// //                                   padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
// //                                   child: Column(
// //                                     crossAxisAlignment: CrossAxisAlignment.start,
// //                                     children: [
// //                                       //angle
// //                                       Container(
// //                                         // color: Colors.orange,
// //                                         //width: 200,
// //                                         child: Text(
// //                                           "Angle ${headingAngle.round()} deg ",
// //                                           style: TextStyle(
// //                                               fontWeight: FontWeight.w500,
// //                                               color: CustomColor.primary),
// //                                         ),
// //                                       ),
// //                                       //gcc
// //                                       Container(
// //                                         // color: Colors.orange,
// //                                         //width: 200,
// //                                         child: Text(
// //                                           "G-Acc:  ${G_ACCValue.toStringAsFixed(2)}",
// //                                           style: TextStyle(
// //                                               fontWeight: FontWeight.w500,
// //                                               color: CustomColor.primary),
// //                                         ),
// //                                       ),
// //                                     ],
// //                                   )),
// //                             ],
// //                           ),
// //                         ),
// //                       ),
// //
// //                       //3rd section
// //
// //
// //              Container(
// //                child:    Consumer<TripProvider>(
// //                    builder:(context, trip, child){
// //                      if(trip.updated.isEmpty){
// //                        child=Text("empty ${trip.updated} ",style: TextStyle(fontSize: 40),);
// //
// //                      }
// //                      child=Text("all ${trip.updated} ",style: TextStyle(fontSize: 40),);
// //                      return child;
// //                    }
// //                ),
// //              ),
// //                       // Positioned(
// //                       //     bottom: 60,
// //                       //     child:
// //                       //     Container(
// //                       //       padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
// //                       //       width: size.width * 1,
// //                       //       //alignment: Alignment.bottomCenter,
// //                       //       // height: 100,
// //                       //       decoration: boxDecoration(CustomColor.white),
// //                       //       child: Row(
// //                       //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       //         children: [
// //                       //           Flexible(
// //                       //               flex:1,
// //                       //               fit: FlexFit.tight,
// //                       //               child: Container(
// //                       //                   padding: EdgeInsets.only(right: 5.0),
// //                       //
// //                       //                   decoration: BoxDecoration(
// //                       //                       border: Border(
// //                       //                         right: BorderSide(
// //                       //                           color: CustomColor.backgroundColor,
// //                       //                           width: 2,
// //                       //                         ),
// //                       //                       )
// //                       //                   ),
// //                       //                   child: Column(
// //                       //                     children: [
// //                       //                       Row(
// //                       //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       //                         children: [
// //                       //                           Text(
// //                       //                             "Driver",
// //                       //                             style: TextStyle(
// //                       //                                 fontSize: 12,
// //                       //                                 color: Colors.black,
// //                       //                                 fontWeight: FontWeight.bold),
// //                       //                           ),
// //                       //                           Text(
// //                       //                             "${UserPreferences.get_Login()['name']}",
// //                       //                             style: TextStyle(
// //                       //                               fontSize: 12,
// //                       //                               color: Colors.black,),
// //                       //                           ),
// //                       //
// //                       //
// //                       //                         ],
// //                       //                       ),
// //                       //                       SizedBox(height: 5,),
// //                       //                       Row(
// //                       //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       //                         children: [
// //                       //                           Text(
// //                       //                             "Started At",
// //                       //                             style: TextStyle(
// //                       //                                 fontSize: 12,
// //                       //                                 color: Colors.black,
// //                       //                                 fontWeight: FontWeight.bold),
// //                       //                           ),
// //                       //                           Text(
// //                       //                             "${UserPreferences.getVehicleDetails()['dateTime']}",
// //                       //                             style: TextStyle(
// //                       //                               fontSize: 12,
// //                       //                               color: Colors.black,
// //                       //                             ),
// //                       //                           ),
// //                       //                         ],
// //                       //                       ),
// //                       //                       SizedBox(height: 5,),
// //                       //                       Row(
// //                       //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       //                         children: [
// //                       //                           Text(
// //                       //                             "Duration",
// //                       //                             style: TextStyle(
// //                       //                                 fontSize: 12,
// //                       //                                 color: Colors.black,
// //                       //                                 fontWeight: FontWeight.bold),
// //                       //                           ),
// //                       //                           Text(
// //                       //                             "${UserPreferences.Tripduration.toString()+"min"}",
// //                       //                             style: TextStyle(
// //                       //                               fontSize: 12,
// //                       //                               color: Colors.black,
// //                       //                             ),
// //                       //                           ),
// //                       //                         ],
// //                       //                       ),
// //                       //                     ],
// //                       //                   )
// //                       //               )
// //                       //           ),
// //                       //
// //                       //           Flexible(
// //                       //               flex:1,
// //                       //               fit: FlexFit.tight,
// //                       //               child: Container(
// //                       //                   padding: EdgeInsets.only(left: 5.0),
// //                       //
// //                       //                   child: Column(
// //                       //                     children: [
// //                       //                       Row(
// //                       //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       //                         children: [
// //                       //                           Text(
// //                       //                             "VRN ",
// //                       //                             style: TextStyle(
// //                       //                                 fontSize: 12,
// //                       //                                 color: Colors.black,
// //                       //                                 fontWeight: FontWeight.bold),
// //                       //                           ),
// //                       //                           Text(
// //                       //                             "${UserPreferences.getVehicleDetails()['vrn']}",
// //                       //                             style: TextStyle(
// //                       //                               fontSize: 12,
// //                       //                               color: Colors.black,
// //                       //                             ),
// //                       //                           ),
// //                       //
// //                       //
// //                       //                         ],
// //                       //                       ),
// //                       //                       SizedBox(height: 5,),
// //                       //                       Row(
// //                       //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       //                         children: [
// //                       //                           Text(
// //                       //                             "Started From",
// //                       //                             style: TextStyle(
// //                       //                                 fontSize: 12,
// //                       //                                 color: Colors.black,
// //                       //                                 fontWeight: FontWeight.bold),
// //                       //                           ),
// //                       //
// //                       //                           Text("${ UserPreferences.getVehicleDetails()['startedFrom'].toString().length > 12 ? UserPreferences.getVehicleDetails()['startedFrom'].toString().substring(0,12):UserPreferences.getVehicleDetails()['startedFrom'] }",
// //                       //                             style: TextStyle(
// //                       //                               fontSize: 12,
// //                       //                               color: Colors.black,
// //                       //                             ),
// //                       //                           ),
// //                       //
// //                       //                         ],
// //                       //                       ),
// //                       //                       SizedBox(height: 5,),
// //                       //                       Row(
// //                       //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                       //                         children: [
// //                       //                           Text(
// //                       //                             "Distance",
// //                       //                             style: TextStyle(
// //                       //                                 fontSize: 12,
// //                       //                                 color: Colors.black,
// //                       //                                 fontWeight: FontWeight.bold),
// //                       //                           ),
// //                       //                           //not dialog
// //                       //                           //(distanceValue[0]!.abs() * 0.000621371).toStringAsFixed(2).toString()
// //                       //                           Text(
// //                       //                             "${(distance * 0.621371).toStringAsFixed(2)} miles",
// //                       //                             style: TextStyle(
// //                       //                               fontSize: 12,
// //                       //                               color: Colors.black,
// //                       //                             ),
// //                       //                           )
// //                       //                         ],
// //                       //                       ),
// //                       //                     ],
// //                       //                   )
// //                       //               )
// //                       //           ),
// //                       //
// //                       //         ],
// //                       //       ),
// //                       //       //  alignment: Alignment.bottomCenter,
// //                       //     ))
// //
// //
// //
// //                       Container(
// //                         width: size.width * 1,
// //                         alignment: Alignment.bottomCenter,
// //                         padding: EdgeInsets.symmetric(horizontal: 10.0),
// //                         child:     SliderButton(
// //                           label: Text(
// //                             "Slide to Complete Trip",
// //                             textAlign: TextAlign.center,
// //                             style: TextStyle(
// //                                 color: Colors.white, fontSize: 14),
// //                           ),
// //                           icon: Image.asset("assets/SOSIcon.png"),
// //                           buttonColor: CustomColor.white,
// //                           buttonSize: 40.0,
// //                           shimmer:false,
// //                           width: size.width * 0.9,
// //                           height: size.width * 0.12,
// //                           alignLabel: Alignment.center,
// //                           backgroundColor: CustomColor.subBtn,
// //                           vibrationFlag: true,
// //                           dismissible: isTripdismiss,
// //                           action: () async {
// //                             setState(() {
// //                               isTripdismiss=!isTripdismiss;
// //
// //                             });
// //                             print("end trip ${UserPreferences.tripId} ${isTripdismiss}");
// //                             print("trip details is  ${UserPreferences.tripId} ${isTripdismiss}");
// //
// //
// //                             try{
// //                               print("trip is ${UserPreferences.tripId}");
// //                               GeoData data = await Geocoder2.getDataFromCoordinates(
// //                                   latitude: currentLocation.latitude!,
// //                                   longitude: currentLocation.longitude!,
// //                                   googleMapApiKey:  "${AppUrl.google_api}");
// //                               final reqBody={
// //                                 "organisation_id": UserPreferences.OrganizationId,
// //                                 "status": 2,
// //                                 "tripId": UserPreferences.tripId,
// //                                 "roadName": data.address,
// //                                 "getMaxSpeed": "true",
// //                                 "coordinates": [
// //                                   {
// //                                     "lat": currentLocation.latitude!.toString(),
// //                                     "lng": currentLocation.longitude!.toString(),
// //                                     "distance": distance,
// //                                     "speed": speed,
// //                                     "timestamp":DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())
// //                                   },
// //                                 ]
// //                               };
// //                               print("End trip req body is ${reqBody}");
// //                               GeneralResponse response=await AppUrl.apiService.progresstrip(reqBody);
// //                               print("Response of end trip is ${response.toJson()}");
// //                               if(response.error == 0){
// //                                 TopFunctions.showToast("${response.message}");
// //
// //                                 Future.delayed(Duration(seconds: 1),(){
// //                                   UserPreferences.removePrefs('VehicleDetails');
// //                                   UserPreferences.removePrefs('tripId');
// //                                   UserPreferences.removePrefs('Tripduration');
// //                                   UserPreferences.removePrefs('idleTime');
// //                                   TopVariables.service.invoke('stopService');
// //                                   mapController.dispose();
// //                                   Navigator.pop(context);
// //                                 });
// //
// //                               }
// //
// //                             }
// //                             catch(e){
// //                               print("Exception trip is ${e}");
// //
// //                             }
// //
// //
// //
// //
// //                           },
// //
// //                         )
// //
// //
// //                         ,
// //                       )
// //                     ],
// //                   );
// //                 }
// //                 return Center(
// //                   child: CircularProgressIndicator(
// //                     color: CustomColor.primary,
// //                   ),
// //                 );
// //
// //               }
// //           ),
// //
// //
// //
// //
// //         ],
// //       ),
// //     );
// //
// //   }
// }
//
