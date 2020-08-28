import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import '../Screen/mapScreen.dart';
import '../helper/LocationHelper.dart';

class InputLocation extends StatefulWidget {
  final Function selectAddress;

  const InputLocation(this.selectAddress);

  @override
  _InputLocationState createState() => _InputLocationState();
}

class _InputLocationState extends State<InputLocation> {
  String imagePreviewUrl;
  void getPreview(double lat, double long) {
    String staticImageUrl = LocationHelper.getLocationPreview(
      latitude: lat,
      longitude: long,
    );
    setState(() {
      imagePreviewUrl = staticImageUrl;
    });
  }

  Future<void> _getUserLocation() async {
    LocationData location = await Location().getLocation();
    getPreview(location.latitude, location.longitude);
    widget.selectAddress(location.latitude, location.longitude);
  }

  Future<void> getLocationOnMap() async {
    final LatLng mapLocation =
        await Navigator.of(context).push<LatLng>(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (BuildContext context) => MapPicker(
                  isSelecting: true,
                )));
    if (mapLocation == null) {
      return;
    }
    getPreview(mapLocation.latitude, mapLocation.longitude);
    widget.selectAddress(mapLocation.latitude, mapLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(width: 2, color: Colors.brown)),
          alignment: Alignment.center,
          width: double.infinity,
          child: imagePreviewUrl == null
              ? Text(
                  'no Location taken ',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  imagePreviewUrl,
                  fit: BoxFit.fill,
                  height: 250,
                ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RaisedButton.icon(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: _getUserLocation,
                icon: Icon(Icons.location_on),
                label: Text('Current Location')),
            RaisedButton.icon(
                color: Theme.of(context).primaryColor,
                textColor: Colors.white,
                onPressed: getLocationOnMap,
                icon: Icon(Icons.map),
                label: Text('Select on Map')),
          ],
        ),
      ],
    );
  }
}
