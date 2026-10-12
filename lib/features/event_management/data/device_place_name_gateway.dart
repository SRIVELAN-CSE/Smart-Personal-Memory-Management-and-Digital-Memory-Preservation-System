import 'package:geocoding/geocoding.dart';

import '../../../core/models/capture_location.dart';
import '../domain/services/place_name_gateway.dart';

class DevicePlaceNameGateway implements DetailedPlaceNameGateway {
  @override
  Future<String?> nameFor(CaptureLocation location) async =>
      (await addressFor(location))?.label;

  @override
  Future<PlaceAddress?> addressFor(CaptureLocation location) async {
    final placemarks = await Geocoding().placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    for (final placemark in placemarks) {
      final name = formatPlaceName(placemark);
      if (name.isNotEmpty) {
        String? clean(String? value) =>
            value?.trim().isNotEmpty == true ? value!.trim() : null;
        return PlaceAddress(
          label: name,
          locality: clean(placemark.subLocality),
          city:
              clean(placemark.locality) ??
              clean(placemark.subAdministrativeArea),
          region: clean(placemark.administrativeArea),
          country: clean(placemark.country),
          formattedAddress: <String>{?clean(placemark.street), name}.join(', '),
        );
      }
    }
    return null;
  }

  static String formatPlaceName(Placemark placemark) {
    String? firstNonEmpty(List<String?> candidates) => candidates
        .map((value) => value?.trim() ?? '')
        .where((value) => value.isNotEmpty)
        .firstOrNull;

    return <String>{
      ?firstNonEmpty([
        placemark.locality,
        placemark.subAdministrativeArea,
        placemark.subLocality,
        placemark.name,
      ]),
      ?firstNonEmpty([placemark.administrativeArea]),
      ?firstNonEmpty([placemark.country]),
    }.join(', ');
  }
}
