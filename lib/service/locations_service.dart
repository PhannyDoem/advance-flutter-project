import 'package:advanceprojectflutter/model/ride/locations.dart' show Location;
import 'package:advanceprojectflutter/service/repository/location_repository.dart';

import '../dummy_data/dummy_data.dart';

////
///   This service handles:
///   - The list of available rides
///
class LocationsService {
  static const List<Location> availableLocations = fakeLocations;
  // TODO for now fake data

  final LocationRepository repository;

  LocationsService(this.repository);

  List<Location> getLocations() {
    return repository.getLocations();
  }
}
