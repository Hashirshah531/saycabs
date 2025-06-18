import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:url_launcher/url_launcher.dart';

class BookingForm extends StatefulWidget {
  const BookingForm({super.key});

  @override
  State<BookingForm> createState() => _BookingFormState();
}

class _BookingFormState extends State<BookingForm> {
  String? selectedVehicle;
  int? selectedPassengerCount;

  final TextEditingController pickupLocationController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController pickupDateController = TextEditingController();
  final TextEditingController pickupTimeController = TextEditingController();

  Future<void> _handlePickupLocationTap(BuildContext context) async {
    try {
      final position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}';

      await launchUrl(Uri.parse(googleMapsUrl), webOnlyWindowName: '_blank');

      _showManualLocationInputDialog(context);
    } catch (e) {
      print('Auto location failed: $e');
      _showManualLocationInputDialog(context);
    }
  }

  void _showManualLocationInputDialog(BuildContext context) {
    final latController = TextEditingController();
    final lngController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Enter Coordinates'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: latController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Latitude'),
            ),
            TextField(
              controller: lngController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Longitude'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () async {
              Navigator.of(context).pop();
              final lat = double.tryParse(latController.text);
              final lng = double.tryParse(lngController.text);

              if (lat != null && lng != null) {
                final placemarks = await placemarkFromCoordinates(lat, lng);
                if (placemarks.isNotEmpty) {
                  final place = placemarks.first;
                  final address =
                      "${place.name}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
                  setState(() {
                    pickupLocationController.text = address;
                  });
                }
              }
            },
            child: const Text('Confirm'),
          ),
        ],
      ),
    );
  }

  Widget _buildFormField(String label, IconData icon, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () => _handlePickupLocationTap(context),
                  child: AbsorbPointer(
                    child: _buildFormField('Pickup Location', Icons.location_on, pickupLocationController),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.add_circle),
              const Text("Via", style: TextStyle(fontWeight: FontWeight.bold)),
              const SizedBox(width: 10),
              Expanded(child: _buildFormField('Destination', Icons.flag, destinationController)),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(child: _buildFormField('Pickup Date', Icons.calendar_today, pickupDateController)),
              const SizedBox(width: 10),
              Expanded(child: _buildFormField('Pickup Time', Icons.access_time, pickupTimeController)),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: DropdownButtonFormField<int>(
                  decoration: const InputDecoration(
                    labelText: 'Passengers',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  value: selectedPassengerCount,
                  items: List.generate(12, (index) => index + 1).map((count) {
                    return DropdownMenuItem(
                      value: count,
                      child: Text('$count Passenger${count > 1 ? 's' : ''}'),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedPassengerCount = value;
                    });
                  },
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Vehicle Type',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.directions_car),
                  ),
                  value: selectedVehicle,
                  items: ['Estate Car', 'Executive MPV', '10 Seater', '12 Seater'].map((type) {
                    return DropdownMenuItem(
                      value: type,
                      child: Text(type),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedVehicle = value;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.amber,
                padding: const EdgeInsets.symmetric(vertical: 15),
              ),
              onPressed: () {
                // TODO: Add booking logic here
              },
              child: const Text(
                'BOOK NOW',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
