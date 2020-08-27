import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import '../models/place.dart';

class MapPicker extends StatefulWidget {
  final PlaceLocation initialPosition;
  final bool isSelecting;

  const MapPicker(
      {this.initialPosition =
          const PlaceLocation(latitude: 0.3329, longitude: 32.5499),
      this.isSelecting = false});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('pick Location'),
      ),
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(widget.initialPosition.latitude,
                widget.initialPosition.longitude)),
      ),
    );
  }
}
