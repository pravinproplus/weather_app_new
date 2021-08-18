import 'package:geolocator/geolocator.dart';

//Get GPS Location from De
class GPSLocation {
  Position? position;
  double? latitude;
  double? longtitude;
  Future<void> getLocationData() async {
    try {
      position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      latitude = position!.latitude;
      longtitude = position!.longitude;
    } catch (e) {
      print(e);
    }
  }
}
