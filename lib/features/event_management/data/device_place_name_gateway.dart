import 'package:geocoding/geocoding.dart';

import '../../../core/models/capture_location.dart';
import '../../../core/models/memory_models.dart';
import '../domain/services/place_name_gateway.dart';

class DevicePlaceNameGateway implements DetailedPlaceNameGateway {
  @override
  Future<String?> nameFor(CaptureLocation location) async =>
      (await placeFor(location))?.name;

  @override
  Future<MemoryPlace?> placeFor(CaptureLocation location) async {
    final placemarks = await Geocoding().placemarkFromCoordinates(
      location.latitude,
      location.longitude,
    );
    for (final mark in placemarks) {
      final name = formatPlaceName(mark);
      if (name.isEmpty) continue;
      String? clean(String? value) =>
          value == null || value.trim().isEmpty ? null : value.trim();
      return MemoryPlace(
        id: location.key,
        name: name,
        latitude: location.latitude,
        longitude: location.longitude,
        locality: clean(mark.subLocality),
        city: clean(mark.locality),
        state: clean(mark.administrativeArea),
        country: clean(mark.country),
        formattedAddress: name,
      );
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
