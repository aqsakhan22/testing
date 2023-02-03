
import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
// import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:location/location.dart';
// import 'package:novus_guard_pro_flutter/theme/color.dart';



//
// class GoogleMapPractice extends StatefulWidget {
//
//
//     GoogleMapPractice({Key? key}) : super(key: key);
//
//
//   @override
//   State<GoogleMapPractice> createState() => _GoogleMapPracticeState();
// }
//
// class _GoogleMapPracticeState extends State<GoogleMapPractice> {
//   Completer<GoogleMapController> _controller = Completer();
//   double CAMERA_ZOOM = 13;
//   double CAMERA_TILT = 0;
//   double CAMERA_BEARING = 30;
//   LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
//   LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);
//
//   Set<Marker> _markers = {};
// // this will hold the generated polylines
//   Set<Polyline> _polylines = {};
// // this will hold each polyline coordinate as Lat and Lng pairs
//   List<LatLng> polylineCoordinates = [];
// // this is the key object - the PolylinePoints
// // which generates every polyline between start and finish
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPIKey = "AIzaSyAVJiRDZsecoVecl0fiq2xHchQdWihXr3k";
//
//   // for my custom icons
// late  BitmapDescriptor sourceIcon;
//  late BitmapDescriptor destinationIcon;
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     setSourceAndDestinationIcons();
//   }
//   void setSourceAndDestinationIcons() async {
//     sourceIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 1.5), 'assets/carIcon_green.png',);
//     destinationIcon = await BitmapDescriptor.fromAssetImage(
//         ImageConfiguration(devicePixelRatio: 1.5),
//         'assets/document_color.png');
//   }
//
//   void onMapCreated(GoogleMapController controller) {
//     _controller.complete(controller);
//     setMapPins();
//     setPolylines();
//   }
//   setPolylines() async {
//     // List<PointLatLng> result = await polylinePoints!.getRouteBetweenCoordinates(
//     //     googleAPIKey,
//     //     SOURCE_LOCATION.latitude,
//     //     SOURCE_LOCATION.longitude,
//     //     DEST_LOCATION.latitude,
//     //     DEST_LOCATION.longitude);
//     // if(result.isNotEmpty){
//     //   // loop through all PointLatLng points and convert them
//     //   // to a list of LatLng, required by the Polyline
//     //   result.forEach((PointLatLng point){
//     //     polylineCoordinates.add(
//     //         LatLng(point.latitude, point.longitude));
//     //   });
//     // }
//     setState(() {
//       // create a Polyline instance
//       // with an id, an RGB color and the list of LatLng pairs
//       Polyline polyline = Polyline(
//           polylineId: PolylineId('poly'),
//           color: Color.fromARGB(255, 40, 122, 198),
//           points: polylineCoordinates
//       );
//
//       // add the constructed polyline as a set of points
//       // to the polyline set, which will eventually
//       // end up showing up on the map
//       _polylines.add(polyline);
//     });
//   }
//   void setMapPins() {
//     setState(() {
//       // source pin
//       _markers.add(Marker(
//           markerId: MarkerId('sourcePin'),
//           position: SOURCE_LOCATION,
//           icon:sourceIcon
//       ));
//       // destination pin
//       _markers.add(Marker(
//           markerId: MarkerId('destPin'),
//           position: DEST_LOCATION,
//           icon: destinationIcon
//       ));
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     CameraPosition initialLocation = CameraPosition(
//         zoom: CAMERA_ZOOM,
//         bearing: CAMERA_BEARING,
//         tilt: CAMERA_TILT,
//         target: SOURCE_LOCATION
//     );
//
//     return  GoogleMap(
//         myLocationEnabled: true,
//         compassEnabled: true,
//         tiltGesturesEnabled: false,
//         markers: _markers,
//         polylines: _polylines,
//         mapType: MapType.normal,
//         initialCameraPosition: initialLocation,
//         onMapCreated: onMapCreated
//     );
//   }
// }



// class GoogleMapPractice1 extends StatefulWidget {
//   const GoogleMapPractice1({Key? key}) : super(key: key);
//
//   @override
//   State<GoogleMapPractice1> createState() => _GoogleMapPractice1State();
// }
//
// class _GoogleMapPractice1State extends State<GoogleMapPractice1> {
//   late GoogleMapController mapController;
//   LatLng _initialPosition = LatLng(24.9517415, 67.1229219);
//   List<Marker> myMarkers = [];
//
//   MapType _currentMapType = MapType.normal;
//   Location location = Location();
//   late LocationData locationData;
//   double _originLatitude = 24.9518014, _originLongitude = 67.1200301;
//   double _destLatitude = 24.9509566, _destLongitude = 67.119854;
//   Map<MarkerId, Marker> markers = {};
//   Map<PolylineId, Polyline> polylines = {};
//   List<LatLng> polylineCoordinates = [];
//   PolylinePoints polylinePoints = PolylinePoints();
//   String googleAPiKey ="AIzaSyAVJiRDZsecoVecl0fiq2xHchQdWihXr3k";
//
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _addMarker(LatLng(_originLatitude, _originLongitude), "origin",
//         BitmapDescriptor.defaultMarker);
//
//     /// destination marker
//     _addMarker(LatLng(_destLatitude, _destLongitude), "destination",
//         BitmapDescriptor.defaultMarkerWithHue(90));
//
//     _getPolyline();
//
//   }
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//     Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }
//   _getPolyline() async {
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
//         googleAPiKey,
//         PointLatLng(_originLatitude, _originLongitude),
//         PointLatLng(_destLatitude, _destLongitude),
//         travelMode: TravelMode.driving,
//         wayPoints: [PolylineWayPoint(location: "Sabo, Yaba Lagos Nigeria")]);
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     }
//     _addPolyLine();
//   }
//   _addPolyLine() {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//         polylineId: id, color: Colors.red, points: polylineCoordinates);
//     polylines[id] = polyline;
//     setState(() {});
//   }
//
//
//
//   void _onMapCreated(GoogleMapController controller) async{
//
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
//
//
//
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size size=MediaQuery.of(context).size;
//     return Scaffold(
//       backgroundColor: CustomColor.white,
//       appBar: AppBar(
//         title: Text("Available Jobs"),
//         // leading:Icon(Icons.arrow_back,color:CustomColor.primary)
//       ),
//       body: Column(
//         // mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//
//           Expanded(
//             // height:size.height * 0.5,
//             child: GoogleMap(
//               // markers: Set<Marker>.from(myMarkers),
//               mapType: _currentMapType,
//               myLocationEnabled: true,
//               tiltGesturesEnabled: true,
//               compassEnabled: true,
//               scrollGesturesEnabled: true,
//               zoomGesturesEnabled: true,
//               zoomControlsEnabled: false,
//
//               // onCameraMove: _onCameraMove,
//               onMapCreated: _onMapCreated,
//
//               markers: Set<Marker>.of(markers.values),
//               // polylines: Set<Polyline>.of(polylines.values),
//               initialCameraPosition: CameraPosition(
//                   target: LatLng(_originLatitude, _originLongitude), zoom: 17),
//             ),
//           ),
//           Container(
//
//               child: Text("AVAILABLE JOBS",style: TextStyle(color: Colors.blue),)),
//
//
//         ],
//       ),
//
//     );
//   }
//  }


// class MultiplePolygons extends StatefulWidget {
//   const MultiplePolygons({Key? key}) : super(key: key);
//
//   @override
//   State<MultiplePolygons> createState() => _MultiplePolygonsState();
// }
//
// class _MultiplePolygonsState extends State<MultiplePolygons> {
//   // Starting point latitude
//    double _originLatitude = 6.5212402;
// // Starting point longitude
//   double _originLongitude = 3.3679965;
// // Destination latitude
//   double _destLatitude = 6.849660;
// // Destination Longitude
//   double _destLongitude = 3.648190;
// // Markers to show points on the map
//   Map<MarkerId, Marker> markers = {};
//   PolylinePoints polylinePoints = PolylinePoints();
//   Map<PolylineId, Polyline> polylines = {};
//
//   // Google Maps controller
//   Completer<GoogleMapController> _controller = Completer();
//   // Configure map position and zoom
//   // static final CameraPosition _kGooglePlex = CameraPosition(
//   //   target: LatLng(_originLatitude, _originLongitude),
//   //   zoom: 9.4746,
//   // );
//   _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
//     MarkerId markerId = MarkerId(id);
//     Marker marker =
//     Marker(markerId: markerId, icon: descriptor, position: position);
//     markers[markerId] = marker;
//   }
//
//   void _getPolyline() async {
//     List<LatLng> polylineCoordinates = [];
//
//     PolylineResult result = await polylinePoints.getRouteBetweenCoordinates("AIzaSyAVJiRDZsecoVecl0fiq2xHchQdWihXr3k",
//       PointLatLng(_originLatitude, _originLongitude),
//       PointLatLng(_destLatitude, _destLongitude),
//       travelMode: TravelMode.driving,
//     );
//     if (result.points.isNotEmpty) {
//       result.points.forEach((PointLatLng point) {
//         polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//       });
//     } else {
//       print(result.errorMessage);
//     }
//     _addPolyLine(polylineCoordinates);
//   }
//
//   _addPolyLine(List<LatLng> polylineCoordinates) {
//     PolylineId id = PolylineId("poly");
//     Polyline polyline = Polyline(
//       polylineId: id,
//       color: Colors.red,
//       points: polylineCoordinates,
//       width: 8,
//     );
//     polylines[id] = polyline;
//     setState(() {});
//   }
//   @override
//   void initState() {
//     /// add origin marker origin marker
//     _addMarker(
//       LatLng(_originLatitude, _originLongitude),
//       "origin",
//       BitmapDescriptor.defaultMarker,
//     );
//
//     // Add destination marker
//     _addMarker(
//       LatLng(_destLatitude, _destLongitude),
//       "destination",
//       BitmapDescriptor.defaultMarkerWithHue(90),
//     );
//
//     _getPolyline();
//
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("abnbdjvb"),
//       ),
//
//       body:  GoogleMap(
//         mapType: MapType.normal,
//         initialCameraPosition: CameraPosition(target: LatLng(_originLatitude, _originLongitude), zoom: 9.4746,),
//         myLocationEnabled: true,
//         tiltGesturesEnabled: true,
//         compassEnabled: true,
//         scrollGesturesEnabled: true,
//         zoomGesturesEnabled: true,
//         markers: Set<Marker>.of(markers.values),
//         polylines: Set<Polyline>.of(polylines.values),
//         onMapCreated: (GoogleMapController controller) {
//           _controller.complete(controller);
//         },
//       ),
//     );
//
//   }
// }









