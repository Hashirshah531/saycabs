import 'package:flutter/material.dart';
import 'package:saycabs/dash.dart';
import 'dart:html';
import 'dart:ui' as ui;

void main() {
  // ui.platformViewRegistry.registerViewFactory(
  //   'google-map-div',
  //       (int viewId) => DivElement()..id = 'google-map-div',
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const AlphaCarsDashboard(),
    );
  }
}

