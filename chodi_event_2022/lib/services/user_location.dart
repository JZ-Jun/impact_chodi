import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class UserLocation {
  Future<Map<String, double>> determinePosition() async {
    bool? serviceEnabled;

    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      Fluttertoast.showToast(msg: 'Please keep location on');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(msg: 'Location Permission is denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      Fluttertoast.showToast(msg: 'Location Permission is denied Forever');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

/*
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(position.latitude, position.longitude);
      Placemark place = placemarks[0];

      log('Place: ' + position.toString());
      log('Current position ' + place.locality.toString());
      // ignore: empty_catches
    } catch (e) {}
    */
    return {'latitude': position.latitude, 'longtitude': position.longitude};
  }
}
