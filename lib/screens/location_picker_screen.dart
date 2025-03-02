import 'package:advanceprojectflutter/model/ride/locations.dart';
import 'package:advanceprojectflutter/service/locations_service.dart';
import 'package:advanceprojectflutter/theme/theme.dart';
import 'package:flutter/material.dart';


class LocationPickerScreen extends StatefulWidget {
  const LocationPickerScreen({
    super.key,
    this.initLocation, // Optional initial location passed to the widget
  });

  final Location?
      initLocation; // Represents the starting location for the picker

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  Location? selectedLocation; // Tracks the currently selected location
  List<Location> filteredLocations =
      []; // Stores locations filtered by search input

  final TextEditingController searchController =
      TextEditingController(); // Controller for the search bar
  final FocusNode searchFocusNode =
      FocusNode(); // Focus node for managing keyboard focus

  bool get hasSearchInput =>
      searchController.text.isNotEmpty; // Checks if the search bar has any text

  @override
  void initState() {
    super.initState();
    selectedLocation = widget
        .initLocation; // Initialize the selected location with the provided value
    performSearch(
        ''); // Perform an initial search to populate the list with all available locations
  }

  // Handles tapping on a location item
  void handleLocationTap(Location tappedLocation) {
    Navigator.of(context).pop(
        tappedLocation); // Return the selected location to the previous screen
  }

  // Handles the back button press
  void handleBackPress() {
    Navigator.of(context)
        .pop(); // Close the screen and return to the previous screen
  }

  // Clears the search bar and resets the focus
  void clearSearchBar() {
    searchController.clear(); // Clear the text in the search bar
    searchFocusNode.requestFocus(); // Refocus the search bar
    performSearch(
        ''); // Reset the location list to show all available locations
  }

  // Filters the list of locations based on the search input
  void performSearch(String query) {
    setState(() {
      filteredLocations = LocationsService.availableLocations
          .where((location) =>
              location.name.toLowerCase().contains(query.toLowerCase()))
          .toList(); // Filter locations by matching the query (case-insensitive)
    });
  }

  // Builds the search bar UI
  Widget buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color:
            BlaColors.backgroundAccent, // Background color for the search bar
        borderRadius: BorderRadius.circular(BlaSpacings.s), // Rounded corners
      ),
      child: Row(
        children: [
          // Back button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: BlaSpacings.s),
            child: IconButton(
              onPressed: handleBackPress, // Navigate back when pressed
              icon: Icon(
                Icons.arrow_back_rounded,
                color: BlaColors.iconNormal, // Icon color
              ),
            ),
          ),
          // Search input field
          Expanded(
            child: TextField(
              controller: searchController, // Controller for managing the input
              focusNode: searchFocusNode, // Focus node for managing focus
              onChanged:
                  performSearch, // Trigger a search whenever the input changes
              style: TextStyle(
                color: BlaColors.textNormal, // Text color
              ),
              decoration: InputDecoration(
                hintText: 'Search for a location...', // Placeholder text
                border: InputBorder.none, // No border for the text field
                filled: false, // Do not fill the background
              ),
            ),
          ),
          // Clear button (visible only when there is input)
          if (hasSearchInput)
            IconButton(
              onPressed: clearSearchBar, // Clear the search bar when pressed
              icon: Icon(Icons.close_rounded,
                  color: BlaColors.iconNormal), // Clear icon
            ),
        ],
      ),
    );
  }

  // Builds a single location tile
  Widget buildLocationTile(BuildContext context,
      {required Location location, required VoidCallback onTap}) {
    return InkWell(
      splashColor: Colors.transparent, // Disable splash effect
      onTap: onTap, // Handle tap events
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: BlaSpacings.m), // Horizontal padding
        child: Row(
          children: [
            // Optional left icon (not used in this example)
            if (false) // Disabled for now
              // ignore: dead_code
              Icon(
                Icons.location_on, // Example icon
                color: BlaColors.neutral, // Icon color
              ),
            // Location name
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name, // Display the location name
                    style: TextStyle(fontWeight: FontWeight.bold), // Bold text
                  ),
                ],
              ),
            ),
            // Right arrow icon
            Icon(
              Icons.arrow_forward_ios_rounded, // Arrow icon
              color: BlaColors.neutral, // Icon color
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            buildSearchBar(context), // Search bar at the top
            if (filteredLocations
                .isNotEmpty) // Show the list only if there are results
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true, // Allow the list to shrink-wrap its content
                  physics:
                      AlwaysScrollableScrollPhysics(), // Ensure the list is always scrollable
                  itemCount:
                      filteredLocations.length, // Number of items in the list
                  itemBuilder: (ctx, index) => buildLocationTile(
                    context,
                    location:
                        filteredLocations[index], // Pass the location data
                    onTap: () => handleLocationTap(
                        filteredLocations[index]), // Handle tap events
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
