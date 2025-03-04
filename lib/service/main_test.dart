import 'package:advanceprojectflutter/screens/location_picker_screen.dart';
import 'package:advanceprojectflutter/service/locations_service.dart';
import 'package:advanceprojectflutter/service/repository/local_location_repository.dart';
import 'package:advanceprojectflutter/service/repository/location_repository.dart';
import 'package:flutter/material.dart';

void main() {
  LocationRepository repository = LocalLocationRepository();
  LocationsService service = LocationsService(repository);

  runApp(
    MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: LocationPickerScreen(
            initLocation: null,
          ),
        ),
      ),
    ),
  );
}
