import 'package:flutter/material.dart';
import '../models/place.dart';
import 'dart:io';
import '../helper/DbHelper.dart';
import '../helper/LocationHelper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> addPlace(String title, File image, PlaceLocation picked) async {
    final String address =
        await LocationHelper.getAddressR(picked.latitude, picked.longitude);
    PlaceLocation updatedPlace = PlaceLocation(
        latitude: picked.latitude,
        longitude: picked.longitude,
        address: address);
    Place newPlace = Place(
      title: title,
      id: DateTime.now().toString(),
      image: image,
      location: updatedPlace,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
      'loc_lat': newPlace.location.latitude,
      'loc_long': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    List dbRetrieve = await DbHelper.fetch('user_places');

//    _items = dbRetrieve
//        .map((e) => Place(
//              title: e['title'],
//              id: e['id'],
//              image: File(e['image']),
//              location: null,
//            ))
//        .toList();
//    notifyListeners();

    List<Place> retrieve = [];
    dbRetrieve.forEach((element) {
      retrieve.add(Place(
        id: element['id'],
        image: File(element['image']),
        location: PlaceLocation(
            longitude: element['loc_long'],
            latitude: element['loc_lat'],
            address: element['address']),
        title: element['title'],
      ));
    });
    _items = retrieve;
    notifyListeners();
  }
}
