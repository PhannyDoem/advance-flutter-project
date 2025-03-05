import 'dart:developer';

import 'package:advanceprojectflutter/screens/location_picker_screen.dart';
import 'package:advanceprojectflutter/service/location_service.dart';
import 'package:advanceprojectflutter/service/repository/location_repository.dart';
import 'package:flutter/material.dart';

void main() {
  UserTag userTag = getCurrentTag();
  LocationService locationService = convertToLocationService(userTag);

  runApp(
    MaterialApp(
      home: Scaffold(
        body: SafeArea(
            child: LocationPickerScreen(
                initLocation: null, service: locationService)),
      ),
    ),
  );
}

LocationService convertToLocationService(UserTag userTag) {
  // Implement the conversion logic
  return LocationService(userTag as LocationRepository);
}
