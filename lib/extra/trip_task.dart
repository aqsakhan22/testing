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
// import 'package:novus_guard_pro_flutter/theme/color.dart';
// import 'package:novus_guard_pro_flutter/utility/current_location.dart';
// import 'package:novus_guard_pro_flutter/utility/shared_preference.dart';
// import 'package:novus_guard_pro_flutter/utility/top_level_variables.dart';
// import 'package:novus_guard_pro_flutter/widgets/app_bar.dart';
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
//   Location location = Location();
//   late LocationData locationData;
//   String getAddress="Address Finding...";
//   String maxSpeedvalue = "0";
//   int counter = 0;
//   double headingAngle=0.0;
//   double vehicleSpeed=0.0;
//   double G_ACCValue=0.0;
//   List<double?> distanceValue = [0.0, 0.0];
//   bool isTripdismiss=false;
//   Timer? timer;
//   // Future<Uint8List> getBytesFromAsset(String path, int width) async {
//   //   ByteData data = await rootBundle.load(path);
//   //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//   //       targetWidth: width);
//   //   ui.FrameInfo fi = await codec.getNextFrame();
//   //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//   //       .buffer
//   //       .asUint8List();
//   // }
//
//   void dispose() {
//     // TODO: implement initState
//     super.dispose();
//     timer!.cancel();
//   }
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       timer = Timer.periodic(const Duration(seconds: 5), (_) => progressUpdate());
//
//     });
//   }
//   void progressTrip(String address, double lat, double lng, double distance, double speed) async {
//     print("progressTrip in googgle ${address} ${lat} ${lng} ${distance} ${speed}");
//
//     print("progress trip in google distance ${distance} ");
//
//     Map<String, dynamic> reqBody = {
//       "organisation_id": UserPreferences.OrganizationId,
//       "status": 1,
//       "tripId": UserPreferences.tripId,
//       "roadName": "${address}",
//       "getMaxSpeed": "1",
//       // "getMaxSpeed": "true",
//       "coordinates": [
//         {"lat": lat, "lng": lng, "distance": distance, "speed": speed}
//       ]
//     };
//
//     print("progress trip id req body fore${reqBody}");
//
//     if(UserPreferences.tripId.isNotEmpty){
//       try {
//         final progressResponse = await AppUrl.apiService.progresstrip(reqBody);
//
//
//         print("progress trip api in google map data  ${progressResponse.data!}");
//         print("progress trip api in google error ${progressResponse.error}");
//         if (progressResponse.data!['maxspeed'] == null) {
//           if (this.mounted) {
//             setState(() {
//               // Your state change code goes here
//               setState(() {
//                 maxSpeedvalue = "0";
//               });
//
//             });
//           }
//         } else {
//           if (this.mounted) {
//             setState(() {
//               // Your state change code goes here
//               setState(() {
//                 maxSpeedvalue = progressResponse.data!['maxspeed'].toString();
//               });
//             });
//           }
//         }
//       } catch (err) {
//         (err.toString());
//       }
//     }
//   }
//   progressUpdate() async{
//     print("Prigress Uopdate is runing");
//     CurrentLocation().getCurrentLocation().then((value) async{
//       GeoData data = await Geocoder2.getDataFromCoordinates(
//           latitude: value!.latitude!,
//           longitude: value.longitude!,
//           googleMapApiKey: "${AppUrl.google_api}");
//       print("Progress Update is ${value.speed}");
//       if(value.speed! >= 0 && value.speed! <= 1 ){
//         print("speed is less than zero");
//         if (this.mounted) {
//           setState(() {
//             counter += 1;
//             headingAngle = value.heading!;
//           });
//         }
//
//       }
//
//       if(value.speed! > 1 ){
//         vehicleSpeed = value.speed! * 3.6 ; //this speed in merters per seconds convert into km got hitting in Api
//         print("vehicle szpeed in km/hr ${vehicleSpeed} speed in m/s ${value.speed} Speed is  greater than 1");
//         List distanceSpeeed = calculateDistanceSpeed(value.latitude!, value.longitude!, vehicleSpeed);
//         print("distanceSpeeed in google map ${distanceSpeeed}");
//         setState(() {
//           getAddress=data.address;
//         });
//         print("Address is ${getAddress}");
//         if (UserPreferences.tripId.isNotEmpty) {
//           print("Progress Trip Api is calling");
//
//           progressTrip(data.address, value.latitude!, value.longitude!, distanceSpeeed[0], distanceSpeeed[1]);
//         }
//       }
//
//
//     });
//
//   }
//
//   List calculateDistanceSpeed(double lat, double lng, double speed) {
//     print("calculate speed function called ${lat} ${lng} ${speed}");
//     int tripLocationLength = prefs.getString("triplocations") == null ? 0 : UserPreferences.getTripLocations().length;
//
//     if (tripLocationLength == 0) {
//       print("trip length is == 0");
//       setState(() {
//         distanceValue = [0.0, 0.0]; // [0] speed [1] distance
//       });
//     } else {
//       print("trip length is != 0");
//       Map<String, dynamic> lastIndexData = UserPreferences.getTripLocations()[tripLocationLength - 1];
//
//       var distanceData = getDistanceFromLatLonInKm(lastIndexData['lat'], lastIndexData['lng'], lat, lng);
//       print("distance data is ${distanceData}");
//       var speedData = getGAcceleration(lastIndexData['speed'], speed);
//       if (this.mounted) {
//         setState(() {
//           // Your state change code goes here
//           G_ACCValue = speedData;
//           distanceValue = [lastIndexData['distance'] + distanceData, speedData];
//           print("value of distanceValue is ${distanceValue}");
//         });
//       }
//       print("GCC in google map is  ${G_ACCValue}");
//       print("distanceData in google map  ${distanceData}");
//       print("distance and speed is distance   ${distanceValue[0]} speed  ${distanceValue[1]}");
//     }
//
//     List<dynamic> encodestringListData = [];
//     if (tripLocationLength == 0) {
//       print("tripLocationLength == 0 encodestringListData ");
//       encodestringListData.add({"lat": lat, "lng": lng, "speed": speed, "distance": 0.0});
//       UserPreferences.setTripLocations(encodestringListData);
//     } else {
//       print("tripLocationLength != 0 encodestringListData ");
//       print("DATA FROM LOCAL UserPreferences.getripLocations() ${UserPreferences.getTripLocations()} ");
//       if( UserPreferences.getTripLocations().length > 5){
//         UserPreferences.getTripLocations().removeRange(0, UserPreferences.getTripLocations().length - 1);
//       }
//
//       print("${(UserPreferences.getTripLocations() as List<dynamic>).map((e) {
//         encodestringListData.add(e);
//         encodestringListData.add({"lat": lat, "lng": lng, "speed": speed, "distance": distanceValue[0]});
//         UserPreferences.setTripLocations(encodestringListData);
//       })}");
//     }
//     print("distanceValue in return ${distanceValue}");
//     return distanceValue;
//   }
//   double getGAcceleration(startspeed, endSpeed) {
//     double num = endSpeed - startspeed;
//     double den = 5 * 9.80665; //
//     double g_acceleration = num / den;
//     print("G-Acceleration: ${g_acceleration.abs()}");
//     return g_acceleration;
//   }
//   double deg2rad(deg) {
//     return deg * (pi / 180);
//   }
//
//   double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
//     // var R = 6371; // Radius of the earth in km
//     // var dLat = deg2rad(lat2 - lat1); // deg2rad below
//     // var dLon = deg2rad(lon2 - lon1);
//     // var a = sin(dLat / 2) * sin(dLat / 2) + cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
//     // var c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     // var d = R * c;
//     // return d;//KM
//     var p = 0.017453292519943295;
//     var a = 0.5 - cos((lat2 - lat1) * p)/2 +
//         cos(lat1 * p) * cos(lat2 * p) *
//             (1 - cos((lon2 - lon1) * p))/2;
//     print("distaNCE VALUE IS IN km ${12742 * asin(sqrt(a))} in miles ${12742 * asin(sqrt(a)) * 0.621371 } ");
//     return  12742 * asin(sqrt(a));
//   }
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     Size size=MediaQuery.of(context).size;
//     return Scaffold(
//       appBar: AppBarWidget.getAppBar("Start Trip"),
//       body: Stack(
//         children: [
//           FutureBuilder<LocationData?>(
//               future: CurrentLocation().getCurrentLocation(),
//               builder: (BuildContext context, AsyncSnapshot<dynamic> snapchat){
//
//                 if(snapchat.hasData){
//                   final  LocationData currentLocation = snapchat.data;
//                   return Stack(
//                     children: [
//                       GoogleMap(
//                           markers: _markers,
//                           myLocationEnabled: true,
//                           onMapCreated: (GoogleMapController googleController) async{
//                             mapController=googleController;
//
//                             BitmapDescriptor markerbitmap = await BitmapDescriptor.fromAssetImage(
//                               ImageConfiguration(),
//                               "assets/carimage.png",
//                             );
//                             locationData = await location.getLocation();
//
//                             location.onLocationChanged.listen((event) async {
//                               GeoData data = await Geocoder2.getDataFromCoordinates(
//                                   latitude: event.latitude!,
//                                   longitude: event.longitude!,
//                                   googleMapApiKey: "${AppUrl.google_api}");
//                               if(this.mounted){
//                                 WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
//                                   setState(() {
//                                     if(_markers.isNotEmpty){
//                                       _markers.clear();
//                                     }
//                                     else{
//                                       _markers.add(Marker(
//                                         //add first marker
//                                         rotation: event.heading!,
//                                         markerId: MarkerId("${LatLng(event.latitude!,event.longitude!)}"),
//                                         position: LatLng(event.latitude!,event.longitude!), //position of marker
//                                         // infoWindow: InfoWindow( //popup info
//                                         //   title: 'My Custom Title ',
//                                         //   snippet: 'My Custom Subtitle',
//                                         // ),
//                                         icon: markerbitmap, //Icon for Marker
//                                       ));
//                                       getAddress= data.address;
//                                     }
//                                   });
//                                 });
//
//                               }
//                               mapController.animateCamera(CameraUpdate.newCameraPosition(
//                                 CameraPosition(
//                                   target: LatLng(event.latitude!, event.longitude!),
//                                   zoom: 17,
//                                 ),
//                               ));
//                             });
//
//                           },
//                           //mapToolbarEnabled: true,
//                           initialCameraPosition: CameraPosition(
//                               target: LatLng(currentLocation.latitude!,currentLocation.longitude!),
//                               // tilt: 50.0,
//                               zoom: 14
//                           )
//                       ),
//                       //1st section
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Container(
//                             // alignment: Alignment.topLeft,
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                               color: CustomColor.secondary,
//                             ),
//
//                             margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
//                             padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//
//                             width: 250,
//                             height: 70,
//                             child: Row(
//                               children: [
//                                 Image.asset(
//                                   "assets/roadimage.png",
//                                   width: 50,
//                                 ),
//                                 Container(
//                                   width: 180,
//                                   padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
//                                   child: Text(
//                                     "${getAddress}  ",
//                                     style:
//                                     TextStyle(color: CustomColor.white, fontSize: 12),
//
//                                     // maxLines: 20
//                                     // overflow: TextOverflow.ellipsis,
//                                     // softWrap: true,
//                                   ),
//                                 )
//                               ],
//                             ),
//
//                             // child: ElevatedButton.icon(
//                             //     label:Text("Road trip"),
//                             //     icon: Image.asset("assets/roadimage.png", width: 50,),
//                             //     style: ButtonStyle(
//                             //         backgroundColor: MaterialStateProperty.all(CustomColor.secondary),
//                             //         foregroundColor: MaterialStateProperty.all(CustomColor.white),
//                             //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                             //             RoundedRectangleBorder(
//                             //               // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                             //                 borderRadius: BorderRadius.circular(10.0)))
//                             //
//                             //     ),
//                             //     onPressed: null),
//                           ),
//                           Container(
//                             margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
//                             padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
//                             child: Container(
//                                 width: 60,
//                                 height: 60,
//                                 decoration: BoxDecoration(
//                                     color: Colors.white,
//                                     shape: BoxShape.circle,
//                                     border: Border.all(color: Colors.red, width: 4)),
//                                 child: Container(
//                                     alignment: Alignment.center,
//                                     child: Text(
//                                       "${maxSpeedvalue}",
//                                       style: TextStyle(
//                                           color: CustomColor.primary,
//                                           fontWeight: FontWeight.bold,
//                                           fontSize: 18),
//                                     ))),
//                           )
//                         ],
//                       ),
//                       //2nd section
//
//                       Positioned(
//                         bottom: 130,
//                         left: 5,
//                         right: 5,
//                         child: Container(
//                           child: Row(
//                             children: [
//                               Container(
//                                   padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
//                                   alignment: Alignment.center,
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.center,
//                                     children: [
//                                       //driver
//                                       Container(
//                                         //width: 200,
//                                         child: Text(
//                                           "Idle time: ${counter}",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               color: CustomColor.primary),
//                                         ),
//                                       ),
//                                       Container(
//
//                                         // color: Colors.orange,
//                                         //width: 200,
//                                         child: Text(
//                                           "Angle ${headingAngle.round()} deg",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               color: CustomColor.primary),
//                                         ),
//                                       ),
//                                       //started at
//                                     ],
//                                   )),
//                               Spacer(),
//                               //image
//                               Container(
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       //driver
//                                       Container(
//
//                                         padding: EdgeInsets.only(bottom: 5),
//                                         //width: 200,
//                                         child: Stack(
//                                           children: [
//                                             Image.asset(
//                                               "assets/speedmeter.png",
//                                               height: 130,
//                                               fit: BoxFit.contain,
//                                             ),
//                                             Positioned(
//                                                 top: 15,
//                                                 bottom: 15,
//                                                 left: 10,
//                                                 right: 10,
//                                                 child: Container(
//                                                   alignment: Alignment.center,
//                                                   child: Text(
//                                                     "${vehicleSpeed.toStringAsFixed(0)}",
//                                                     style: TextStyle(
//                                                       fontWeight: FontWeight.bold,
//                                                       fontSize: 18,
//                                                     ),
//                                                   ),
//                                                 ))
//                                           ],
//                                         ),
//                                       ),
//                                       //started at
//                                     ],
//                                   )),
//                               Spacer(),
//                               //angle text
//                               Container(
//                                   padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
//                                   child: Column(
//                                     crossAxisAlignment: CrossAxisAlignment.start,
//                                     children: [
//                                       //angle
//                                       Container(
//                                         // color: Colors.orange,
//                                         //width: 200,
//                                         child: Text(
//                                           "Angle ${headingAngle == null ? "0deg" : headingAngle.round()} deg ",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               color: CustomColor.primary),
//                                         ),
//                                       ),
//                                       //gcc
//                                       Container(
//                                         // color: Colors.orange,
//                                         //width: 200,
//                                         child: Text(
//                                           "G-Acc:  ${G_ACCValue.toStringAsFixed(2)}",
//                                           style: TextStyle(
//                                               fontWeight: FontWeight.w500,
//                                               color: CustomColor.primary),
//                                         ),
//                                       ),
//                                     ],
//                                   )),
//                             ],
//                           ),
//                         ),
//                       ),
//
//                       //3rd section
//
//
//
//                       Positioned(
//                           bottom: 60,
//                           child:
//                           Container(
//                             padding: EdgeInsets.symmetric(horizontal: 10.0,vertical: 10.0),
//                             width: size.width * 1,
//                             //alignment: Alignment.bottomCenter,
//                             // height: 100,
//                             decoration: boxDecoration(CustomColor.white),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                               children: [
//                                 Flexible(
//                                     flex:1,
//                                     fit: FlexFit.tight,
//                                     child: Container(
//                                         padding: EdgeInsets.only(right: 5.0),
//
//                                         decoration: BoxDecoration(
//                                             border: Border(
//                                               right: BorderSide(
//                                                 color: CustomColor.backgroundColor,
//                                                 width: 2,
//                                               ),
//                                             )
//                                         ),
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Driver",
//                                                   style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                       fontWeight: FontWeight.bold),
//                                                 ),
//                                                 Text(
//                                                   "${UserPreferences.get_Login()['name']}",
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.black,),
//                                                 ),
//
//
//                                               ],
//                                             ),
//                                             SizedBox(height: 5,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Started At",
//                                                   style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                       fontWeight: FontWeight.bold),
//                                                 ),
//                                                 Text(
//                                                   "${UserPreferences.getVehicleDetails()['dateTime']}",
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                             SizedBox(height: 5,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Duration",
//                                                   style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                       fontWeight: FontWeight.bold),
//                                                 ),
//                                                 Text(
//                                                   "${UserPreferences().getDurationTrip().isEmpty ? "0 min" : UserPreferences().getDurationTrip() + " " + "min"}",
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         )
//                                     )
//                                 ),
//
//                                 Flexible(
//                                     flex:1,
//                                     fit: FlexFit.tight,
//                                     child: Container(
//                                         padding: EdgeInsets.only(left: 5.0),
//
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "VRN ",
//                                                   style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                       fontWeight: FontWeight.bold),
//                                                 ),
//                                                 Text(
//                                                   "${UserPreferences.getVehicleDetails()['vrn']}",
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//
//
//                                               ],
//                                             ),
//                                             SizedBox(height: 5,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Started From",
//                                                   style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                       fontWeight: FontWeight.bold),
//                                                 ),
//
//                                                 Text(
//
//                                                   "${UserPreferences.getVehicleDetails()['startedFrom'].toString().substring(0,12)}",
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.black,
//                                                   ),
//                                                 ),
//
//                                               ],
//                                             ),
//                                             SizedBox(height: 5,),
//                                             Row(
//                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                               children: [
//                                                 Text(
//                                                   "Distance",
//                                                   style: TextStyle(
//                                                       fontSize: 12,
//                                                       color: Colors.black,
//                                                       fontWeight: FontWeight.bold),
//                                                 ),
//                                                 //not dialog
//                                                 //(distanceValue[0]!.abs() * 0.000621371).toStringAsFixed(2).toString()
//                                                 Text(
//                                                   "${distanceValue.isEmpty == true ? 0 : (distanceValue[0]!.abs() / 1.6).toStringAsFixed(2).toString()} miles",
//                                                   style: TextStyle(
//                                                     fontSize: 12,
//                                                     color: Colors.black,
//                                                   ),
//                                                 )
//                                               ],
//                                             ),
//                                           ],
//                                         )
//                                     )
//                                 ),
//
//                               ],
//                             ),
//                             //  alignment: Alignment.bottomCenter,
//                           ))
//                       ,
//
//
//                       Container(
//                         width: size.width * 1,
//                         alignment: Alignment.bottomCenter,
//                         padding: EdgeInsets.symmetric(horizontal: 10.0),
//                         child:     SliderButton(
//                           label: Text(
//                             "Slide to Complete Trip",
//                             textAlign: TextAlign.center,
//                             style: TextStyle(
//                                 color: Colors.white, fontSize: 14),
//                           ),
//                           icon: Image.asset("assets/SOSIcon.png"),
//                           buttonColor: CustomColor.white,
//                           buttonSize: 40.0,
//                           shimmer:false,
//                           width: size.width * 0.9,
//                           height: size.width * 0.12,
//                           alignLabel: Alignment.center,
//                           backgroundColor: CustomColor.subBtn,
//                           vibrationFlag: true,
//                           dismissible: isTripdismiss,
//                           action: () async {
//                             setState(() {
//                               isTripdismiss=!isTripdismiss;
//
//                             });
//                             print("end trip ${UserPreferences.tripId} ${isTripdismiss}");
//                             print("trip details is  ${UserPreferences.tripId} ${isTripdismiss}");
//
//
//                             try{
//                               print("trip is ${UserPreferences.tripId}");
//                               GeoData data = await Geocoder2.getDataFromCoordinates(
//                                   latitude: currentLocation.latitude!,
//                                   longitude: currentLocation.longitude!,
//                                   googleMapApiKey:  "${AppUrl.google_api}");
//                               final reqBody={
//                                 "organisation_id": UserPreferences.OrganizationId,
//                                 "status": 2,
//                                 "tripId": UserPreferences.tripId,
//                                 "roadName": data.address,
//                                 "getMaxSpeed": "true",
//                                 "coordinates": [
//                                   {
//                                     "lat": currentLocation.latitude!.toString(),
//                                     "lng": currentLocation.longitude!.toString(),
//                                     "distance": distanceValue[0],
//                                     "speed": distanceValue[1],
//                                     "timestamp":DateFormat('yyyy-MM-dd hh:mm:ss').format(DateTime.now())
//                                   },
//                                 ]
//                               };
//                               print("End trip req body is ${reqBody}");
//                               GeneralResponse response=await AppUrl.apiService.progresstrip(reqBody);
//                               print("Response of end trip is ${response.toJson()}");
//                               if(response.error == 0){
//                                 TopFunctions.showToast("${response.message}");
//                                 UserPreferences.removePrefs('VehicleDetails');
//                                 UserPreferences.removePrefs('tripId');
//                                 Navigator.pop(context);
//                               }
//
//                             }
//                             catch(e){
//                               print("Exception trip is ${e}");
//
//                             }
//
//
//
//
//                           },
//
//                         )
//
//
//                         ,
//                       )
//                     ],
//                   );
//                 }
//                 return Center(
//                   child: CircularProgressIndicator(
//                     color: CustomColor.primary,
//                   ),
//                 );
//
//               }
//           ),
//
//
//
//         ],
//       ),
//     );
//
//   }
// }
