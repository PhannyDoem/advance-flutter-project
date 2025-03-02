import 'package:advanceprojectflutter/dummy_data/dummy_data.dart';

import '../model/ride/ride.dart';

void main() {
  DateTime dateTime = DateTime.now();
  List<Ride> ride = fakeRides;

  print(getTodayRides(ride, dateTime));
}

List<Ride> getTodayRides(List<Ride> rides, DateTime referenceDate) {
  return rides
      .where((ride) => isSameDate(ride.departureDate, referenceDate))
      .toList();
}

bool isSameDate(DateTime date1, DateTime date2) {
  return date1.year == date2.year &&
      date1.month == date2.month &&
      date1.day == date2.day;
}
