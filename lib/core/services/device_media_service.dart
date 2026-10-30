import 'package:flutter/services.dart';
import '../models/memory_models.dart';

/// Android operations use existing media URIs; originals are never modified.
class DeviceMediaService {
  static const channel = MethodChannel('smart_memory/device_media');
  static Map<String, Object> _asset(MediaItem media) => {
    'id': media.assetIdentifier,
    'video': media.kind == MediaKind.video,
  };
  static Future<void> share(List<MediaItem> media) =>
      channel.invokeMethod('share', {'media': media.map(_asset).toList()});
  static Future<void> open(MediaItem media) =>
      channel.invokeMethod('open', _asset(media));
  static Future<Map<Object?, Object?>?> location(String id, bool video) =>
      channel.invokeMapMethod('location', {'id': id, 'video': video});
}
