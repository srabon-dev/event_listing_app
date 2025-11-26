import 'package:event_listing_app/app_export.dart';

class StaticMapView extends StatelessWidget {
  final double? lat;
  final double? lng;
  final int zoom;
  final double height;
  final double width;
  final String apiKey;

  static final Map<String, String> _urlCache = {};

  static const double defaultLat = 40.7128;
  static const double defaultLng = -74.0060;

  const StaticMapView({
    super.key,
    this.lat,
    this.lng,
    required this.apiKey,
    this.zoom = 15,
    this.height = 200,
    this.width = 350,
  });

  @override
  Widget build(BuildContext context) {
    final double finalLat = lat ?? defaultLat;
    final double finalLng = lng ?? defaultLng;

    final url = Uri.parse(
      "https://maps.googleapis.com/maps/api/staticmap"
          "?center=$finalLat,$finalLng"
          "&zoom=$zoom"
          "&size=${width.toInt()}x${height.toInt()}"
          "&markers=color:red|$finalLat,$finalLng"
          "&key=$apiKey",
    ).toString();

    _urlCache[url] = url;

    return CustomNetworkImage(
      imageUrl: _urlCache[url],
      height: height,
      width: width,
      fit: BoxFit.cover,
      borderRadius: BorderRadius.circular(16),
    );
  }
}
