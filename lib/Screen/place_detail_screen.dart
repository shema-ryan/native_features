import 'package:flutter/material.dart';
import 'package:nativefeatures/Screen/mapScreen.dart';
import 'package:nativefeatures/providers/place_provider.dart';
import 'package:provider/provider.dart';

class PlaceDetails extends StatelessWidget {
  static const String routeName = '/detailed';
  @override
  Widget build(BuildContext context) {
    final String id = ModalRoute.of(context).settings.arguments;
    final selectedPlace =
        Provider.of<PlaceProvider>(context, listen: false).findById(id);
    return Scaffold(
      appBar: AppBar(
        title: Text(selectedPlace.title),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            child: Image.file(
              selectedPlace.image,
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            selectedPlace.location.address,
            textAlign: TextAlign.center,
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) => MapPicker(
                        initialPosition: selectedPlace.location,
                        isSelecting: false,
                      )));
            },
            child: Text('Map view'),
          ),
        ],
      ),
    );
  }
}
