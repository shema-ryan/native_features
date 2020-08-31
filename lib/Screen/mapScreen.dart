import 'package:google_map_polyline/google_map_polyline.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/material.dart';
import '../models/place.dart';

class MapPicker extends StatefulWidget {
  final PlaceLocation initialPosition;
  final bool isSelecting;

  MapPicker(
      {this.initialPosition =
          const PlaceLocation(latitude: 0.3329, longitude: 32.5499),
      this.isSelecting = false});

  @override
  _MapPickerState createState() => _MapPickerState();
}

class _MapPickerState extends State<MapPicker> {
  Set<Polyline> poly = {};
  List<LatLng> cordinates;
  GoogleMapController controller;
  GoogleMapPolyline polyine =
      GoogleMapPolyline(apiKey: 'AIzaSyAb3gV4RogsdL9SkFYMHXdzAsNFo7C_Hpc');
  LatLng pickedLocation;
  void selectedLocation(LatLng location) {
    setState(() {
      pickedLocation = location;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true, title: Text('pick Location'), actions: [
        if (widget.isSelecting)
          IconButton(
            icon: Icon(Icons.check),
            onPressed: pickedLocation == null
                ? null
                : () {
                    Navigator.of(context).pop(pickedLocation);
                  },
          ),
      ]),
      body: GoogleMap(
        mapType: MapType.normal,
        onMapCreated: (controller) async {
          cordinates = await polyine.getCoordinatesWithLocation(
              origin: LatLng(40.6782, -73.9442),
              destination: LatLng(40.6944, -73.9212),
              mode: RouteMode.driving);
          poly.add(Polyline(
              polylineId: PolylineId('r1'),
              color: Colors.brown,
              points: cordinates,
              visible: true,
              startCap: Cap.roundCap,
              endCap: Cap.buttCap));
        },
        polylines: {},
        markers: (pickedLocation == null && widget.isSelecting == true)
            ? null
            : {
                Marker(
                  position: pickedLocation ??
                      LatLng(widget.initialPosition.latitude,
                          widget.initialPosition.longitude),
                  markerId: MarkerId('p1'),
                ),
              },
        onTap: widget.isSelecting ? selectedLocation : null,
        initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(widget.initialPosition.latitude,
                widget.initialPosition.longitude)),
      ),
    );
  }
}
