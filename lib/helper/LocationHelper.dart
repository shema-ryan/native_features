const google_API_KEY = 'AIzaSyAb3gV4RogsdL9SkFYMHXdzAsNFo7C_Hpc';

class LocationHelper {
  static String getLocationPreview({double latitude, double longitude}) {
    print('$latitude , $longitude');
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=13&size=600x300&maptype=roadmap&markers=color:brown%7Clabel:A%7C$latitude,$longitude&key=$google_API_KEY';
  }
}
