import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(RandomNumberApp());
}

class RandomNumberApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin Pannel',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: RandomNumberHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class RandomNumberHomePage extends StatefulWidget {
  @override
  _RandomNumberHomePageState createState() => _RandomNumberHomePageState();
}

class _RandomNumberHomePageState extends State<RandomNumberHomePage> {
  int _randomNumber = 0;

  void _generateRandomNumber() {
    setState(() {
      _randomNumber = Random().nextInt(100); // Generates a number from 0 to 99
    });
  }

  @override
  void initState() {
    super.initState();
    _generateRandomNumber(); // Generate once on startup
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Saycaps'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Map Switch:', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Text('$_randomNumber',
                style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold)),
            SizedBox(height: 40),
            ElevatedButton.icon(
              onPressed: _generateRandomNumber,
              icon: Icon(Icons.refresh),
              label: Text('Google Maps'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
