import 'package:advanceprojectflutter/dummy_data/dummy_data.dart';
import '../model/ride/ride.dart';

void main() {
  DateTime dateTime = DateTime.now();
  List<Ride> rides = fakeRides; // Renamed variable to avoid shadowing

  // Print today's rides
  List<Ride> todayRides = getTodayRides(rides, dateTime);
  print(todayRides
      .map((ride) => ride.toString())
      .toList()); // Convert rides to string for better readability
}

/// Filters and returns rides that occur on the same day as the reference date.
List<Ride> getTodayRides(List<Ride> rides, DateTime referenceDate) {
  if (rides.isEmpty) return []; // Handle empty list case explicitly

  return rides
      .where((ride) => isSameDate(ride.departureDate, referenceDate))
      .toList();
}

/// Checks if two dates are the same (ignores time components).
bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
