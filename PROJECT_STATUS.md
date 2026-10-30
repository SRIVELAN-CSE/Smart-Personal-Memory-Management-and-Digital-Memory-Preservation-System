# Project status — 20 September 2026

**Historical status.** The current 1.0.2 review update is documented in [RELEASE_REVIEW.md](RELEASE_REVIEW.md), including the active Companion tab, event gallery/sharing, circular graph and in-event playback.

## Existing application

Smart Memory is a Flutter Android MVP using Riverpod, GoRouter, Drift/SQLite,
photo_manager, and on-device OCR. The source includes onboarding, gallery scanning,
time-based event clustering with location/OCR signals, an event timeline, editable
memories, people tags, stories, voice notes, a personal memory graph, preservation
scores/recommendations, reminders, and privacy/data-management screens.

The repository also contains chatbot entities, extraction logic, and card widgets;
the current router does not expose a chatbot screen. Hardware integration still
needs physical-device validation. Cloud backup, a trained face-recognition model,
and generative cloud stories are not implemented.

## Completed photo-location feature

- Reads capture GPS asynchronously, including the Android 10+ metadata path.
- Rejects incomplete, out-of-range, non-finite, and provider `(0, 0)` values.
- Displays place names with coordinate fallback on event details and cards.
- Provides per-photo/video coordinate details within each event and graph media node.
- Adds a graph location node even when location is unavailable, with manual entry.
- Awaits bounded device place-name lookup before scan completion and persistence.
- Recovers GPS for existing imports on a rescan without re-running OCR or regrouping
  memories; retries unresolved place names while retaining manual corrections.
- Keeps automatic locations consistent after split, merge, add, and remove edits.
- Retains normalized place records and `occurred_at` graph relationships in SQLite.
- Fixes the graph's nested pan/zoom layout error and fits the graph to its viewport.
- Conceals hidden-event locations on cards and excludes hidden events from the graph.

The event summary uses the first available capture location. Individual photo
locations remain available when an event includes media from different places.
No schema migration, new dependency, or current-location permission was added.

## Verification

- Full Flutter suite: **53 tests passed**, including 17 location regression tests.
- Static analysis: **No issues found**.
- Phone-size render check: event and graph previews inspected at 412 × 915 logical
  pixels with app fonts; files are under `build/location-previews/`.
- Android debug APK: built successfully; integrity, embedded location code,
  package metadata, and v2 debug signature verified on 20 September 2026.
  Artifact: `build/app/outputs/flutter-apk/app-debug.apk` (190,069,347 bytes).
- Automated tests and static analysis were completed on 15 September 2026;
  application and test sources have not changed since the verified build.
- Real-device GPS/selected-photo permission checks remain pending; mocked platform
  tests and host widget tests do not certify hardware behavior.

## Try the feature

1. Install the updated build and allow access to photos containing GPS metadata.
2. Run **Scan**; repeat this for previously imported photos missing coordinates.
3. Open an event to view its place and expand **Photo locations**.
4. Open **Graph**, then tap an orange location node or blue photo node.
5. Use **Add location** when GPS is unavailable, or **Edit** to confirm a place name.

## Platform references

The implementation was checked against installed package source and the official
[photo_manager documentation](https://pub.dev/packages/photo_manager),
[Android shared-media guide](https://developer.android.com/training/data-storage/shared/media),
and [geocoding documentation](https://pub.dev/documentation/geocoding/latest/).
Android capture metadata requires the appropriate gallery/media-location access;
device geocoding is optional and may use a network service.
