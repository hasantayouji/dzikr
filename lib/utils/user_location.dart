import 'package:dzikr/models/lokasi.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserLocation {
  Future<Lokasi> getLocation() async {
    bool locationEnabled = await Geolocator().isLocationServiceEnabled();
    SharedPreferences preferences = await SharedPreferences.getInstance();
    if (locationEnabled) {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      double lat = position.latitude;
      double long = position.longitude;
      preferences.setDouble('lat', position.latitude);
      preferences.setDouble('long', position.longitude);
      return Lokasi(latitude: lat, longitude: long);
    } else {
      double lat = preferences.getDouble('lat') ?? -6.242092;
      double long = preferences.getDouble('long') ?? 106.651836;
      return Lokasi(latitude: lat, longitude: long);
    }
  }

  Future<String> getPlaceMark(double lat, double long) async {
    List<Placemark> placeMark =
        await Geolocator().placemarkFromCoordinates(lat, long);
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString('city', placeMark[0].subLocality);
    return placeMark[0].subLocality;
  }
}
