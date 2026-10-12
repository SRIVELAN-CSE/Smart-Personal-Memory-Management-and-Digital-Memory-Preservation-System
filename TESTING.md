# Testing and verification

## Automated commands

Run with Android Studio JBR 21 when the global Java configuration is unsuitable:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Android\Android Studio\jbr'
$env:Path = 'C:\Windows\System32\WindowsPowerShell\v1.0;' + $env:Path
dart format lib test
flutter analyze
flutter test
flutter build apk --debug
```

Drift generation after schema changes:

```powershell
dart run build_runner build --delete-conflicting-outputs
```

## Photo-location verification — 15 September 2026

The full suite passes **53 tests**, including **17 new location regression tests**.
Coverage includes asynchronous EXIF access, missing/invalid GPS, blank place names,
lookup failure and timeout, SQLite/graph persistence, old-import recovery,
unassigned media, repeated scans, manual edits during lookup, split/merge/media
corrections, narrow-screen fallback, and tappable graph photo coordinates.

Test files:

- `test/features/photo_location_test.dart`
- `test/widgets/photo_location_widget_test.dart`

Before shipping, verify on a physical Android device:

1. Import original photos whose capture coordinates are known; compare event and
   graph photo details with the gallery metadata.
2. Deny embedded-location access while allowing gallery access; import must still
   complete and must not show a fabricated place.
3. Repeat with selected-photo access and with a photo that has no GPS.
4. Make the device geocoder unavailable; coordinates must remain visible.
5. Rescan older imports; verify locations appear without duplicate events or lost
   notes, OCR, people, or manual place names.
6. Split, merge, add, and remove photos from different places; inspect the remaining
   photo coordinates and the primary event location.

Static analysis reports **No issues found**. Host previews of the event and graph
screens were generated and visually inspected at 412 × 915 logical pixels using
Roboto and Material Icons. The previews use explicitly illustrative demo data and
are saved at `build/location-previews/event.png` and
`build/location-previews/graph.png`.

Host tests and generated previews do not replace these device checks.

## Verified automated coverage

| Area | Evidence |
|---|---|
| Time similarity | Four-to-twelve-hour curve and strong/weak boundaries |
| Location similarity | Haversine distance plus missing GPS behavior |
| OCR similarity | Normalization, stop words, Jaccard overlap, missing OCR |
| Clustering | Stable ordering, supported weak joins, hard gaps, max event span |
| Significance | Rating/important/favourite/revisit/people/context/correction factors |
| Rediscovery risk | Injected clock, staleness, views, age, reminder dismissal bounds |
| Context | Normalized score and exact missing action list |
| Sensitivity | Suppression and neutral explicit-reminder policy |
| Preservation need | Required multiplicative formula and recommended actions |
| Drift | Schema version, indexes, foreign keys, idempotent seed, interactions, safe delete |
| Persistent snapshot | Stories, people, places, voice references, factors, reminders, feedback, unassigned media |
| Transaction queue | Atomic replacement, idempotent writes, retained scan audit rows |
| Permissions | Denial produces a safe state and leaves demo available |
| Empty gallery | Scan completes without creating an event |
| Incremental import | A repeated scan supplies known IDs and creates no duplicate rows/events |
| Timeline widget | Demo title, media count, scores, and automatic-template label |

The verified static-analysis pass is:

```text
No issues found!
```

The final full pass reports:

```text
00:23 +53: All tests passed!
```

Test sources live under
`test/unit`, `test/database`, `test/features`, and `test/widget_test.dart`.

## Verified Android artifact

The updated debug APK was built on 15 September 2026 and verified on
20 September 2026. ZIP integrity, embedded location-feature code, package metadata,
and Android debug signature checks all passed. That APK predates the location,
search, graph-navigation and companion changes verified below. Artifact evidence:

| Check | Result |
|---|---|
| Path | `build/app/outputs/flutter-apk/app-debug.apk` |
| Size | 190,069,347 bytes |
| Application ID | `com.mkce.smartmemory` |
| SDKs | min 24, target 36, compile 36 |
| ABIs | armeabi-v7a, arm64-v8a, x86_64 |
| Signature | Valid Android debug certificate, APK Signature Scheme v2 |
| SHA-256 | `bd5e4f6b99f855245e78592d0c7bf447c8fbc46974439adb95584e92431afd2d` |

The standard Flutter debug manifest includes development Internet access for the
debugger/hot reload. The main manifest and application code add no network client
or upload workflow.

## Manual Android matrix

Automated host tests cannot validate every platform UI. Before release, run on at
least Android 12 (legacy media permission), Android 13, Android 14 selected-photo
access, and Android 16/current target:

| Scenario | Expected result |
|---|---|
| Fresh install → deny media | No crash; demo button works |
| Grant selected photos only | Only selected assets appear; zero selection is valid |
| Grant images without videos | Image scan succeeds without assuming video access |
| Re-scan same library | Known asset IDs are skipped |
| Missing GPS/OCR | Metadata still imports and clustering remains deterministic |
| Damaged/unsupported image | OCR failure is item-scoped; scan continues |
| Foreground voice recording | Permission requested on tap; AAC file remains app-private |
| Biometric unavailable/cancelled | Setting remains off; app does not lock out user |
| Time capsule | Inexact local notification uses neutral wording and secret visibility |
| Sensitive event | No proactive inbox item or revealing notification |
| Delete derived data | App records clear; gallery originals remain unchanged |

## Test-data integrity

Tests use deterministic timestamps and explicit UTC normalization. Demo scores are
fixtures and must not be interpreted as model accuracy measurements.

## Location, search, graph and companion verification — 12 October 2026

Validated using Flutter 3.35.4 and Dart 3.9.2 in the ignored
`build/toolchain/flutter` directory. The project-local pub cache is
`build/toolchain/pub-cache`; package constraints and the lockfile were unchanged.

| Command/check | Actual result |
|---|---|
| `flutter pub get` | Existing dependencies restored successfully |
| `dart run build_runner build --delete-conflicting-outputs` | Drift regenerated for schema v4; subsequent incremental build succeeded |
| Focused domain/database tests and navigation widget tests | Passed after correcting the graph state reference and a GoRouter push assertion |
| `flutter test --no-pub --reporter expanded` | **92 tests passed** |
| `dart format --output=none --set-exit-if-changed <42 touched Dart files>` | **0 changes**, exit 0 |
| `flutter analyze --no-pub lib test` | **No issues found**, exit 0 |
| `git diff --check` | Passed |

Analysis covers all application and test Dart sources explicitly, excluding the
downloaded SDK under `build/`. Flutter tests required execution outside the
Windows sandbox because it denied copying temporary compiled test files.

Coverage includes mocked asynchronous photo GPS (valid, missing and denied),
deterministic representative coordinates, structured-address persistence,
schema 1/2/3 migration without lost context, date rollover/leap-month boundaries,
combined and independently cleared filters, typed graph targets, selected-photo
navigation, multiple companion result types, stale/deleted/hidden targets, and
small-phone layouts with the keyboard visible.

No new APK or physical-device check was performed for these changes. Real photo
EXIF access and device geocoder behavior still require the Android matrix above.
Missing GPS remains unavailable; optional reverse geocoding may require network
access through the device service. Coordinates continue to work offline.
