import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class PopupViewWidget extends StatefulWidget {
  const PopupViewWidget({Key? key, required this.lat, required this.lon, required this.msg}) : super(key: key);
  final String lat;
  final String lon;
  final String msg;

  @override
  State<PopupViewWidget> createState() => _PopupViewWidgetState();
}

class _PopupViewWidgetState extends State<PopupViewWidget> {
  String get msg => msg;

  get lat => this.lat;
  get lon => this.lon;



  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      color: Colors.white,
      height: 120,
      width: 160,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(msg, style: const TextStyle(fontFamily: 'Cera Pro', fontSize: 18),),
          const SizedBox(height: 6.0,),
          Text("Latitude: $lat"),
          Text("Longitude: $lon")
        ],
      ),
    );
  }
}
