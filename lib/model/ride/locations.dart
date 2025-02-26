import 'package:advanceprojectflutter/model/enums/country.dart';

///
/// Enumation of available BlaBlaCar countries
///

///
/// This model describes a location (city, street).
///
class Location {
  final String name;
  final Country country;

  const Location({required this.name, required this.country});

  Location copyWith({String? name, Country? country}) {
    return Location(
      name: name ?? this.name,
      country: country ?? this.country,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Location && other.name == name && other.country == country;
  }

  @override
  int get hashCode => name.hashCode ^ country.hashCode;

  @override
  String toString() {
    return 'Location(name: $name, country: $country)';
  }
}

///
/// This model describes a street.
///

