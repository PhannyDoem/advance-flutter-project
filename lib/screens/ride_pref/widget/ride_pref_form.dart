import 'package:advanceprojectflutter/screens/location_picker_screen.dart';
import 'package:advanceprojectflutter/theme/theme.dart';
import 'package:advanceprojectflutter/utils/animations_util.dart';
import 'package:advanceprojectflutter/utils/date_time_util.dart';
import 'package:advanceprojectflutter/widgets/display/bla_divider.dart';
import 'package:advanceprojectflutter/widgets/inputs/bla_button.dart';
import 'package:flutter/material.dart';


import '../../../model/ride/locations.dart';
import '../../../model/ride_pref/ride_pref.dart';

class RidePrefForm extends StatefulWidget {
  final RidePref? initRidePref;

  const RidePrefForm({super.key, this.initRidePref});

  @override
  State<RidePrefForm> createState() => _RidePrefFormState();
}

class _RidePrefFormState extends State<RidePrefForm> {
  Location? departure;
  late DateTime departureDate;
  Location? arrival;
  late int requestedSeats;

  @override
  void initState() {
    super.initState();
    if (widget.initRidePref != null) {
      departure = widget.initRidePref!.departure;
      departureDate = widget.initRidePref!.departureDate;
      arrival = widget.initRidePref!.arrival;
      requestedSeats = widget.initRidePref!.requestedSeats;
    } else {
      departure = null;
      departureDate = DateTime.now();
      arrival = null;
      requestedSeats = 1;
    }
  }

  void swapLocations() {
    setState(() {
      Location? temp = departure;
      departure = arrival;
      arrival = temp;
    });
  }

  Future<void> onDepartureTap() async {
    final newDepartureLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        LocationPickerScreen(initLocation: departure),
      ),
    );

    if (newDepartureLocation != null) {
      setState(() {
        departure = newDepartureLocation;
      });
    }
  }

  Future<void> onArrivalTap() async {
    final newArrivalLocation = await Navigator.of(context).push<Location>(
      AnimationUtils.createBottomToTopRoute(
        LocationPickerScreen(initLocation: arrival),
      ),
    );

    if (newArrivalLocation != null) {
      setState(() {
        arrival = newArrivalLocation;
      });
    }
  }

  void onDepartureDateTap() {
    // Open a date picker dialog
    showDatePicker(
      context: context,
      initialDate: departureDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    ).then((selectedDate) {
      if (selectedDate != null) {
        setState(() {
          departureDate = selectedDate;
        });
      }
    });
  }

  void onReqTap() {
    // Show a dialog to select the number of seats
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Number of Seats'),
        content: SizedBox(
          width: double.minPositive,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) => ListTile(
              title: Text('${index + 1} seat(s)'),
              onTap: () {
                setState(() {
                  requestedSeats = index + 1;
                });
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }

  void onSearchTap() {
    if (departure == null || arrival == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content:
                Text('Please select both departure and arrival locations')),
      );
      return;
    }

    // Perform search action with the selected preferences
    print('Searching with preferences:');
    print('Departure: ${departure?.name}');
    print('Arrival: ${arrival?.name}');
    print('Departure Date: $departureDate');
    print('Requested Seats: $requestedSeats');
  }

  Widget baseInput({
    required Icon icon,
    required String text,
    required Color textColor,
    required void Function() onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: BlaSpacings.m,
          vertical: BlaSpacings.m,
        ),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: textColor, fontWeight: FontWeight.w500),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        baseInput(
          icon: Icon(Icons.radio_button_off_rounded,
              color: BlaColors.neutralLight),
          text: departure?.name ?? 'Leaving From',
          textColor: departure == null ? BlaColors.neutralLight : Colors.black,
          onTap: onDepartureTap,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
          child: BlaDivider(),
        ),
        baseInput(
          icon: Icon(Icons.radio_button_off_rounded,
              color: BlaColors.neutralLight),
          text: arrival?.name ?? 'Going To',
          textColor: arrival == null ? BlaColors.neutralLight : Colors.black,
          onTap: onArrivalTap,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
          child: BlaDivider(),
        ),
        baseInput(
          icon: Icon(Icons.calendar_month_rounded,
              color: BlaColors.neutralLight),
          text: DateTimeUtils.formatDateTime(departureDate),
          textColor: Colors.black,
          onTap: onDepartureDateTap,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: BlaSpacings.l),
          child: BlaDivider(),
        ),
        baseInput(
          icon: Icon(Icons.person_outline_rounded,
              color: BlaColors.neutralLight),
          text: '$requestedSeats seat(s)',
          textColor: Colors.black,
          onTap: onReqTap,
        ),
        const SizedBox(height: BlaSpacings.l),
        BlaButton(
          const Text('Search'),
          isPrimary: true,
          onPressed: onSearchTap,
        ),
      ],
    );
  }
}
