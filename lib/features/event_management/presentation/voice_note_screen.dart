import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/voice_recording_service.dart';

import 'memory_controller.dart';

class VoiceNoteScreen extends ConsumerStatefulWidget {
  const VoiceNoteScreen({required this.eventId, super.key});

  final String eventId;

  @override
  ConsumerState<VoiceNoteScreen> createState() => _VoiceNoteScreenState();
}

class _VoiceNoteScreenState extends ConsumerState<VoiceNoteScreen> {
  late final VoiceRecordingService _recorder;
  bool _busy = false;

  @override
  void initState() {
    super.initState();
    _recorder = ref.read(voiceRecordingFactoryProvider)();
  }

  Timer? _timer;
  var _recording = false;
  var _elapsed = Duration.zero;
  String? _error;

  @override
  void dispose() {
    _timer?.cancel();
    unawaited(_recorder.dispose().catchError((_) {}));
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (_recording) {
        final path = await _recorder.stop();
        _timer?.cancel();
        if (!mounted) return;
        if (path != null) {
          ref
              .read(memoryControllerProvider.notifier)
              .attachVoiceNote(widget.eventId, path);
        }
        setState(() {
          _recording = false;
          if (path == null) {
            _error = 'No audio was saved. Please try recording again.';
          }
        });
        return;
      }
      final allowed = await _recorder.hasPermission();
      if (!mounted) return;
      if (!allowed) {
        setState(
          () => _error =
              'Microphone permission was denied. No recording was created.',
        );
        return;
      }
      await _recorder.start(widget.eventId);
      if (!mounted) {
        await _recorder.dispose();
        return;
      }
      _elapsed = Duration.zero;
      _timer = Timer.periodic(const Duration(seconds: 1), (_) {
        if (mounted) setState(() => _elapsed += const Duration(seconds: 1));
      });
      setState(() => _recording = true);
    } on Object {
      if (mounted) {
        setState(
          () => _error =
              'Recording could not be completed. '
              'Check microphone access and available storage, then try again.',
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final event = ref
        .watch(memoryControllerProvider)
        .events
        .where((item) => item.id == widget.eventId)
        .firstOrNull;
    if (event == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(child: Text('Event not found')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Voice note')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(28),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                event.title,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 28),
              Container(
                width: 150,
                height: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _recording
                      ? Theme.of(context).colorScheme.errorContainer
                      : Theme.of(context).colorScheme.primaryContainer,
                ),
                child: Icon(
                  _recording ? Icons.graphic_eq : Icons.mic_none,
                  size: 72,
                  color: _recording
                      ? Theme.of(context).colorScheme.error
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                _recording
                    ? '${_elapsed.inMinutes.toString().padLeft(2, '0')}:${(_elapsed.inSeconds % 60).toString().padLeft(2, '0')}'
                    : event.hasVoiceNote
                    ? 'A voice note is already attached'
                    : 'Record a short private recollection',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              FilledButton.icon(
                onPressed: _busy ? null : _toggle,
                icon: Icon(_recording ? Icons.stop : Icons.mic),
                label: Text(_recording ? 'Stop and attach' : 'Start recording'),
              ),
              if (_error != null) ...[
                const SizedBox(height: 14),
                Text(
                  _error!,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Theme.of(context).colorScheme.error),
                ),
              ],
              const SizedBox(height: 20),
              const Text(
                'Audio is saved in app-private storage. Recording happens only after an explicit tap and microphone permission.',
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
