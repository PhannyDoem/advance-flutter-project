import 'package:advanceprojectflutter/model/ride/ride.dart';
import 'package:flutter/material.dart';

class RideTile extends StatelessWidget {
  final Ride ride;
  final void Function() onTap;

  const RideTile({super.key, required this.ride, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        child: SizedBox(
          width: double.infinity,
          height: 100,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Departure: ${ride.departureLocation.name}'),
              Text('Arrival: ${ride.arrivalLocation.name}'),
              Text('Time: ${ride.departureDate}'),
              Text('Seats: ${ride.availableSeats}'),
            ],
          ),
        ),
      ),
    );
  }
}
