
import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class ListPolygon extends StatefulWidget {
  const ListPolygon({Key? key}) : super(key: key);

  @override
  State<ListPolygon> createState() => _ListPolygonState();
}

class _ListPolygonState extends State<ListPolygon> {
  Set<Polygon> _polygon = HashSet<Polygon>();
  Completer<GoogleMapController> _controller = Completer();

  // created list of locations to display polygon
  List<LatLng> points = [
    LatLng(19.0759837, 72.8776559),
    LatLng(28.679079, 77.069710),
    LatLng(26.850000, 80.949997),
    LatLng(19.0759837, 72.8776559),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
        Polygon(
          // given polygonId
          polygonId: PolygonId('1'),
          // initialize the list of points to display polygon
          points: points,
          // given color to polygon
          fillColor: Colors.transparent,
          // given border color to polygon
          strokeColor: Colors.red,
          geodesic: true,
          // given width of border
          strokeWidth: 2,
        )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("LIST OF POLYgons"),
      ),

      body: GoogleMap(
        //given camera position
        initialCameraPosition: CameraPosition(
          target: LatLng(19.0759837, 72.8776559),
          zoom: 14,
        )
        ,
        // on below line we have given map type
        mapType: MapType.normal,
        // on below line we have enabled location
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        // on below line we have enabled compass location
        compassEnabled: true,
        // on below line we have added polygon
        polygons: _polygon,
        // displayed google map
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),

    );
  }
}