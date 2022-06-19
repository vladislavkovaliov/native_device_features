const LOCATION_API = 'c25cc721498845c1848df3b8e5d31d65';

class LocationHelper {
  static String generateLocationPreviewImage(
    double latitude,
    double longtitude,
  ) {
    return 'https://maps.geoapify.com/v1/staticmap?style=osm-bright-smooth&width=800&height=600&center=lonlat:$longtitude,$latitude&zoom=12.1401&apiKey=$LOCATION_API';
  }
}
