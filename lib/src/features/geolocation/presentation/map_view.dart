import 'package:flutter/material.dart';
import 'package:haba/src/features/geolocation/data/repository/dummy_users.dart';
import 'package:latlong2/latlong.dart';
import 'package:location/location.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:url_launcher/url_launcher.dart';

class MapView extends StatefulWidget {
  const MapView({Key? key}) : super(key: key);

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final Location location = Location();
  bool coordsSet = false;

  late LatLng _pinPoint;
  List<Marker> markers = [];

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

  void _fakeCoords() {
    late Marker m;
    for (var i = 0; i < marks.length; i++) {
      m = Marker(
        point: marks[i],
        width: 80,
        height: 85,
        builder: (context) => const Icon(Icons.location_on_rounded, color: Colors.teal,),
      );
      markers.add(m);
    }
   // return m;
  }

  @override
  void initState() {
    super.initState();
    if (mounted) {
      _currentLocation();
      _fakeCoords();
    }
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
            maxZoom: 15,
            minZoom: 8,
          ),
          nonRotatedChildren: [
            RichAttributionWidget(attributions: [
              TextSourceAttribution(
                'OpenStreetMap contributors',
                onTap: () => launchUrl(Uri.parse('https://openstreetmap.org/copyright')),
              ),
            ]),
          ],
          children: [
            TileLayer(
              urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: const ['a', 'b', 'c'],
              userAgentPackageName: 'com.example.app',
            ),
            MarkerLayer(
              markers: [
                Marker(
                  point: _pinPoint,
                  width: 80,
                  height: 85,
                  builder: (context) => const Icon(Icons.location_on_rounded, color: Colors.deepOrange,),
                ),
                ...markers
              ],
            ),
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
