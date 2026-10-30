import '../../../../core/models/memory_models.dart';
import '../../../../core/models/capture_location.dart';

abstract interface class PlaceNameGateway {
  Future<String?> nameFor(CaptureLocation location);
}

abstract interface class DetailedPlaceNameGateway implements PlaceNameGateway {
  Future<MemoryPlace?> placeFor(CaptureLocation location);
}
