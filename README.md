# Smart Memory

Current review release: **1.0.2 (build 4)**. See [release changes, recording comparison and verification](RELEASE_REVIEW.md). Older dated build records below are historical.

**Smart Personal Memory Management and Digital Memory Preservation System**

Smart Memory is an Android-focused Flutter application that turns selected gallery
photos and videos into editable event memories, then explains which personal
context may be worth preserving. It is offline-first: original media stays in the
gallery while asset references, derived metadata, OCR text, relationships, scores,
notes, and reminder state are stored locally.

## Project identity

| Item | Value |
|---|---|
| App name | Smart Memory |
| Flutter project | `smart_memory_preservation` |
| Android package | `com.mkce.smartmemory` |
| Primary platform | Android, min SDK 24 / target SDK 36 |
| UI | Responsive Material 3, light and dark themes |
| Connectivity | No mandatory network, cloud, paid API, or API key |

## Problem statement

Photos often retain visual content while losing who was present, why an event
mattered, what happened, and when the owner wants to revisit it. Large libraries
also leave meaningful records unopened. Smart Memory addresses loss of *digital
context*; it does not attempt to detect emotion or predict human memory.

## Existing-system limitation

Modern gallery products already provide albums, search, clustering, and
resurfacing. Automatic grouping alone does not ensure that a person records the
story behind a moment, and passive resurfacing does not necessarily explain which
missing action would make a memory more complete. This project does not claim that
photo grouping is new or that other gallery products lack memory features.

## Proposed solution and innovation

After the user grants full or selected-photo access, the app:

1. pages through gallery assets without changing the originals;
2. reads capture time, optional embedded location, dimensions, type, duration, and
   file size when the media provider exposes it;
3. processes bounded thumbnails for on-device OCR and duplicate fingerprints;
4. groups adjacent media with configurable time/location/OCR/visual-signal rules;
5. lets the user rename, describe, place, split, merge, add/remove media, rate,
   favourite, mark important, hide, and contextualize generated events;
6. connects events, media, people, places, stories, and voice notes in a graph;
7. calculates explainable application significance, rediscovery risk, context
   completeness, and preservation need;
8. recommends an exact local action, subject to a sensitivity safety gate.

The main contribution is proactive, explainable preservation of personal context:

```text
preservation need =
  significance
  × rediscovery risk
  × (1 - context completeness)
  × (1 - sensitivity)
```

Every rule-based engine retains factor contributions and reason codes. Sensitive
events are removed from proactive recommendations and never produce revealing
lock-screen text.

## Photo locations in memories

Events and timeline cards now display where their photos were taken. Import reads
embedded GPS using the gallery plugin's asynchronous metadata API. The event uses
the first media item with valid coordinates; a confirmed manual place takes
precedence. Expand **Photo locations** inside an event to inspect each photo or
video's own coordinates, including missing-location entries.

The personal memory graph includes an event location node. Tap it for the place
and capture-location summary; tap a photo node for that photo's coordinates.
Hidden memories are excluded from the graph and their timeline location is hidden.

Place-name lookup uses the device geocoding service. Coordinates remain available
when that service fails, times out, or returns no name. Media without GPS shows
**Location unavailable** and supports **Add location**. Run **Scan** again to
recover missing coordinates for previously imported media and retry unresolved
place names. This preserves event groupings, stories, OCR, and manual corrections.

No new dependency, database migration, or current-device location permission is
needed. Physical-device validation of real photo GPS and Android permission
combinations remains pending. See [PROJECT_STATUS.md](PROJECT_STATUS.md).

## Research integrity

- **Significance** is an application estimate based on explicit interactions such
  as rating, favourite status, revisits, confirmed people, context, and corrections.
- **Rediscovery risk** estimates the chance that a record remains unopened inside
  this app. It is not biological forgetting.
- The system does not claim to infer human emotion.
- Demo scores and thresholds are illustrative, not experimentally validated.
- Automatic story text is a local template, visibly labelled and editable.

## Architecture

The project uses feature-first clean architecture:

```text
presentation (Material 3 + Riverpod)
        ↓
domain (entities, interfaces, deterministic engines)
        ↑
data (Drift repositories + platform/plugin adapters)
```

Platform dependencies are behind interfaces: `MediaImportGateway`, `OcrGateway`,
`NotificationGateway`, scoring predictors, and the clusterer. Drift/SQLite stores
normalized media references, corrections, graph projections, score factors,
recommendations, feedback, reminders, and scan audit data. Controller writes are
serialized and each complex snapshot replacement is one transaction; gallery
assets remain owned by Android. See
[ARCHITECTURE.md](ARCHITECTURE.md) and
[DATABASE_SCHEMA.md](DATABASE_SCHEMA.md).

## Technology stack

| Concern | Implementation |
|---|---|
| UI/state/navigation | Flutter 3.35.4, Dart 3.9.2, Riverpod 2.6.1, GoRouter 17.2.3 |
| Persistence | Drift 2.31.0, SQLite, `sqlite3_flutter_libs` 0.5.41 |
| Gallery/OCR | `photo_manager` 3.12.0, Google ML Kit text recognition 0.16.0 |
| Processing/graph | `image` 4.9.2, GraphView 1.5.1 |
| Security | secure storage 10.3.1, local auth 3.0.1 |
| Voice/reminders | `record` 6.2.1, local notifications 20.1.0, timezone data |
| Android build | API 36, Gradle 8.12, AGP 8.9.1, Kotlin 2.1.0, Java target 17 |

Visual embeddings accept a model-ready input, but no fabricated TensorFlow model is
bundled. Cloud backup and generated cloud stories are disabled.

## Implemented screens

The GoRouter graph includes all requested MVP surfaces:

- splash, onboarding, privacy rationale, and permission choice;
- dashboard, scan progress, story timeline, and event details;
- rename/description/place/rating/cover/sensitivity plus split, merge, and
  add/remove-media corrections;
- manual people tags, personal story, and app-private voice recording;
- interactive typed memory graph;
- recommendation inbox, factor-level detail, and future time capsule;
- privacy/security, derived-data management, and methodology.

Demo mode is functional without gallery permission. Gallery/OCR, notifications,
recording, secure storage, and biometrics use real plugin adapters; their hardware
behavior still requires Android device testing.

## Setup

Prerequisites:

- Flutter 3.35.4 / Dart 3.9.2 or a compatible newer stable SDK;
- Android SDK platform 36;
- Android Studio JBR 21 (recommended for Gradle);
- an Android emulator or device for platform-feature testing.

On the audited Windows machine, use a process-local toolchain override because the
global `JAVA_HOME` points to a missing JDK and Flutter's launcher needs Windows
PowerShell on `PATH`:

```powershell
$env:JAVA_HOME = 'C:\Program Files\Android\Android Studio\jbr'
$env:Path = 'C:\Windows\System32\WindowsPowerShell\v1.0;' + $env:Path
flutter doctor -v
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Drift output is generated at `lib/core/database/app_database.g.dart`; do not edit it
manually.

## Android permissions

| Permission | Purpose |
|---|---|
| `READ_EXTERNAL_STORAGE` through API 32 | Read gallery media on older Android |
| `READ_MEDIA_IMAGES` / `READ_MEDIA_VIDEO` | Read available media on Android 13+ |
| `READ_MEDIA_VISUAL_USER_SELECTED` | Respect Android selected-photo access |
| `ACCESS_MEDIA_LOCATION` | Read embedded media coordinates when available |
| `RECORD_AUDIO` | User-initiated voice note |
| `USE_BIOMETRIC` | Optional app access gate |
| `POST_NOTIFICATIONS` | Explicitly scheduled local reminders |
| `RECEIVE_BOOT_COMPLETED` | Restore scheduled reminders after reboot |

The app does not request contacts, current/background location, media write/delete,
all-files access, or exact alarms. Permission denial is a supported state.
Flutter's standard **debug/profile** manifests add `INTERNET` for development
services such as the debugger and hot reload; the main application manifest has no
Internet permission and this project contains no network client or upload path.

## Testing and build commands

```powershell
dart format lib test
flutter analyze
flutter test
flutter build apk --debug
```

The verified analysis pass reports **No issues found** and all **53 automated tests
pass**. The suite covers clustering, score engines, sensitivity gating, normalized
Drift round trips/atomic replacement/safe deletion, idempotent scans, permission
denial, an empty gallery, and the timeline widget. See
[TESTING.md](TESTING.md) for the evidence and manual Android matrix.

The verified debug artifact is
`build/app/outputs/flutter-apk/app-debug.apk` (190,069,347 bytes), package
`com.mkce.smartmemory`, min SDK 24, target/compile SDK 36, and APK Signature Scheme
v2 debug-signed. SHA-256:
`bd5e4f6b99f855245e78592d0c7bf447c8fbc46974439adb95584e92431afd2d`.

## Demo

On the permission screen, choose **Explore with demo data**. The supplied memory is:

- Final-Year Project Review, 14 July 2026;
- M. Kumarasamy College of Engineering;
- 18 virtual photo references;
- Sudeep K and Sudharshanan K S;
- five stars and favourite;
- story and voice context missing;
- illustrative scores: significance 0.86, rediscovery risk 0.78, context 0.40.

The expected recommendation explains that the academic memory appears important,
has not been opened in the demo assumption, and lacks personal context. See
[DEMO_GUIDE.md](DEMO_GUIDE.md).

## Screenshots

Add emulator/device captures here after the manual Android validation pass:

| Screen | Status |
|---|---|
| Onboarding and permission rationale | Capture pending |
| Home dashboard | Capture pending |
| Timeline and event score detail | Capture pending |
| Memory graph | Capture pending |
| Recommendation and privacy dashboard | Capture pending |

## Privacy summary

- Original media remains unchanged in the Android gallery.
- SQLite contains references and derived data, never original image/video bytes.
- OCR, grouping, scoring, and template summaries run locally.
- Voice notes use app-private files rather than database blobs.
- Small protection preferences use platform secure storage.
- The standard Drift database is app-private but is not claimed to be encrypted.
- Android backup and cleartext traffic are disabled; cloud backup is absent.
- Derived-data deletion does not call a gallery delete API.

See [PRIVACY.md](PRIVACY.md).

## Known limitations

- Physical-device validation is still required for Android 13–16 full/limited
  gallery access, real-media OCR, microphone recording, biometrics, reboot restore,
  and notification delivery.
- The MVP uses atomic whole-snapshot replacement for real scan/edit persistence;
  very large libraries should move to incremental per-feature DAO writes.
- Scans are incremental and idempotent but do not yet expose pause/cancel/resume.
- OCR uses the bundled Latin recognizer only.
- Reverse geocoding may depend on the device service; manual place entry is the
  reliable fallback.
- The graph intentionally limits visible media/nodes for responsive layout.
- Ordinary SQLite is not encrypted at rest.
- There is no trained face recognition, bundled embedding model, cloud backup,
  contact sync, or generative cloud story service.

## Documentation

- [PROJECT_PLAN.md](PROJECT_PLAN.md)
- [ARCHITECTURE.md](ARCHITECTURE.md)
- [DATABASE_SCHEMA.md](DATABASE_SCHEMA.md)
- [PRIVACY.md](PRIVACY.md)
- [TESTING.md](TESTING.md)
- [DEMO_GUIDE.md](DEMO_GUIDE.md)
- [FUTURE_ENHANCEMENTS.md](FUTURE_ENHANCEMENTS.md)
