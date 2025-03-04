import 'package:flutter/material.dart';
import '../../../model/ride_pref/ride_pref.dart';
import '../../../theme/theme.dart';
import '../../../utils/date_time_util.dart';

class RidePrefHistoryTile extends StatelessWidget {
  final RidePref ridePref;
  final VoidCallback? onPressed;

  const RidePrefHistoryTile({
    super.key,
    required this.ridePref,
    this.onPressed,
  });

  String get title => "${ridePref.departure.name} → ${ridePref.arrival.name}";

  String get subTitle {
    final formattedDate = DateTimeUtils.formatDateTime(ridePref.departureDate);
    final passengers = ridePref.requestedSeats > 1
        ? "${ridePref.requestedSeats} passengers"
        : "${ridePref.requestedSeats} passenger";
    return "$formattedDate, $passengers";
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
          vertical: 4, horizontal: 8),
      elevation: 2, 
      shape: RoundedRectangleBorder(
        borderRadius:
            BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: onPressed, 
        contentPadding: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8),
        title: Text(
          title,
          style: BlaTextStyles.body.copyWith(
            color: BlaColors.textNormal,
            fontWeight: FontWeight.w600, 
          ),
        ),
        subtitle: Text(
          subTitle,
          style: BlaTextStyles.label.copyWith(
            color: BlaColors.textLight,
          ),
        ),
        leading: Icon(
          Icons.history, 
          color: BlaColors.iconLight,
          size: 24, 
        ),
        trailing: Icon(
          Icons.arrow_forward_ios, 
          color: BlaColors.iconLight,
          size: 16,
        ),
      ),
    );
  }
}
