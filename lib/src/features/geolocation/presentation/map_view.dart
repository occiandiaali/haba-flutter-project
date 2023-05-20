import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:haba/src/features/geolocation/data/repository/dummy_users.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
//import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_map_marker_popup/flutter_map_marker_popup.dart';

import '../domain/models/entity.dart';


class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Location location = Location();
  bool coordsSet = false;

  late LatLng _pinPoint;
  //List<Marker> markers = [];
  late List<Marker> markers;
  // late List<LatLng> _pointsList;
  // late LatLng _points;

  final PopupController _popupController = PopupController();
  final PopupController _popupController2 = PopupController();

  Future<LocationData?> _currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return null;
      }
    }
    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }
    locationData = await location.getLocation();

    setState(() {
      _pinPoint = LatLng(locationData.latitude!, locationData.longitude!);
      coordsSet = true;
    });


    print("Coords: $_pinPoint");
    return locationData;
  }

 // List<Entity> entities = [];
  var persons = <int, Entity>{};

  var names = [
    "John Doe",
    "Jane Wick",
    "Ben Stolen",
    "You are here.."
    "Bose Bad",
    "Emeka Bond",
    "Hauwa Ole",
    "Joe Black"
  ];
  late PopupMarkerLayerWidget n;
  late Marker m;

  // Widget _testEntities() {
  //  // late Marker m;
  //
  //   for (var i = 0; i < marks.length; i++) {
  //     m = Marker(
  //       point: marks[i],
  //       width: 80,
  //       height: 85,
  //       builder: (context) => const Icon(Icons.location_on_rounded, color: Colors.teal,),
  //     );
  //     persons[i] = Entity(
  //         index: i,
  //         label: names[i],
  //         marker: m);
  //     n = PopupMarkerLayerWidget(
  //       options:  PopupMarkerLayerOptions(
  //         popupController: _popupController2,
  //         popupAnimation: const PopupAnimation.fade(),
  //         markers: [
  //           m,
  //         ],
  //         popupBuilder: (BuildContext context, Marker marker) => Container(
  //           padding: const EdgeInsets.all(12.0),
  //           color: Colors.white,
  //           height: 120,
  //           width: 160,
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               const Icon(Icons.account_circle_rounded, size: 24,),
  //               const SizedBox(height: 6.0,),
  //               Text(names[i], style: const TextStyle(fontFamily: 'Cera Pro', fontSize: 18),),
  //               const SizedBox(height: 6.0,),
  //               Text("Latitude: ${persons[i]!.marker.point.latitude}"),
  //               Text("Longitude: ${persons[i]!.marker.point.longitude}"),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
  //   }
  //   return n;
  // }

  // void _fakeEntities() {
  //   late Marker m;
  //   for (var i = 0; i < marks.length; i++) {
  //     m = Marker(
  //       point: marks[i],
  //       width: 80,
  //       height: 85,
  //       builder: (context) => const Icon(Icons.location_on_rounded, color: Colors.teal,),
  //     );
  //     entities.add(
  //       Entity(
  //           index: i,
  //           label: names[i],
  //           marker: m),
  //     );
  //     persons[i] = Entity(
  //         index: i,
  //         label: names[i],
  //         marker: m);
  //   }
  // }
  //
  // void _fakeCoords() {
  //   late Marker m;
  //   for (var i = 0; i < marks.length; i++) {
  //     m = Marker(
  //       point: marks[i],
  //       width: 80,
  //       height: 85,
  //       builder: (context) => const Icon(Icons.location_on_rounded, color: Colors.teal,),
  //     );
  //     markers.add(m);
  //   }
  // }
  // late String name;
  // late double lattie;
  // late double lottie;
  // void _personsList() {
  //   for (var x = 0; x < persons.length; x++) {
  //     setState(() {
  //       name = persons[x]!.label;
  //       lattie = persons[x]!.marker.point.latitude;
  //       lottie = persons[x]!.marker.point.longitude;
  //     });
  //     print("Persons: $name - $lattie, $lottie");
  //   }
  // }
  // void _printCoordsList() {
  //   for (var x = 0; x < entities.length; x++) {
  //     print("Points: ${entities[x].label}, ${entities[x].marker.point}");
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   if (mounted) {
  //     _currentLocation();
  //     // _fakeCoords();
  //    // _fakeEntities();
  //   // _personsList();
  //   }
  // }

  final latRange = marks[0].latitude - marks[marks.length - 1].latitude;
  final lonRange = marks[0].longitude - marks[marks.length - 1].longitude;
  static const totalMarkers = 20;
  @override
  void initState() {

    final stepsDirection = sqrt(totalMarkers).floor();
    final latSteps = latRange / stepsDirection;
    final lonSteps = lonRange / stepsDirection;

    if (mounted) {
      _currentLocation();
      markers = [];
      for (var i = 0; i < marks.length; i++) {

        final latLng = LatLng(marks[i].latitude, marks[i].longitude);

        markers.add(
          Marker(
            height: 40,
            width: 40,
            point: latLng,
            builder: (context) => Icon(Icons.pin_drop_rounded, color: latLng == _pinPoint ? Colors.deepOrange : Colors.teal),
          ),
        );
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return coordsSet == true ? SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        // child: FlutterMap(
        //   options: MapOptions(
        //     //  center: LatLng(6.6970, 3.4182),
        //     center: _pinPoint,
        //     zoom: 13.0,
        //     maxZoom: 15,
        //     minZoom: 8,
        //     onTap: (_, __) => _popupController.hideAllPopups()
        //   ),
        //   nonRotatedChildren: const [
        //     RichAttributionWidget(
        //       permanentHeight: 21,
        //         attributions: [
        //       TextSourceAttribution(
        //         'OpenStreetMap contributors',
        //       //  onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
        //       ),
        //     ]),
        //     // SimpleAttributionWidget(
        //     //     source: Text('OpenStreetMap contributors'),
        //     // ),
        //   ],
        //   children: [
        //     TileLayer(
        //       urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        //       subdomains: const ['a', 'b', 'c'],
        //       userAgentPackageName: 'com.example.app',
        //     ),
        //     PopupMarkerLayerWidget(
        //       options: PopupMarkerLayerOptions(
        //         popupController: _popupController,
        //         popupAnimation: const PopupAnimation.fade(),
        //         markers: [
        //           Marker(
        //            point: _pinPoint,
        //            // point: _points,
        //             width: 90,
        //             height: 95,
        //             builder: (context) => const Icon(Icons.location_on_rounded, color: Colors.deepOrange,),
        //           ),
        //          // ...markers
        //           //...entities.map((e) => e.marker)
        //           ...persons.values.map((e) => e.marker),
        //         ],
        //         popupBuilder: (BuildContext context, Marker marker) => Container(
        //           padding: const EdgeInsets.all(12.0),
        //           color: Colors.white,
        //           height: 120,
        //           width: 160,
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               const Text("You are here", style: TextStyle(fontFamily: 'Cera Pro', fontSize: 18),),
        //               const SizedBox(height: 6.0,),
        //               Text("Latitude: ${_pinPoint.latitude}"),
        //               Text("Longitude: ${_pinPoint.longitude}")
        //             ],
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // )
        child: FlutterMap(
          options: MapOptions(
            //  center: LatLng(6.6970, 3.4182),
              center: _pinPoint,
              zoom: 12.0,
              maxZoom: 17.0,
              minZoom: 8.0,
              onTap: (_, __) => _popupController.hideAllPopups()
          ),
          nonRotatedChildren: [
            AttributionWidget(
                attributionBuilder: (context) => const Text("OpenStreetMap contributors"))
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.app',
            ),
            MarkerClusterLayerWidget(
                options: MarkerClusterLayerOptions(
                   maxClusterRadius: 45,
                    size: const Size(40, 40),
                    anchor: AnchorPos.align(AnchorAlign.center),
                    fitBoundsOptions: const FitBoundsOptions(
                    //  padding: EdgeInsets.all(48.0),
                      maxZoom: 15,
                    ),
                    markers: markers,
                    builder: (context, markers) {
                     return Container(
                     //  padding: const EdgeInsets.all(12.0),
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                         color: Colors.deepOrange.withOpacity(0.5),
                       ),
                      // color: Colors.white,
                     //  height: 150,
                     //  width: 150,
                     //   child: Column(
                     //     mainAxisAlignment: MainAxisAlignment.center,
                     //     mainAxisSize: MainAxisSize.max,
                     //     children: const [
                     //      Icon(Icons.account_circle_rounded, size: 18,),
                     //      SizedBox(height: 4.0,),
                     //       Text("", style: const TextStyle(fontFamily: 'Cera Pro', fontSize: 18),),
                     //       const SizedBox(height: 6.0,),
                     //       Text("Latitude: ${persons[i]!.marker.point.latitude}"),
                     //       Text("Longitude: ${persons[i]!.marker.point.longitude}"),
                     //     ],
                     //   ),
                     );
                    }))
          ],
        )
    ) : Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
          CircularProgressIndicator(color: Colors.deepOrange),
          SizedBox(height: 24),
          Text("Pinpointing your location..")
          ],
        ));
  }
}
