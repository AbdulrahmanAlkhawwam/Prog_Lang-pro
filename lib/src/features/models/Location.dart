class Location {
  /// location place as string [free_api] 8 - 32 character not more
  final String locationDescription;
  final double longitudes;
  final double latitudes;

  Location({
    required this.latitudes,
    required this.longitudes,
    required this.locationDescription,
  });
}
