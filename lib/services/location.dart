import 'package:geolocator/geolocator.dart';

class Location{
  double latitutde=0;
  double longitude=0;
  Future<void> getCurrentLocation()
  async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high) ;
    latitutde=position.latitude;
    longitude=position.longitude;

  }
}