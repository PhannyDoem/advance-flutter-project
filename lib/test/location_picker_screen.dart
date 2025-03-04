import 'package:advanceprojectflutter/screens/location_picker_screen.dart';
import 'package:flutter/material.dart';


void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: SafeArea(child: LocationPickerScreen(initLocation: null)),
      ),
    ),
  );
}
