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
00:04 +31: All tests passed!
```

Test sources live under
`test/unit`, `test/database`, `test/features`, and `test/widget_test.dart`.

## Verified Android artifact

`flutter build apk --debug` completes successfully. Artifact evidence:

| Check | Result |
|---|---|
| Path | `build/app/outputs/flutter-apk/app-debug.apk` |
| Size | 211,983,497 bytes |
| Application ID | `com.mkce.smartmemory` |
| SDKs | min 24, target 36, compile 36 |
| ABIs | armeabi-v7a, arm64-v8a, x86_64 |
| Signature | Valid Android debug certificate, APK Signature Scheme v2 |
| SHA-256 | `0f2b8e8ca72d307f771adfb64bb4053995721858987bb9107bae9b823f293ac7` |

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
