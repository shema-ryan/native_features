import 'package:flutter/material.dart';
import '../models/place.dart';
import 'dart:io';
import '../helper/DbHelper.dart';

class PlaceProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return _items;
  }

  void addPlace(String title, File image) {
    Place newPlace = Place(
      title: title,
      id: DateTime.now().toString(),
      image: image,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DbHelper.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image.path,
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
        location: null,
        title: element['title'],
      ));
    });
    _items = retrieve;
    notifyListeners();
  }
}
