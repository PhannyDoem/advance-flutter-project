import 'package:advanceprojectflutter/screens/location_picker_screen.dart';
import 'package:advanceprojectflutter/service/location_service.dart';
import 'package:advanceprojectflutter/service/repository/local_location_repository.dart';
import 'package:advanceprojectflutter/service/repository/location_repository.dart';
import 'package:flutter/material.dart';

void main() {
  LocationRepository repository = LocalLocationRepository();
  LocationService service = LocationService(repository);

  runApp(
    MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: LocationPickerScreen(
            initLocation: null, service: service,
          ),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final LocationService service;

  const MyApp({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: LocationPickerScreen(service: service),
        ),
      ),
    );
  }
}
