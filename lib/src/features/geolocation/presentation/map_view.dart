import 'package:flutter/material.dart';
import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
import 'package:haba/src/features/geolocation/data/repository/dummy_users.dart';
import 'package:haba/src/features/geolocation/presentation/map_marker_widget.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';

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
  late List<Marker> markers;

  final PopupController _popupController = PopupController();

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
    return locationData;
  }

  var persons = <int, Entity>{};

  late PopupMarkerLayerWidget n;
  late Marker m;

  void _generateMarkers() {
    markers = [];
    for (var i = 0; i < marks.length; i++) {

      final latLng = LatLng(marks[i].latitude, marks[i].longitude);

      markers.add(
        Marker(
            height: 40,
            width: 40,
            point: latLng,
            builder: (context) => MapMarkerWidget(
              text: names[i],
              toolTipTap: () {
                print("Pressed ${names[i]}");
              },
              iconColour: latLng != _pinPoint ? Colors.teal : Colors.deepOrange,
            )
        ),
      );
    }
  }

  @override
  void initState() {
    if (mounted) {
      _currentLocation();
      _generateMarkers();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return coordsSet == true ? SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: FlutterMap(
          options: MapOptions(
            //  center: LatLng(6.6970, 3.4182),
              center: _pinPoint,
              zoom: 12.0,
              maxZoom: 16.0,
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
                      maxZoom: 15,
                    ),
                    markers: markers,
                    builder: (context, markers) {
                     return Container(
                       decoration: BoxDecoration(
                         borderRadius: BorderRadius.circular(20),
                       //  color: Colors.deepOrange.withOpacity(0.5),
                         color: Colors.black38.withOpacity(0.3),
                       ),
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
