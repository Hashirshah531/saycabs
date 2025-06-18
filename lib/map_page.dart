import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter_web/google_maps_flutter_web.dart';

import 'map_controller.dart';


class MapPage extends StatefulWidget {
  @override
  State<MapPage> createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  final MapController _controller = MapController();
  final Completer<GoogleMapController> _mapController = Completer();

  CameraPosition _initialPosition = CameraPosition(
    // target: LatLng(37.4219, -122.0840),
    // zoom: 14,
  );

  Set<Marker> _markers = {};
  bool _loading = true;

  Future<void> _initMap() async {
    try {
      final position = await _controller.getCurrentLocation();
      final markers = await _controller.getMockMarkers();

      final GoogleMapController mapController = await _mapController.future;
      mapController.animateCamera(CameraUpdate.newLatLng(
        LatLng(position.latitude, position.longitude),
      ));

      setState(() {
        _initialPosition = CameraPosition(
          // target: LatLng(position.latitude, position.longitude),
          // zoom: 15,
        );
        _markers = Set.from(markers);
        _loading = false;
      });
    } catch (e) {
      setState(() {
        _loading = false;
      });
      print("Error: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _initMap();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Map Example')),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
        initialCameraPosition: _initialPosition,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        markers: _markers,
        onMapCreated: (GoogleMapController controller) {
          _mapController.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _initMap,
        child: Icon(Icons.refresh),
      ),
    );
  }
}

class LatLng {
  LatLng(double latitude, double longitude);
}

class Marker {
}

class CameraUpdate {
  static newLatLng(latLng) {}
}

extension on GoogleMapController {
  void animateCamera(newLatLng) {}
}

GoogleMap({required CameraPosition initialCameraPosition, required bool myLocationEnabled, required bool myLocationButtonEnabled, required bool zoomControlsEnabled, required Set<dynamic> markers, required Null Function(GoogleMapController controller) onMapCreated}) {
}

class CameraPosition {
}
