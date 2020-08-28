import 'package:http/http.dart' as http;
import 'dart:convert';

const google_API_KEY = 'AIzaSyAb3gV4RogsdL9SkFYMHXdzAsNFo7C_Hpc';

class LocationHelper {
  static String getLocationPreview({double latitude, double longitude}) {
    return 'https://maps.googleapis.com/maps/api/staticmap?center=&$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:brown%7Clabel:A%7C$latitude,$longitude&key=$google_API_KEY';
  }

  static Future<String> getAddressR(double lat, double long) async {
    final String url =
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$long&key=$google_API_KEY';
    final response = await http.get(url);
    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
