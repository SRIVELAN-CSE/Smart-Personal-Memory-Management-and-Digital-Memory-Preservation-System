import 'dart:async';
import 'package:flutter/material.dart';
import '../services/device_media_service.dart';

class VoiceNotePlayer extends StatefulWidget {
  const VoiceNotePlayer({required this.path, super.key});
  final String path;
  @override
  State<VoiceNotePlayer> createState() => _VoiceNotePlayerState();
}

class _VoiceNotePlayerState extends State<VoiceNotePlayer>
    with WidgetsBindingObserver {
  Timer? _timer;
  bool _playing = false, _busy = false;
  int _position = 0, _duration = 0;
  String? _error;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didUpdateWidget(covariant VoiceNotePlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.path != widget.path) {
      _stop();
      _position = 0;
      _duration = 0;
      _error = null;
    }
  }

  void _stop() {
    _timer?.cancel();
    _playing = false;
    unawaited(
      DeviceMediaService.channel.invokeMethod('audioStop').catchError((_) {}),
    );
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state != AppLifecycleState.resumed) {
      _stop();
      if (mounted) setState(() {});
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _stop();
    super.dispose();
  }

  Future<void> _toggle() async {
    if (_busy) return;
    setState(() {
      _busy = true;
      _error = null;
    });
    try {
      if (_playing) {
        await DeviceMediaService.channel.invokeMethod('audioPause');
        _timer?.cancel();
        if (mounted) setState(() => _playing = false);
      } else {
        await DeviceMediaService.channel.invokeMethod('audioPlay', {
          'path': widget.path,
        });
        if (!mounted) return;
        setState(() => _playing = true);
        _timer = Timer.periodic(const Duration(milliseconds: 300), (_) async {
          try {
            final status = await DeviceMediaService.channel
                .invokeMapMethod<String, dynamic>('audioStatus');
            if (mounted && status != null) {
              setState(() {
                _position = status['position'] as int;
                _duration = status['duration'] as int;
                _playing = status['playing'] as bool;
              });
            }
            if (!_playing) _timer?.cancel();
          } on Object {
            _stop();
            if (mounted) {
              setState(() => _error = 'Audio playback stopped. Try again.');
            }
          }
        });
      }
    } on Object {
      if (mounted) {
        setState(
          () => _error =
              'This recording could not be opened. You can replace it with a new note.',
        );
      }
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  String _time(int ms) =>
      '${ms ~/ 60000}:${((ms ~/ 1000) % 60).toString().padLeft(2, '0')}';
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        children: [
          IconButton.filledTonal(
            tooltip: _playing ? 'Pause voice note' : 'Play voice note',
            onPressed: _busy ? null : _toggle,
            icon: Icon(_playing ? Icons.pause : Icons.play_arrow),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_playing ? 'Playing your voice note' : 'Your voice note'),
                LinearProgressIndicator(
                  value: _duration > 0
                      ? (_position / _duration).clamp(0, 1)
                      : 0,
                ),
                Text(
                  '${_time(_position)} / ${_time(_duration)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          ),
        ],
      ),
      if (_error != null)
        Text(
          _error!,
          style: TextStyle(color: Theme.of(context).colorScheme.error),
        ),
    ],
  );
}
