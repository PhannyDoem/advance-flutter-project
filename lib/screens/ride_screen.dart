import 'package:advanceprojectflutter/model/ride/ride.dart';
import 'package:advanceprojectflutter/model/ride_pref/ride_pref.dart';
import 'package:advanceprojectflutter/screens/ride_tile.dart';
import 'package:advanceprojectflutter/service/ride_service.dart';
import 'package:advanceprojectflutter/theme/theme.dart';
import 'package:advanceprojectflutter/utils/date_time_util.dart';
import 'package:advanceprojectflutter/widgets/inputs/bla_button.dart';
import 'package:flutter/material.dart';

class RideScreen extends StatefulWidget {
  const RideScreen({super.key, required this.initRidePref});

  final RidePref initRidePref;

  @override
  State<RideScreen> createState() => _RideScreenState();
}

class _RideScreenState extends State<RideScreen> {
  late RidePref ridePref;
  List<Ride> foundRides = [];

  String get prefTitle =>
      "${ridePref.departure.name} -> ${ridePref.arrival.name} on ${ridePref.departureDate.toIso8601String()}";

  String get prefSubtitle =>
      "${DateTimeUtils.formatDateTime(ridePref.departureDate)}, ${ridePref.requestedSeats} seats, passengers: ${ridePref.requestedSeats > 1 ? "s" : " "}";

  @override
  void initState() {
    super.initState();
    ridePref = widget.initRidePref;
    ridePref = widget.initRidePref;
    super.initState();
  }

  void findRides() {
    foundRides = RideService.getRidesFor(ridePref);
    debugPrint(foundRides.toString());
  }

  void onFilterPressed() {}

  void onRidePressed() {}

  void onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(BlaSpacings.m),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: BlaSpacings.m, 
                  vertical: BlaSpacings.s
                  ),
              decoration: BoxDecoration(
                color: Colors.transparent,
                border: Border.all(),
                borderRadius: BorderRadius.circular(BlaSpacings.radius),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: onBackPressed,
                    icon: Icon(Icons.arrow_back_ios_new_rounded,
                    color: BlaColors.iconNormal,
                    )
                  ),
                  Expanded(
                    child: InkWell(
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      onTap: onFilterPressed,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            prefTitle,
                            style: BlaTextStyles.label.copyWith(
                              color: BlaColors.iconNormal,
                            )
                          ),
                          Text(
                            prefSubtitle,
                            style: BlaTextStyles.label.copyWith(
                              color: BlaColors.textLight,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: BlaButton(
                      Text("Filter"),
                      onPressed: onFilterPressed,
                      isPrimary: false,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: foundRides.length,
                itemBuilder: (ctx, index) => RideTile(ride: foundRides[index], onTap: (){})
              ),
            )
          ],
        ),  
      ),
    );
  }
}
