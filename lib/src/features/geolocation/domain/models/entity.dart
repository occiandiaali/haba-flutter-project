import 'package:flutter_map/flutter_map.dart';
import 'package:flutter/material.dart';
import 'package:haba/src/features/geolocation/data/repository/dummy_users.dart';
import 'package:latlong2/latlong.dart';

class Entity {
  int index;
  String label;
  Marker marker;

  Entity({required this.index, required this.label, required this.marker});
}


