import 'dart:io';
import 'dart:typed_data';

import 'package:google_mlkit_text_recognition/google_mlkit_text_recognition.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import '../domain/ocr_gateway.dart';

class MlKitOcrGateway implements OcrGateway {
  const MlKitOcrGateway();

  Future<String> recognizeFile(String path) async {
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      return (await recognizer.processImage(
        InputImage.fromFilePath(path),
      )).text.trim();
    } finally {
      await recognizer.close();
    }
  }

  @override
  Future<String> recognizeThumbnail(Uint8List bytes) async {
    if (bytes.isEmpty) return '';
    final directory = await getTemporaryDirectory();
    final file = File(
      p.join(
        directory.path,
        'smart_memory_ocr_${DateTime.now().microsecondsSinceEpoch}.jpg',
      ),
    );
    final recognizer = TextRecognizer(script: TextRecognitionScript.latin);
    try {
      await file.writeAsBytes(bytes, flush: true);
      final result = await recognizer.processImage(
        InputImage.fromFilePath(file.path),
      );
      return result.text.trim();
    } finally {
      await recognizer.close();
      if (await file.exists()) await file.delete();
    }
  }
}
