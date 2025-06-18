class LocationService {
  static Future<List<Map<String, dynamic>>> getMockPlaces() async {
    await Future.delayed(Duration(seconds: 1));
    return [
      {
        'id': 'p1',
        'name': 'Coffee Shop',
        'lat': 37.4219,
        'lng': -122.0839,
      },
      {
        'id': 'p2',
        'name': 'Library',
        'lat': 37.4223,
        'lng': -122.0818,
      },
      {
        'id': 'p3',
        'name': 'Pizza Place',
        'lat': 37.4245,
        'lng': -122.0822,
      },
    ];
  }
}
