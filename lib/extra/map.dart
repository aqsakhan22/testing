// import 'dart:async';
// import 'dart:math';
// import 'dart:typed_data';
// import 'dart:ui' as ui;
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:geocoder2/geocoder2.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:intl/intl.dart';
// import 'package:location/location.dart';
// import 'package:novus_guard_pro_flutter/theme/color.dart';
//
// import 'package:provider/provider.dart';
//
// class GoogleMapIntegrate extends StatefulWidget {
//   final String? vrn;
//   final double? lat;
//   final double? lng;
//   final String? dateTime;
//
//   final int? tripId;
//
//   const GoogleMapIntegrate(
//       {Key? key, this.vrn, this.lat, this.lng, this.dateTime, this.tripId})
//       : super(key: key);
//
//   @override
//   State<GoogleMapIntegrate> createState() => _GoogleMapIntegrateState();
// }
//
// class _GoogleMapIntegrateState extends State<GoogleMapIntegrate> {
//   late GoogleMapController mapController;
//   LatLng _initialPosition = LatLng(24.9517415, 67.1229219);
//   Location location = Location();
//   late LocationData locationData;
//   List<Marker> myMarkers = [];
//   Set<Circle> circle = Set();
//   Timer? timer;
//   double? vehicleSpeed;
//   List<double?> distanceValue = [0.0, 0.0];
//   var getAddress;
//   double? angle;
//   DateTime? currenTime;
//   late DateTime tripstartTime;
//   String? tripDuration;
//   double? G_ACCValue;
//   double? headingAngle;
//   bool isRun = true;
//   String maxSpeedvalue = "0";
//   double accelerationSquare1 = 0.0;
//   int counter = 0;
//
//   Map<String, dynamic> harshCornering = {};
//
// //dashboard provider
//
//
//   void setState(fn) {
//     if (mounted) {
//       super.setState(fn);
//     }
//   }
//
//   Future<void> tripDetails(BuildContext context) async {
//     print("Trips details calling");
//     showDialog<void>(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//               backgroundColor: CustomColor.white,
//               contentPadding: EdgeInsets.zero,
//               // insetPadding: EdgeInsets.all(10.0),
//
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(20),
//               ),
//
//
//
//               content: Container(
//
//                   width: MediaQuery.of(context).size.width * 1,
//                   // height: MediaQuery.of(context).size.height * 0.7,
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       SizedBox(
//                         height: 20,
//                       ),
//                       Text(
//                         "Trip Summary",
//                         style: TextStyle(
//                             color: CustomColor.primary,
//                             fontSize: 16,
//                             fontWeight: FontWeight.bold),
//                       ),
//                       Container(
//                         decoration: const BoxDecoration(
//                           image: DecorationImage(
//                               image: AssetImage("assets/tripbackground.png"),
//                               fit: BoxFit.cover),
//                         ),
//                         child: Column(
//                           children: [
//                             SizedBox(
//                               height: 20,
//                             ),
//                             //trip id
//                             Container(
//                               padding:
//                               EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
//                               child: Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/tripid.png",
//                                     width: 36,
//                                   ),
//                                   SizedBox(
//                                     width: 10,
//                                   ),
//                                   Text("${widget.tripId}",
//                                       style: TextStyle(
//                                           color: CustomColor.primary,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold))
//                                 ],
//                               ),
//                             ),
//                             //trip start time
//                             SizedBox(
//                               height: 20,
//                             ),
//                             //start time
//                             Container(
//                               padding:
//                               EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
//                               child: Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/clock.png",
//                                     width: 36,
//                                   ),
//                                   Text(
//                                       "${UserPreferences().getStarttimeTrip()}",
//                                       style: TextStyle(
//                                           color: CustomColor.primary,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold))
//                                 ],
//                               ),
//                             ),
//                             //Address trip start
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               //   width: 70,
//                               padding:
//                               EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
//                               child: Row(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Image.asset(
//                                     "assets/starttrip.png",
//                                     width: 36,
//                                   ),
//                                   Container(
//                                       width:
//                                       MediaQuery.of(context).size.width *
//                                           0.6,
//                                       child: Text(
//                                           "${UserPreferences().getStartTripaddress()}",
//                                           style: TextStyle(
//                                               color: CustomColor.primary,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold)))
//                                 ],
//                               ),
//                             ),
//                             //trip end date Time
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               padding:
//                               EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
//                               child: Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/clock.png",
//                                     width: 36,
//                                   ),
//                                   Text(
//                                       "${DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()).toString()}",
//                                       style: TextStyle(
//                                           color: CustomColor.primary,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold))
//                                 ],
//                               ),
//                             ),
//                             //end trip address
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               //   width: 70,
//                               padding:
//                               EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
//                               child: Row(
//                                 //  mainAxisAlignment: MainAxisAlignment.start,
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   Image.asset(
//                                     "assets/tripend.png",
//                                     width: 36,
//                                   ),
//                                   Container(
//                                       width:
//                                       MediaQuery.of(context).size.width *
//                                           0.6,
//                                       child: Text("${getAddress}",
//                                           style: TextStyle(
//                                               color: CustomColor.primary,
//                                               fontSize: 14,
//                                               fontWeight: FontWeight.bold)))
//                                 ],
//                               ),
//                             ),
//                             //distance in miles
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               padding:
//                               EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
//                               child: Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/tripdistance.png",
//                                     width: 36,
//                                   ),
//                                   Text(
//                                       "${distanceValue[0] == 0 ? 0 : distanceValue[0]!.toStringAsFixed(2)} miles",
//                                       style: TextStyle(
//                                           color: CustomColor.primary,
//                                           fontSize: 14,
//                                           fontWeight: FontWeight.bold))
//                                 ],
//                               ),
//                             ),
//                             //duration time
//                             SizedBox(
//                               height: 20,
//                             ),
//                             Container(
//                               padding:
//                               EdgeInsets.fromLTRB(20.0, 0.0, 0.0, 0.0),
//                               child: Row(
//                                 children: [
//                                   Image.asset(
//                                     "assets/tripduration.png",
//                                     width: 36,
//                                   ),
//                                   Text(
//                                       "${UserPreferences().getDurationTrip()} min")
//                                 ],
//                               ),
//                             ),
//                             SizedBox(
//                               height: 20,
//                             ),
//                           ],
//                         ),
//                       ),
//                       //Done Button
//                       SizedBox(
//                         height: 10,
//                       ),
//                       Container(
//                         width: MediaQuery.of(context).size.width * 0.7,
//                         height: 50,
//                         child: ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             primary: CustomColor.secondary,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(10.0)),
//                           ),
//                           child: Text("Done"),
//                           onPressed: () {
//                             UserPreferences().removeDurationTrip();
//                             Navigator.pop(context);
//                             Navigator.pop(context);
//                           },
//                         ),
//                       ),
//                       SizedBox(
//                         height: 10,
//                       ),
//                     ],
//                   ))
//
//
//           );
//         });
//   }
//
//   checkTripdata() async {
//     dashboardprovider.getDashboardTrip();
//     dashboardprovider.notifyListeners();
//   }
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print(
//         "google map widget ${widget.vrn} ${widget.tripId} ${widget.lat} ${widget.lng} ${widget.dateTime}");
//     dashboardprovider = Provider.of<DashboardProvider>(context, listen: false);
//     tripstartTime = DateTime.parse(
//         DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
//     WidgetsBinding.instance!.addPostFrameCallback((_) {
//       timer =
//           Timer.periodic(const Duration(seconds: 5), (_) => progressUpdate());
//     });
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement initState
//     timer!.cancel();
//     checkTripdata();
//     // mapController.dispose();
//     super.dispose();
//   }
//
//   // Future<String> getAddressdata(double lat, double lng) async {
//   //   GeoData data = await Geocoder2.getDataFromCoordinates(
//   //       latitude: lat,
//   //       longitude: lng,
//   //       googleMapApiKey: "AIzaSyAVJiRDZsecoVecl0fiq2xHchQdWihXr3k");
//   //   String address = data.address;
//   //   getAddress = data.address;
//   //
//   //   if (this.mounted) {
//   //     setState(() {
//   //       // Your state change code goes here
//   //       getAddress = data.address;
//   //     });
//   //   }
//   //    print("getAddressdata in  getAddressdata ${getAddress}");
//   //   return address;
//   // }
//
//   void progressTrip(String address, double lat, double lng, double distance,
//       double speed) async {
//     print(
//         "progressTrip in googgle ${address} ${lat} ${lng} ${distance} ${speed}");
//
//     print("progress trip in google distance ${distance} ");
//
//     Map<String, dynamic> reqBody = {
//       "organisation_id": ProvidersUtility.userProvider!.user.organizationID,
//       "status": 1,
//       "tripId": widget.tripId,
//       "roadName": "${address}",
//       "getMaxSpeed": "1",
//       // "getMaxSpeed": "true",
//       "coordinates": [
//         {"lat": lat, "lng": lng, "distance": distance, "speed": speed}
//       ]
//     };
//
//     print("progress trip id req body ${reqBody}");
//
//     try {
//       final progressResponse = await AppUrl.apiService
//           .tripProgress(ProvidersUtility.userProvider!.user.token, reqBody);
//       print("response of progress trip in google ${progressResponse.error}");
//
//       print("progress trip api in google map ${progressResponse.data!}");
//       print(
//           "progress trip api in google map response ${progressResponse.message} ${progressResponse.error}");
//       if (progressResponse.data!['maxspeed'] == null) {
//         if (this.mounted) {
//           setState(() {
//             // Your state change code goes here
//             setState(() {
//               maxSpeedvalue = "0";
//             });
//           });
//         }
//       } else {
//         if (this.mounted) {
//           setState(() {
//             // Your state change code goes here
//             setState(() {
//               maxSpeedvalue = progressResponse.data!['maxspeed'].toString();
//             });
//           });
//         }
//       }
//     } catch (err) {
//       (err.toString());
//     }
//   }
//
//   progressUpdate() async {
//     print("progress update is runing");
//     var result = await CurrentLocation().getCurrentLocation();
//     print("checkAlert location${result} ${result == null}");
//
//     if (result == null) {
//       print("result is null google");
//       CustomProgressDialog.showProDialog();
//     } else {
//       print("result is nots null google");
//       CustomProgressDialog.hideProDialog();
//
//       currenTime = DateTime.parse(
//           DateFormat("yyyy-MM-dd HH:mm:ss").format(DateTime.now()));
//       //currenTime
//       // tripDuration = currenTime!.difference(tripstartTime).inMinutes.toString();
//       tripDuration = currenTime!.difference(tripstartTime).inMinutes.toString();
//       if (UserPreferences().getDurationTrip() == null ||
//           UserPreferences().getDurationTrip().isEmpty) {
//         UserPreferences().setDurationTrip(tripDuration!);
//       }
//
//       if (UserPreferences().getDurationTrip() != null ||
//           UserPreferences().getDurationTrip().isNotEmpty) {
//         UserPreferences().setDurationTrip(int.parse(tripDuration!).toString());
//       }
//
//       // double distance = 0.0;
//       // double speed = 0.0;
//       // vehicleSpeed=value!.speed! * 3.6;
//       vehicleSpeed = result.speed! * 2.2369;
//       headingAngle = result.heading;
//       if (result.speed! >= 0 && result.speed! < 1) {
//         print("result speed ${result.speed!}");
//         if (this.mounted) {
//           setState(() {
//             counter += 1;
//           });
//         }
//       }
//
//       List distanceSpeeed = calculateDistanceSpeed(
//           result.latitude!, result.longitude!, vehicleSpeed!);
//       // distance = distanceSpeeed[0];
//       // speed = distanceSpeeed[1];
//
//       print("distanceSpeeed in google map ${distanceSpeeed}");
//       GeoData data = await Geocoder2.getDataFromCoordinates(
//           latitude: result.latitude!,
//           longitude: result.longitude!,
//           googleMapApiKey: "AIzaSyAVJiRDZsecoVecl0fiq2xHchQdWihXr3k");
//       //getAddress = data.address;
//
//       if (this.mounted) {
//         setState(() {
//           // Your state change code goes here
//           getAddress = data.address;
//         });
//       }
//       print("getAddressdata in  getAddressdata ${getAddress}");
//       // final Getaddress= await getAddressdata(result.latitude!, result.longitude!);
//       // print("Getaddress in google map   ${Getaddress}  ${Getaddress.isNotEmpty} ${getAddress}");
//       print("Adress in google ${data.address} ${getAddress}");
//
//       if (isRun) {
//         print("isRun is true in progress trip");
//
//         progressTrip(getAddress!, result.latitude!, result.longitude!,
//             distanceSpeeed[0], distanceSpeeed[1]);
//       }
//     }
//   }
//
//   List calculateDistanceSpeed(double lat, double lng, double speed) {
//     print("calculate speed function called");
//     int tripLocationLength = prefs.getString("triplocations") == null
//         ? 0
//         : UserPreferences.getripLocations().length;
//
//     if (tripLocationLength == 0) {
//       print("trip length is == 0");
//       setState(() {
//         distanceValue = [0.0, 0.0];
//       });
//     } else {
//       print("trip length is != 0");
//
//       Map<String, dynamic> lastIndexData =
//       UserPreferences.getripLocations()[tripLocationLength - 1];
//       var distanceData = getDistanceFromLatLonInKm(
//           lastIndexData['lat'], lastIndexData['lng'], lat, lng);
//
//       var speedData = getGAcceleration(lastIndexData['speed'], speed);
//
//       if (this.mounted) {
//         setState(() {
//           // Your state change code goes here
//           G_ACCValue = speedData;
//           distanceValue = [lastIndexData['distance'] + distanceData, speedData];
//           print("value of distanceValue is ${distanceValue}");
//         });
//       }
//
//       print("GCC in google map is ${speedData} ${G_ACCValue}");
//
//       //distanceValue = [lastIndexData['distance'] + distanceData, speedData];
//
//       print("distanceData in google map  ${distanceData}");
//       print(
//           "distance and speed is distance   ${distanceValue[0]} speed  ${distanceValue[1]}");
//     }
//
//     List<dynamic> encodestringListData = [];
//     if (tripLocationLength == 0) {
//       print("tripLocationLength == 0 encodestringListData ");
//       encodestringListData
//           .add({"lat": lat, "lng": lng, "speed": speed, "distance": 0.0});
//       UserPreferences.setTripLocations(encodestringListData);
//     } else {
//       print("tripLocationLength != 0 encodestringListData ");
//       print("${(UserPreferences.getripLocations() as List<dynamic>).map((e) {
//         encodestringListData.add(e);
//         encodestringListData.add({
//           "lat": lat,
//           "lng": lng,
//           "speed": speed,
//           "distance": distanceValue[0]
//         });
//         UserPreferences.setTripLocations(encodestringListData);
//       })}");
//     }
//
//     print("distanceValue in return ${distanceValue}");
//
//     return distanceValue;
//   }
//
//   double getDistanceFromLatLonInKm(lat1, lon1, lat2, lon2) {
//     var R = 6371; // Radius of the earth in km
//     var dLat = deg2rad(lat2 - lat1); // deg2rad below
//     var dLon = deg2rad(lon2 - lon1);
//     var a = sin(dLat / 2) * sin(dLat / 2) +
//         cos(deg2rad(lat1)) * cos(deg2rad(lat2)) * sin(dLon / 2) * sin(dLon / 2);
//     var c = 2 * atan2(sqrt(a), sqrt(1 - a));
//     var d = R * c;
//     // Distance in km
//     d = d * 1000;
//
//     // Distance in meters
//     //  d= d * 0.621371; //  Distance in miles
//     print("distance in  Kilometers in fore ${R * c}");
//     print("distance in  meters in fore ${d}"); // Distance in km
//
//     // var p = 0.017453292519943295;
//     // var b = 0.5 - cos((lat2 - lat1) * p)/2 +
//     //     cos(lat1 * p) * cos(lat2 * p) *
//     //         (1 - cos((lon2 - lon1) * p))/2;
//     // var c=12742 * asin(sqrt(a));
//     // d= d * 1000;
//     // print("distance in new Kilometers in fore ${12742 * asin(sqrt(a))}");
//     // print("distance in new  meters in fore ${d}");// Distance in km
//     return d;
//   }
//
//   double getGAcceleration(startspeed, endSpeed) {
//     double num = endSpeed - startspeed;
//
//     double den = 5 * 9.80665; //
//
//     double g_acceleration = num / den;
//
//     print("GCC in google Map ${g_acceleration.abs()} ${g_acceleration.abs()}");
//
//     return g_acceleration;
//   }
//
//   double deg2rad(deg) {
//     return deg * (pi / 180);
//   }
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
//     print("Map created ${locationData.longitude} ");
//
//     mapController = controller;
//     if (isRun == true) {
//       location.onLocationChanged.listen((event) async {
//         final Uint8List markerIcon =
//         await getBytesFromAsset('assets/carimage.png', 100);
//
//         if (myMarkers.isNotEmpty) {
//           print("Marker is empty ${isRun}");
//
//           myMarkers.clear();
//         }
//         // circle.add(
//         //     Circle(
//         //         circleId: CircleId(LatLng(event.latitude!,event.longitude!).toString()),
//         //         center:  LatLng(event.latitude!,event.longitude!),
//         //         radius: 50,
//         //         strokeColor:Colors.transparent,
//         //         strokeWidth:1,
//         //         fillColor: CustomColor.primary)
//         // );
//
//         if (this.mounted) {
//           setState(() {
//             // Your state change code goes here
//             myMarkers.add(Marker(
//               //add start location marker
//                 markerId: MarkerId(
//                     LatLng(event.latitude!, event.longitude!).toString()),
//                 position: LatLng(event.latitude!, event.longitude!),
//                 //      flat: true,
//                 rotation: event.heading!,
//                 infoWindow: InfoWindow(
//                   //popup info
//                   title: '${LatLng(event.latitude!, event.longitude!)}',
//                   // snippet: 'Start Marker',
//                 ),
//                 // icon: markerbitmap
//                 icon: BitmapDescriptor.fromBytes(markerIcon),
//                 onTap: () {
//                   print("tap on marker");
//                   // MarkerDetail(  lng: event.longitude!, lat: event.latitude!,);
//                   MarkerDetail(event.latitude!, event.longitude!)
//                       .showMyDialog(context);
//                 } //Icon for Marker
//             ));
//           });
//         }
//
//         print("myMarkers data ${myMarkers.length} ${isRun}");
//         mapController.animateCamera(CameraUpdate.newCameraPosition(
//           CameraPosition(
//             target: LatLng(event.latitude!, event.longitude!),
//             zoom: 17,
//           ),
//         ));
//       });
//     }
//
//     // setMarker();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // print(
//     //     "dashboard trip check in google map   ${dashboardprovider.trip} ${dashboardprovider.trip['id'].runtimeType}");
//
//     return Scaffold(
//         appBar: AppBar(
//           title: Text("Start Trip "),
//         ),
//         body: Stack(
//           children: [
//             GoogleMap(
//               onMapCreated: _onMapCreated,
//
//               myLocationEnabled: true,
//               mapType: MapType.normal,
//               markers: Set<Marker>.from(myMarkers),
//
//               rotateGesturesEnabled: true,
//               myLocationButtonEnabled: false,
//
//               // circles: circle,
//               // myLocationButtonEnabled: true,
//               zoomControlsEnabled: false,
//               zoomGesturesEnabled: true,
//               // minMaxZoomPreference:MinMaxZoomPreference(17, 18)   ,
//
//               initialCameraPosition: CameraPosition(
//                 target: _initialPosition,
//                 zoom: 17,
//               ),
//             ),
//             //1st section
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Container(
//                   // alignment: Alignment.topLeft,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                     color: CustomColor.secondary,
//                   ),
//
//                   margin: EdgeInsets.fromLTRB(10.0, 10.0, 0.0, 0.0),
//                   padding: EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
//
//                   width: 250,
//                   height: 70,
//                   child: Row(
//                     children: [
//                       Image.asset(
//                         "assets/roadimage.png",
//                         width: 50,
//                       ),
//                       Container(
//                         width: 180,
//                         padding: EdgeInsets.fromLTRB(0.0, 5.0, 0.0, 5.0),
//                         child: Text(
//                           "${getAddress == null ? "Getting your address" : getAddress}  ",
//                           style:
//                           TextStyle(color: CustomColor.white, fontSize: 12),
//
//                           // maxLines: 20
//                           // overflow: TextOverflow.ellipsis,
//                           // softWrap: true,
//                         ),
//                       )
//                     ],
//                   ),
//
//                   // child: ElevatedButton.icon(
//                   //     label:Text("Road trip"),
//                   //     icon: Image.asset("assets/roadimage.png", width: 50,),
//                   //     style: ButtonStyle(
//                   //         backgroundColor: MaterialStateProperty.all(CustomColor.secondary),
//                   //         foregroundColor: MaterialStateProperty.all(CustomColor.white),
//                   //         shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   //             RoundedRectangleBorder(
//                   //               // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                   //                 borderRadius: BorderRadius.circular(10.0)))
//                   //
//                   //     ),
//                   //     onPressed: null),
//                 ),
//                 Container(
//                   margin: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
//                   padding: EdgeInsets.fromLTRB(0.0, 10.0, 10.0, 0.0),
//                   child: Container(
//                       width: 60,
//                       height: 60,
//                       decoration: BoxDecoration(
//                           color: Colors.white,
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.red, width: 4)),
//                       child: Container(
//                           alignment: Alignment.center,
//                           child: Text(
//                             "${maxSpeedvalue}",
//                             style: TextStyle(
//                                 color: CustomColor.primary,
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 18),
//                           ))),
//                 )
//               ],
//             ),
//             //2nd section
//             Positioned(
//               bottom: 130,
//               left: 5,
//               right: 5,
//               child: Container(
//                 child: Row(
//                   // mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   // crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     Container(
//                         padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
//                         alignment: Alignment.center,
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.center,
//                           children: [
//                             //driver
//                             Container(
//                               //width: 200,
//                               child: Text(
//                                 "Idle time: ${counter}",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: CustomColor.primary),
//                               ),
//                             ),
//                             Container(
//
//                               // color: Colors.orange,
//                               //width: 200,
//                               child: Text(
//                                 "Angle ${headingAngle == null ? "0" : headingAngle!.round()} deg",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: CustomColor.primary),
//                               ),
//                             ),
//                             //started at
//                           ],
//                         )),
//                     Spacer(),
//                     //image
//                     Container(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             //driver
//                             Container(
//
//                               padding: EdgeInsets.only(bottom: 5),
//                               //width: 200,
//                               child: Stack(
//                                 children: [
//                                   Image.asset(
//                                     "assets/speedmeter.png",
//                                     height: 130,
//                                     fit: BoxFit.contain,
//                                   ),
//                                   Positioned(
//                                       top: 15,
//                                       bottom: 15,
//                                       left: 10,
//                                       right: 10,
//                                       child: Container(
//                                         // width: 100,
//                                         // height: 100,
//
//                                         alignment: Alignment.center,
// //distanceValue[1]!.toStringAsFixed(2).toString()
//                                         child: Text(
//                                           "${vehicleSpeed == null ? 0 : vehicleSpeed!.toStringAsFixed(0)}",
//                                           // textAlign: TextAlign.center,
//                                           style: TextStyle(
//                                             fontWeight: FontWeight.bold,
//                                             fontSize: 18,
//                                           ),
//                                         ),
//                                       ))
//                                 ],
//                               ),
//                             ),
//                             //started at
//                           ],
//                         )),
//                     Spacer(),
//                     //angle text
//                     Container(
//                         padding: EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             //angle
//                             Container(
//                               // color: Colors.orange,
//                               //width: 200,
//                               child: Text(
//                                 "Angle ${headingAngle == null ? "0deg" : headingAngle!.round()} deg ",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: CustomColor.primary),
//                               ),
//                             ),
//                             //gcc
//                             Container(
//                               // color: Colors.orange,
//                               //width: 200,
//                               child: Text(
//                                 "G-Acc:  ${G_ACCValue == null ? "0.00" : G_ACCValue!.toStringAsFixed(2)}",
//                                 style: TextStyle(
//                                     fontWeight: FontWeight.w500,
//                                     color: CustomColor.primary),
//                               ),
//                             ),
//                           ],
//                         )),
//                   ],
//                 ),
//               ),
//             ),
//             //3rd section
//             Positioned(
//                 bottom: 60,
//                 left: 5,
//                 right: 5,
//                 child: Container(
//                     color: Colors.white,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children:
//                       [
//                         //left Container
//                         Expanded(
//                           flex: 6,
//                           // color:Colors.orange,
//                           // padding: EdgeInsets.only(left: 5),
//
//                           // alignment: Alignment.topLeft,
//                           child: Container(
//                             padding: EdgeInsets.only(left: 5,right:5),
//                             decoration: BoxDecoration(
//                                 border: Border(
//                                   right: BorderSide(
//                                     color: CustomColor.backgroundColor,
//                                     width: 2,
//                                   ),
//                                 )),
//
//                             child: Column(
//
//                               crossAxisAlignment: CrossAxisAlignment.start,
//
//                               children: [
//
//                                 //driver
//                                 Container(
//                                     alignment: Alignment.topLeft,
//                                     child: Row(
//                                       children: [
//                                         Text(
//                                           "Driver",
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: CustomColor.primary,
//                                               fontWeight: FontWeight.bold),
//                                         )
//                                         ,
//                                         Spacer(),
//                                         Text(
//                                           "${ProvidersUtility.userProvider!.user.username}",
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: CustomColor.primary),
//                                         ),
//                                       ],)
//
//
//                                 ),
//
//
//
//                                 //started at
//
//                                 Container(
//
//                                     alignment: Alignment.topLeft,
//                                     child: Row(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Text(
//                                           "Started\nAt",
//                                           style: TextStyle(
//                                               fontSize: 14,
//                                               color: CustomColor.primary,
//                                               fontWeight: FontWeight.bold),
//                                         ),
//
//                                         Spacer(),
//
//                                         Text(
//                                           "${widget.dateTime!.split(" ")[0]}",
//                                           style: TextStyle(
//                                             fontSize: 14,
//                                             color: CustomColor.primary,
//                                           ),
//                                         ),
//                                       ],)
//
//
//                                 ),
//
//
//                                 //duration
//
//                                 Container(
//
//                                     alignment: Alignment.topLeft,
//                                     child: Row(children: [
//                                       Text(
//                                         "Duration",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: CustomColor.primary,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Spacer(),
//                                       Text(
//                                         "${UserPreferences().getDurationTrip() == null || UserPreferences().getDurationTrip().isEmpty ? "0 min" : UserPreferences().getDurationTrip() + " " + "min"}",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: CustomColor.primary,
//                                         ),
//                                       ),
//                                     ],)
//
//
//                                 ),
//
//
//
//                               ],
//                             ),
//                           ),
//                         ),
//
//
//
//                         // right
//
//
//
//
//
//                         Expanded(
//                           flex:6,
//                           // alignment: Alignment.topLeft,
//                           child: Container(
//                             padding: EdgeInsets.only(left: 5,right:5),
//                             alignment: Alignment.topRight,
//
//                             child: Column(
//
//                               crossAxisAlignment: CrossAxisAlignment.start,
//
//                               children: [
//
//                                 //VRN
//                                 Container(
//                                     alignment: Alignment.topLeft,
//                                     child: Row(children: [
//                                       Text(
//                                         "VRN ",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: CustomColor.primary,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//
//                                       Spacer(),
//                                       Text(
//                                         "${widget.vrn}",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: CustomColor.primary,
//                                         ),
//                                       ),
//                                     ],)
//
//
//                                 ),
//
//
//                                 //started from
//
//                                 Container(
//
//                                     alignment: Alignment.topLeft,
//                                     child: Row(children: [
//                                       Text(
//                                         "Started\nFrom",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: CustomColor.primary,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Spacer(),
//                                       Text(
//                                         "${widget.lat},\n ${widget.lng} ",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: CustomColor.primary,
//                                         ),
//                                       ),
//                                     ],)
//
//
//                                 ),
//
//
//                                 //distance
//
//                                 Container(
//
//                                     alignment: Alignment.topLeft,
//                                     child: Row(children: [
//                                       Text(
//                                         "Distance",
//                                         style: TextStyle(
//                                             fontSize: 14,
//                                             color: CustomColor.primary,
//                                             fontWeight: FontWeight.bold),
//                                       ),
//                                       Spacer(),
//                                       Text(
//                                         "${distanceValue.isEmpty == true ? 0 : (distanceValue[0]!.abs() * 0.000621371).toStringAsFixed(2).toString()}miles",
//                                         style: TextStyle(
//                                           fontSize: 14,
//                                           color: CustomColor.primary,
//                                         ),
//                                       ),
//                                     ],)
//
//
//                                 ),
//
//
//
//                               ],
//                             ),
//                           ),
//                         ),
//
//
//                       ],
//                     )
//
//
//                 )
//
//             ),
//
//
//             //old one
//             // Positioned(
//             //     bottom: 60,
//             //     left: 5,
//             //     right: 5,
//             //     child: IntrinsicHeight(
//             //       child: Container(
//             //         decoration: BoxDecoration(
//             //           // border: Border.all(color: CustomColor.primary),
//             //           color: Colors.white.withOpacity(0.8),
//             //         ),
//             //         child: Row(
//             //           mainAxisAlignment: MainAxisAlignment.center,
//             //           // crossAxisAlignment: CrossAxisAlignment.center,
//             //           children: [
//             //             Container(
//             //                 padding: EdgeInsets.fromLTRB(2.0, 10.0, 5.0, 10.0),
//             //                 decoration: BoxDecoration(
//             //                     border: Border(
//             //                   right: BorderSide(
//             //                     color: CustomColor.backgroundColor,
//             //                     width: 1,
//             //                   ),
//             //                 )),
//             //                 child: Column(
//             //                    crossAxisAlignment: CrossAxisAlignment.start,
//             //                   children: [
//             //                     //driver
//             //
//             //
//             //                     Container(
//             //                       width: 200,
//             //                       child: Row(
//             //                         mainAxisAlignment:
//             //                             MainAxisAlignment.spaceBetween,
//             //                         children: [
//             //                           Container(
//             //                             // color: Colors.red ,
//             //                             alignment: Alignment.topLeft,
//             //                             child: Text(
//             //                               "Driver ",
//             //                               style: TextStyle(
//             //                                   fontSize: 14,
//             //                                   color: CustomColor.primary,
//             //                                   fontWeight: FontWeight.bold),
//             //                             ),
//             //                           ),
//             //                           Container(
//             //
//             //                             // color: Colors.blue ,
//             //                               // alignment: Alignment.topRight,
//             //                               child: Text(
//             //                                 "${ProvidersUtility.userProvider!.user.username}",
//             //                                 style: TextStyle(
//             //                                     fontSize: 14,
//             //                                     color: CustomColor.primary),
//             //                               ),
//             //
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                     //started at
//             //                     Container(
//             //                       // color: Colors.orange,
//             //                       width: 200,
//             //                       child: Row(
//             //                         mainAxisAlignment:
//             //                             MainAxisAlignment.spaceBetween,
//             //                         children: [
//             //                           Container(
//             //                             // color: Colors.red ,
//             //                             alignment: Alignment.topLeft,
//             //                             child: Text(
//             //                               "Started\nAt ",
//             //                               style: TextStyle(
//             //                                   fontSize: 14,
//             //                                   color: CustomColor.primary,
//             //                                   fontWeight: FontWeight.bold),
//             //                             ),
//             //                           ),
//             //                           Container(
//             //                             width: 100,
//             //                             alignment: Alignment.topRight,
//             //                             child: Text(
//             //                               "${widget.dateTime!.split(" ")[0]}",
//             //                               style: TextStyle(
//             //                                 fontSize: 14,
//             //                                 color: CustomColor.primary,
//             //                               ),
//             //                             ),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                     //duration
//             //                     Container(
//             //                       // color: Colors.orange,
//             //                       width: 200,
//             //                       child: Row(
//             //                         mainAxisAlignment:
//             //                             MainAxisAlignment.spaceBetween,
//             //                         children: [
//             //                           Container(
//             //                             // color: Colors.red ,
//             //                             alignment: Alignment.topLeft,
//             //                             child: Text(
//             //                               "Duration ",
//             //                               style: TextStyle(
//             //                                   fontSize: 14,
//             //                                   color: CustomColor.primary,
//             //                                   fontWeight: FontWeight.bold),
//             //                             ),
//             //                           ),
//             //                           Container(
//             //                             alignment: Alignment.topRight,
//             //                             child: Text(
//             //                               "${UserPreferences().getDurationTrip() == null || UserPreferences().getDurationTrip().isEmpty ? "0 min" : UserPreferences().getDurationTrip() + " " + "min"}",
//             //                               style: TextStyle(
//             //                                 fontSize: 14,
//             //                                 color: CustomColor.primary,
//             //                               ),
//             //                             ),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 )),
//             //
//             //
//             //             //Right part
//             //             Container(
//             //                 padding: EdgeInsets.fromLTRB(5.0, 10.0, 2.0, 10.0),
//             //                 child: Column(
//             //                   crossAxisAlignment: CrossAxisAlignment.start,
//             //                   children: [
//             //                     //VRN
//             //                     Container(
//             //                       width: 180,
//             //                       child: Row(
//             //                         mainAxisAlignment:
//             //                             MainAxisAlignment.spaceBetween,
//             //                         children: [
//             //                           Container(
//             //                             // color: Colors.red ,
//             //                             alignment: Alignment.topLeft,
//             //                             child: Text(
//             //                               "VRN ",
//             //                               style: TextStyle(
//             //                                   fontSize: 14,
//             //                                   color: CustomColor.primary,
//             //                                   fontWeight: FontWeight.bold),
//             //                             ),
//             //                           ),
//             //                           Container(
//             //                             // color: Colors.blue ,
//             //                             alignment: Alignment.topRight,
//             //                             child: Text(
//             //                               "${widget.vrn}",
//             //                               style: TextStyle(
//             //                                 fontSize: 14,
//             //                                 color: CustomColor.primary,
//             //                               ),
//             //                             ),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                     //STARTED FROM
//             //                     Container(
//             //                       width: 180,
//             //                       child: Row(
//             //                         mainAxisAlignment:
//             //                             MainAxisAlignment.spaceBetween,
//             //                         children: [
//             //                           Container(
//             //                             alignment: Alignment.topLeft,
//             //                             child: Text(
//             //                               "Started\nFrom",
//             //                               style: TextStyle(
//             //                                   fontSize: 14,
//             //                                   color: CustomColor.primary,
//             //                                   fontWeight: FontWeight.bold),
//             //                             ),
//             //                           ),
//             //                           Container(
//             //                             alignment: Alignment.topRight,
//             //                             child: Text(
//             //                               "${widget.lat},\n ${widget.lng} ",
//             //                               style: TextStyle(
//             //                                 fontSize: 14,
//             //                                 color: CustomColor.primary,
//             //                               ),
//             //                             ),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                     //DISTANCE
//             //                     Container(
//             //                       width: 180,
//             //                       child: Row(
//             //                         mainAxisAlignment:
//             //                             MainAxisAlignment.spaceBetween,
//             //                         children: [
//             //                           Container(
//             //                             // color: Colors.red ,
//             //                             alignment: Alignment.topLeft,
//             //                             child: Text(
//             //                               "Distance",
//             //                               style: TextStyle(
//             //                                   fontSize: 14,
//             //                                   color: CustomColor.primary,
//             //                                   fontWeight: FontWeight.bold),
//             //                             ),
//             //                           ),
//             //                           Container(
//             //                             // color: Colors.blue ,
//             //                             alignment: Alignment.topRight,
//             //                             // distanceValue[0]!.abs() * 0.000621371).toStringAsFixed(5).toString()
//             //                             child: Text(
//             //                               "${distanceValue.isEmpty == true ? 0 : (distanceValue[0]!.abs() * 0.000621371).toStringAsFixed(2).toString()}miles",
//             //                               style: TextStyle(
//             //                                 fontSize: 14,
//             //                                 color: CustomColor.primary,
//             //                               ),
//             //                             ),
//             //                           ),
//             //                         ],
//             //                       ),
//             //                     ),
//             //                   ],
//             //                 )),
//             //           ],
//             //         ),
//             //       ),
//             //     )),
//             // end trip
//             Positioned(
//                 bottom: 2,
//                 left: 5,
//                 right: 5,
//                 height: 50,
//
//                 // width: MediaQuery.of(context).size.width * 0.8,
//                 child: Container(
//                   child: ElevatedButton(
//                     onPressed: () async {
//                       CustomProgressDialog.showProDialog();
//                       CurrentLocation()
//                           .getCurrentLocation()
//                           .then((value) async {
//                         Map<String, dynamic> endTripreqBody = {
//                           "organisation_id": ProvidersUtility
//                               .userProvider!.user.organizationID,
//                           "status": 2,
//                           "tripId": widget.tripId,
//                           "roadName": "$getAddress",
//                           "getMaxSpeed": "true",
//                           "coordinates": [
//                             {
//                               "lat": value!.latitude!,
//                               "lng": value.longitude!,
//                               "distance": distanceValue[0],
//                               "speed": distanceValue[1]
//                             }
//                           ]
//                         };
//                         print(
//                             "endtrip request body ${endTripreqBody} ${distanceValue}");
//                         final endTripresponse;
//                         endTripresponse = await AppUrl.apiService.endTrip(
//                             ProvidersUtility.userProvider!.user.token,
//                             endTripreqBody);
//                         print(
//                             "End trip message ${endTripresponse.message} ${endTripresponse.error} TripController.tripId ${TripController.tripId}");
//                         if (endTripresponse.error == 0) {
//                           setState(() {
//                             isRun = false;
//                           });
//                           if (prefs.getString("backgroundTripLoc") != null) {
//                             prefs.remove("backgroundTripLoc");
//                           }
//                           if (prefs.getString("triplocations") != null) {
//                             prefs.remove("triplocations");
//                           }
//                           print("endTripresponse == 0 ${endTripresponse} ");
//
//                           TripController.tripId = false;
//
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content: Text(endTripresponse.message),
//                           ));
//                           tripDetails(context);
//
//                           // Navigator.pop(context);
//                           // Navigator.pop(context);
//                         } else {
//                           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//                             content: const Text("Try Again"),
//                           ));
//                         }
//                       });
//                       CustomProgressDialog.hideProDialog();
//                     },
//                     child: Text(
//                       "End trip",
//                       style: TextStyle(fontSize: 18),
//                     ),
//                     style: ButtonStyle(
//                         backgroundColor:
//                         MaterialStateProperty.all(CustomColor.subBtn),
//                         foregroundColor:
//                         MaterialStateProperty.all(CustomColor.white),
//                         shape: MaterialStateProperty
//                             .all<RoundedRectangleBorder>(RoundedRectangleBorder(
//                           // borderRadius: BorderRadius.all(Radius.elliptical(20, 20))
//                             borderRadius: BorderRadius.circular(10.0)))),
//                   ),
//                 ))
//           ],
//         ));
//   }
// }
