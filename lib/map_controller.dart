
import 'package:geolocator/geolocator.dart';

import 'locationservice.dart';
import 'map_page.dart';


class MapController {
  Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception("Location services are disabled.");
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied || permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
      if (permission != LocationPermission.whileInUse && permission != LocationPermission.always) {
        throw Exception("Location permissions are denied.");
      }
    }

    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Marker>> getMockMarkers() async {
    final data = await LocationService.getMockPlaces();
    return data.map((place) {
      return Marker(
        // markerId: MarkerId(place['id']),
        // position: LatLng(place['lat'], place['lng']),
        // infoWindow: InfoWindow(title: place['name']),
      );
    }).toList();
  }
}
