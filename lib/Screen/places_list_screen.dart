import 'package:flutter/material.dart';
import 'package:nativefeatures/Screen/place_detail_screen.dart';
import 'package:nativefeatures/providers/place_provider.dart';
import 'package:provider/provider.dart';
import './add_place_screen.dart';

class PlacesListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        title: Text('Favorites places'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<PlaceProvider>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapShot) => snapShot.connectionState ==
                ConnectionState.waiting
            ? Center(child: CircularProgressIndicator())
            : Consumer<PlaceProvider>(
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Please add a place..',
                        style: TextStyle(fontSize: 18),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      CircularProgressIndicator(),
                    ],
                  ),
                ),
                builder: (BuildContext context, favList, ch) => favList
                            .items.length <=
                        0
                    ? ch
                    : ListView.builder(
                        itemCount: favList.items.length,
                        itemBuilder: (BuildContext context, int index) => Card(
                              shadowColor: Colors.brown,
                              elevation: 2.0,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: ListTile(
                                onTap: () {
                                  /* go to detailed screen */
                                  Navigator.of(context).pushNamed(
                                      PlaceDetails.routeName,
                                      arguments: favList.items[index].id);
                                },
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(favList.items[index].image),
                                ),
                                title: Text(favList.items[index].title),
                                subtitle:
                                    Text(favList.items[index].location.address),
                              ),
                            )),
              ),
      ),
    );
  }
}
