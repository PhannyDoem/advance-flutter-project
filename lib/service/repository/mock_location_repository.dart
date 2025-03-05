import 'package:advanceprojectflutter/model/enums/country.dart';
import 'package:advanceprojectflutter/model/ride/locations.dart';
import 'package:advanceprojectflutter/service/repository/location_repository.dart';

class MockLocationRepository implements LocationRepository {
  @override
  List<Location> getLocations() {
    return [
      Location(name: "Phnom Penh", country: Country.cambodia),
      Location(name: "Siem Reap", country: Country.cambodia),
      Location(name: "Battambang", country: Country.cambodia),
      Location(name: "Sihanoukville", country: Country.cambodia),
      Location(name: "Kampot", country: Country.cambodia),
    ];
  }
}