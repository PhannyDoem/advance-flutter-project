import 'package:advanceprojectflutter/screens/ride_pref/widget/ride_pref_form.dart';
import 'package:advanceprojectflutter/screens/ride_pref/widget/ride_pref_history_tile.dart';
import 'package:advanceprojectflutter/screens/ride_screen.dart';
import 'package:advanceprojectflutter/utils/animations_util.dart';
import 'package:flutter/material.dart';
import '../../model/ride_pref/ride_pref.dart';
import '../../service/ride_prefs_service.dart';
import '../../theme/theme.dart';


const String blablaHomeImagePath = 'assets/images/blabla_home.png';

///
/// This screen allows users to:
/// - Enter their ride preferences and initiate a search.
/// - Select a previously entered preference and initiate a search.
///
class RidePrefScreen extends StatefulWidget {
  const RidePrefScreen({super.key});

  @override
  State<RidePrefScreen> createState() => _RidePrefScreenState();
}

class _RidePrefScreenState extends State<RidePrefScreen> {
  // Handles the selection of a ride preference
  void handleRidePrefSelection(RidePref selectedPref) async {
    await Navigator.of(context).push(
      AnimationUtils.createBottomToTopRoute(
        RideScreen(
            initRidePref:
                selectedPref), // Navigate to the RideScreen with the selected preference
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // 1 - Background Image
        CustomBackground(),

        // 2 - Foreground Content
        Column(
          children: [
            SizedBox(height: BlaSpacings.l), // Add spacing at the top
            Text(
              "Find Your Perfect Ride",
              style: BlaTextStyles.heading.copyWith(color: Colors.white),
              textAlign: TextAlign.center, // Center-align the text
            ),
            SizedBox(height: 100), // Add spacing between the title and content
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: BlaSpacings.xxl),
                decoration: BoxDecoration(
                  color: Colors
                      .white, // White background for the form and history section
                  borderRadius: BorderRadius.circular(16), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12, // Subtle shadow for depth
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(), // Smooth scrolling effect
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // 2.1 Form to input ride preferences
                      Padding(
                        padding: EdgeInsets.all(BlaSpacings.m),
                        child: RidePrefForm(
                          initRidePref: RidePrefService
                              .currentRidePref, // Pass the current ride preference
                        ),
                      ),

                      // 2.2 History of past ride preferences
                      if (RidePrefService.ridePrefsHistory.isNotEmpty)
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: BlaSpacings.m,
                              vertical: BlaSpacings.s),
                          child: Text(
                            "Recent Preferences",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: BlaColors.textNormal,
                            ),
                          ),
                        ),
                      SizedBox(
                        height: 200, // Fixed height for the history list
                        child: ListView.builder(
                          shrinkWrap:
                              true, // Ensure the list fits within the container
                          physics: AlwaysScrollableScrollPhysics(),
                          itemCount: RidePrefService.ridePrefsHistory.length,
                          itemBuilder: (ctx, index) => RidePrefHistoryTile(
                            ridePref: RidePrefService.ridePrefsHistory[index],
                            onPressed: () => handleRidePrefSelection(
                                RidePrefService.ridePrefsHistory[
                                    index]), // Handle selection
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Custom widget for the background image
class CustomBackground extends StatelessWidget {
  const CustomBackground({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // Full width
      height: 340, // Fixed height for the background image
      child: Image.asset(
        blablaHomeImagePath, // Path to the background image
        fit: BoxFit.cover, // Cover the entire container
      ),
    );
  }
}
