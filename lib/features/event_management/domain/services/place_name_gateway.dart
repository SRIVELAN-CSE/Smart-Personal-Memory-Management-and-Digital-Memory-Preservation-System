import '../../../../core/models/capture_location.dart';

abstract interface class PlaceNameGateway {
  Future<String?> nameFor(CaptureLocation location);
}

/// Optional structured capability; simple/offline gateways can return a label.
abstract interface class DetailedPlaceNameGateway implements PlaceNameGateway {
  Future<PlaceAddress?> addressFor(CaptureLocation location);
}

class PlaceAddress {
  const PlaceAddress({
    required this.label,
    this.locality,
    this.city,
    this.region,
    this.country,
    this.formattedAddress,
  });
  final String label;
  final String? locality, city, region, country, formattedAddress;
}
