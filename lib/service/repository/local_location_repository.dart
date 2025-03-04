
import 'package:advanceprojectflutter/dummy_data/dummy_data.dart';
import 'package:advanceprojectflutter/model/ride/locations.dart';
import 'package:advanceprojectflutter/service/repository/location_repository.dart';

class LocalLocationRepository implements LocationRepository{
  @override
  List<Location> getLocations() {
    return fakeLocations;
  }
}