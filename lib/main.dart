import 'package:flutter/material.dart';
import './Screen/add_place_screen.dart';
import './providers/place_provider.dart';
import './Screen/places_list_screen.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => PlaceProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.brown,
          accentColor: Colors.brown[300],
        ),
        home: PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (BuildContext context) => AddPlaceScreen(),
        },
      ),
    );
  }
}
