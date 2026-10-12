import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';

abstract interface class VoiceRecordingService {
  Future<bool> hasPermission();
  Future<void> start(String eventId);
  Future<String?> stop();
  Future<void> dispose();
}

final voiceRecordingFactoryProvider =
    Provider<VoiceRecordingService Function()>(
      (ref) => DeviceVoiceRecordingService.new,
    );

class DeviceVoiceRecordingService implements VoiceRecordingService {
  AudioRecorder? _recorder;
  AudioRecorder get _active => _recorder ??= AudioRecorder();

  @override
  Future<bool> hasPermission() => _active.hasPermission();

  @override
  Future<void> start(String eventId) async {
    final directory = await getApplicationSupportDirectory();
    await _active.start(
      const RecordConfig(encoder: AudioEncoder.aacLc),
      path: p.join(
        directory.path,
        'voice_${eventId}_${DateTime.now().millisecondsSinceEpoch}.m4a',
      ),
    );
  }

  @override
  Future<String?> stop() async => await _recorder?.stop();

  @override
  Future<void> dispose() async {
    await _recorder?.dispose();
    _recorder = null;
  }
}
