import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';

class MarkerDetails extends StatelessWidget {
  const MarkerDetails({Key? key, required this.identity, required this.coords}) : super(key: key);
  final String identity;
  final LatLng coords;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 40,),
            const Icon(Icons.account_box_outlined, size: 120,),
            const SizedBox(height: 20,),
            Text(identity, style: const TextStyle(fontSize: 32, fontFamily: 'Cera Pro', fontWeight: FontWeight.bold),),
            const SizedBox(height: 30,),
            Card(
              elevation: 10,
              shape: const RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.deepOrangeAccent,
                ),
              ),
              child: Container(
                padding: const EdgeInsets.all(12.0),
                height: 64,
                child: Text("Location: ${coords.latitude}, ${coords.longitude}"),
              ),
            ),
            const SizedBox(height: 48,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.deepOrangeAccent,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.chat_bubble_outline_rounded, color: Colors.white,)),
                ),
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.deepOrangeAccent,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.phone_outlined, color: Colors.white)),
                ),
                CircleAvatar(
                  radius: 30.0,
                  backgroundColor: Colors.deepOrangeAccent,
                  child: IconButton(
                      onPressed: () {},
                      icon: const Icon(Icons.video_call_outlined, color: Colors.white)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
