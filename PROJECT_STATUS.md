# Project status — 12 October 2026

## Existing application

Smart Memory is a Flutter Android MVP using Riverpod, GoRouter, Drift/SQLite,
photo_manager, and on-device OCR. The source includes onboarding, gallery scanning,
time-based event clustering with location/OCR signals, an event timeline, editable
memories, people tags, stories, voice notes, a personal memory graph, preservation
scores/recommendations, reminders, and privacy/data-management screens.

Memory Companion is available at `/companion` from the main app-bar chat icon.
It retrieves saved memories offline and provides clickable event, photo, person
and place results. Hardware integration still
needs physical-device validation. Cloud backup, a trained face-recognition model,
and generative cloud stories are not implemented.

## Completed photo-location feature

- Reads capture GPS asynchronously, including the Android 10+ metadata path.
- Rejects incomplete, out-of-range, non-finite, and provider `(0, 0)` values.
- Displays place names with coordinate fallback on event details and cards.
- Provides per-photo/video coordinate details within each event; graph media nodes
  open event details with the selected photo visible.
- Graph person and location nodes open filtered timelines. An unavailable-location
  node opens its event, where a place can be added manually.
- Awaits bounded device place-name lookup before scan completion and persistence.
- Recovers GPS for existing imports on a rescan without re-running OCR or regrouping
  memories; retries unresolved place names while retaining manual corrections.
- Keeps automatic locations consistent after split, merge, add, and remove edits.
- Retains normalized place records and `occurred_at` graph relationships in SQLite.
- Fixes the graph's nested pan/zoom layout error and fits the graph to its viewport.
- Conceals hidden-event locations on cards and excludes hidden events from the graph.

The event summary uses the largest 0.01-degree coordinate grid group and selects
the actual coordinate nearest its centroid. Ties use capture time then media ID;
confirmed manual places retain priority. Individual photo locations remain available.
Schema v4 adds nullable locality, city, region, country and formatted-address fields
while preserving existing memories. No new dependency or current-location permission
was added. The timeline now combines title, person, location and calendar-date filters.

## Verification

- Full Flutter suite: **92 tests passed**.
- Static analysis of all application and test sources: **No issues found**.
- Drift code regenerated; all 42 touched Dart files passed the formatting check.
- Phone-size render check: event and graph previews inspected at 412 × 915 logical
  pixels with app fonts; files are under `build/location-previews/`.
- Android debug APK: built successfully; integrity, embedded location code,
  package metadata, and v2 debug signature verified on 20 September 2026.
  Artifact: `build/app/outputs/flutter-apk/app-debug.apk` (190,069,347 bytes).
- The existing APK predates the current source changes and does **not** include
  these updates. A new release build was attempted but did not complete because
  Android SDK setup failed. Build a fresh APK from this source before installation.
- Current automated verification is recorded in [TESTING.md](TESTING.md).
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
