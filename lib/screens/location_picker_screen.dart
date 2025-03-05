import 'package:advanceprojectflutter/model/ride/locations.dart';
import 'package:advanceprojectflutter/service/location_service.dart';
import 'package:advanceprojectflutter/theme/theme.dart';
import 'package:flutter/material.dart';


class LocationPickerScreen extends StatefulWidget {
  final LocationService service;
  final Location? initLocation;

  const LocationPickerScreen({
    super.key,
    required this.service,
    this.initLocation,
  });

  @override
  State<LocationPickerScreen> createState() => _LocationPickerScreenState();
}

class _LocationPickerScreenState extends State<LocationPickerScreen> {
  Location? selectedLocation;
  List<Location> filteredLocations = [];
  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();

  bool get hasSearchInput => searchController.text.isNotEmpty;

  @override
  void initState() {
    super.initState();
    selectedLocation = widget.initLocation;
    performSearch('');
  }

  void handleLocationTap(Location tappedLocation) {
    Navigator.of(context).pop(tappedLocation);
  }

  void handleBackPress() {
    Navigator.of(context).pop();
  }

  void clearSearchBar() {
    searchController.clear();
    searchFocusNode.requestFocus();
    performSearch('');
  }

  void performSearch(String query) {
    setState(() {
      filteredLocations = widget.service
          .getLocations()
          .where((location) =>
              location.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  Widget buildSearchBar(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: BlaColors.backgroundAccent,
        borderRadius: BorderRadius.circular(BlaSpacings.s),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: BlaSpacings.s),
            child: IconButton(
              onPressed: handleBackPress,
              icon: Icon(
                Icons.arrow_back_rounded,
                color: BlaColors.iconNormal,
              ),
            ),
          ),
          Expanded(
            child: TextField(
              controller: searchController,
              focusNode: searchFocusNode,
              onChanged: performSearch,
              style: TextStyle(
                color: BlaColors.textNormal,
              ),
              decoration: InputDecoration(
                hintText: 'Search for a location...',
                border: InputBorder.none,
                filled: false,
              ),
            ),
          ),
          if (hasSearchInput)
            IconButton(
              onPressed: clearSearchBar,
              icon: Icon(Icons.close_rounded, color: BlaColors.iconNormal),
            ),
        ],
      ),
    );
  }

  Widget buildLocationTile(BuildContext context,
      {required Location location, required VoidCallback onTap}) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: BlaSpacings.m),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    location.name,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: BlaColors.neutral,
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
            buildSearchBar(context),
            if (filteredLocations.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  physics: AlwaysScrollableScrollPhysics(),
                  itemCount: filteredLocations.length,
                  itemBuilder: (ctx, index) => buildLocationTile(
                    context,
                    location: filteredLocations[index],
                    onTap: () => handleLocationTap(filteredLocations[index]),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
