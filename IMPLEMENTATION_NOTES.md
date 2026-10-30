# Location, search, graph and Memory Companion

## Implemented behavior

- GPS uses the existing `photo_manager` asynchronous metadata API, backed by
  Android photo EXIF. No current-device location request is made. Invalid,
  stripped, denied and inaccessible coordinates remain optional. Capture times
  and the existing event-clustering algorithm are unchanged.
- Event location is the medoid of the densest 1 km neighbourhood of valid media
  coordinates. Sorted latitude/longitude break equal-population and medoid ties;
  repeated coordinates retain their original photo count. Results are cached for
  each immutable event snapshot and recomputed after membership corrections.
  Manual confirmed locations take precedence.
- Schema 4 extends the existing media/places tables; see DATABASE_SCHEMA.md.
  Coordinates, structured names and negative GPS checks survive restart.
- Timeline search reuses the Riverpod library snapshot. Its reusable search index
  combines title/person/location terms, stable person IDs, named locations and
  capture-date overlap. Text entry is debounced 300 ms. No database is reloaded
  on keystrokes and no user text is interpolated into SQL; existing persistence
  remains parameterized Drift operations with its date/person/place indexes.
- GraphView now uses a layered layout to prevent overlapping hit targets. Event
  and media nodes open existing details routes; media selection changes the
  displayed cover without changing the saved cover. People/places open filtered
  timeline routes. Shared person IDs share nodes. Missing places are inert.
- Memory Companion is reachable from the navigation app bar. Its previously
  unconnected templates/widgets now have local intent/retrieval services, a
  Riverpod controller and a route. Each response carries independently clickable
  event/media/person/location targets with URI encoding and current-state checks.
  Hidden memories are excluded. Chat is in-memory and can be cleared.

## Date definitions

All ranges use local calendar midnights, with an exclusive next-day end boundary;
UI start/end dates are inclusive. Event capture ranges overlap the selected days.

| Preset | Calendar definition |
| --- | --- |
| Today | Today only |
| Yesterday | Previous day only |
| Last 2/7/30 days | Today plus the previous 1/6/29 days |
| Last week | Previous Monday through Sunday |
| Last month | Entire previous calendar month |
| Last year | Entire previous calendar year |
| Custom | Both selected dates included |

Search, person, location and date filters can be combined and independently
cleared. Reset removes all criteria. Chat uses the same preset definitions.

## Dependencies and boundaries

No application dependencies were added. Existing photo_manager, geocoding,
GraphView, Drift, Riverpod and GoRouter are reused. The locally installed Flutter
SDK requires six transitive lockfile updates (characters, matcher,
material_color_utilities, meta, test_api, vector_math); package constraints were
not widened.

- Place lookup is off by default on the scan screen. Opting in permits the OS
  geocoder to resolve coordinates, possibly through its network provider. Only
  coordinates are passed. Offline/failure/timeout retains GPS; subsequent opted-in
  scans can retry unresolved names. Country/locality availability varies by provider.
- Missing GPS cannot be recovered by guessing. Manual places remain available;
  explicit rechecks support newly granted permission/restored originals.
- The graph retains a bounded projection: up to eight events and five media/people
  per event. Pan/zoom explores the layout. Chat returns up to 20 events and five
  media links per event when photos are requested. These bounds keep UI work finite.
- The application's existing complete-snapshot persistence remains unchanged;
  search indexes that loaded snapshot. Very large libraries still inherit the
  existing snapshot memory/write cost.
- Host tests validate domain logic, plugin-adapter failure handling, SQLite
  migrations and widget navigation. Real Android EXIF/permission handling and OS
  geocoding still require a device test. No APK deployment is claimed.

## Main implementation files

`lib/core/models/{location_aggregation,memory_target,memory_models}.dart`,
`lib/core/database/{tables,app_database,memory_snapshot_repository}.dart`,
`lib/features/timeline/{domain/event_filter,presentation/story_timeline_screen}.dart`,
`lib/features/memory_graph/{domain/memory_graph_projection,presentation/memory_graph_screen}.dart`,
`lib/features/chatbot/`, and `lib/routing/app_router.dart`.

Two existing async fallbacks now await plugin results inside their try blocks
(thumbnail loading and entry authentication), allowing asynchronous failures to
reach their intended catch handlers and satisfying the current SDK analyzer.

## Validation results (26 October 2026)

Environment: Flutter 3.47.8, Dart 3.13.7 on Windows.

- `dart run build_runner build --delete-conflicting-outputs`: succeeded. The
  generator reported its existing graph-edge manager-name collision and that its
  analyzer package predates the installed Dart language version; generation and
  subsequent compilation/tests succeeded without upgrading pinned packages.
- Focused location/migration run: 21 tests passed before the final recheck test.
- Focused date/search/target/chat extraction run: 12 tests passed.
- Focused UI navigation and structured persistence run: 8 tests passed.
- `dart format` on changed Dart files: completed.
- `flutter analyze --no-pub`: no issues (final run 19.1 seconds).
- `flutter test --no-pub`: **87 tests passed** (final run 15 seconds).
- `git diff --check`: passed; Git emitted only existing LF/CRLF notices.

Flutter commands used the installed `D:/flutter` SDK; tests invoked its cached
Flutter tool through Dart when the sandbox could not write the SDK lockfile.
The first test run overlapped code generation and was rerun after generation;
subsequent failures in graph hit targeting and test URI inspection were corrected
and the final complete run passed. No failing tests were removed or suppressed.

After keeping scan options visible on completed scans, the related location and
screen regression run passed all **20 tests**; formatting and diff checks also passed.

## Android release build environment (27 October 2026)

The installed Flutter 3.47.8 SDK requires at least Gradle 8.14, Android Gradle
Plugin 8.11.1, and Kotlin 2.2.20. The Android wrapper and plugin declarations
were updated to those versions after the original configuration failed Flutter's
dependency validation. Java 21 is used for Gradle because the installed Android
Studio bundles Java 25. The project-local Java 21 installation is in the ignored
`.dart_tool/toolchains/` directory. The build also installs Flutter's required
NDK 28.2.13676358, SDK platforms 35/36, Build Tools 35, and CMake 3.22.1 through
the Android SDK manager. Gradle is limited to a 3 GB heap and two workers, with
Kotlin compilation in-process, to reduce memory pressure on this 8 GB machine.

The existing release configuration signs with the debug key. This produces an
installable APK for testing; production distribution requires a release signing
configuration.

### Successful APK build

`flutter build apk --release --verbose` completed successfully on 27 October
2026 at 19:52 IST (verbose logging was enabled to diagnose interrupted attempts).
Gradle reported 518 tasks: 47 executed and 471 up-to-date. The APK is
`build/app/outputs/flutter-apk/app-release.apk`, 96,679,365 bytes, version 1.0.1
(build 3), package `com.mkce.smartmemory`, minimum SDK 24 and target SDK 36.

- APK signature verification passed (v2 signature, existing Android debug key).
- All 87 Dart source files matched the saved implementation SHA-256 manifest.
- Packaged binaries for ARM, ARM64, and x86-64 each contained the new Memory
  Companion, custom date-range, and photo-location recheck controls.
- APK SHA-256: `4D0743EF0B86E8492D4AC1E369B41E254AC9DB06C00D2F22DD83453067A51FA3`.
- Installed and launched on the connected Vivo V2303 on 27 October 2026. A fresh
  onboarding screen rendered successfully; gallery rescanning remains for the user.

### Installation conflict resolved

Android rejected an in-place update from version 1.0.0 (build 1) with
`INSTALL_FAILED_UPDATE_INCOMPATIBLE`: the installed app and the new APK had
different signing certificates. With the user's explicit permission to discard
the old app data, the old `com.mkce.smartmemory` package was uninstalled, then
the verified APK was installed successfully. Android confirmed version 1.0.1
(build 3), and launching `MainActivity` completed successfully. No gallery
photos or videos were deleted by this procedure.
