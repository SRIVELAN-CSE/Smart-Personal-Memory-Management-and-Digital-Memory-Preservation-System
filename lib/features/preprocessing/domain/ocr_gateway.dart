import 'dart:typed_data';

abstract interface class OcrGateway {
  Future<String> recognizeThumbnail(Uint8List bytes);
}

class NoopOcrGateway implements OcrGateway {
  const NoopOcrGateway();

  @override
  Future<String> recognizeThumbnail(Uint8List bytes) async => '';
}
