# Smart Memory — Project Plan

## Document status

| Field | Value |
|---|---|
| Product title | Smart Personal Memory Management and Digital Memory Preservation System |
| App name | Smart Memory |
| Flutter project | `smart_memory_preservation` |
| Android application ID | `com.mkce.smartmemory` |
| Primary platform | Android |
| Plan baseline | 31 August 2026 |
| Current lifecycle state | Phase 7 — Android device validation |

This plan is the delivery contract for the MVP. A phase is complete only after its
implementation, formatting, analysis, relevant automated tests, and documentation
have all passed. A scaffold, mock screen, or unverified code path does not by itself
complete a phase.

## Product outcome

Smart Memory will turn device-gallery media into editable event memories, then help
the user preserve missing personal context. Automatic grouping is preprocessing,
not the claimed innovation. The core contribution is an offline-first,
explainable preservation decision engine that combines:

- an application-level significance estimate;
- rediscovery risk, meaning the chance that a record remains unopened in this app;
- context completeness;
- a sensitivity safety gate.

The application must never claim to infer emotion, biological forgetting, or
scientific effectiveness from demo scores.

## Delivery guardrails

- Original gallery photos and videos remain unchanged.
- SQLite stores media identifiers/references and derived metadata, never original
  full-resolution media bytes.
- OCR, deterministic clustering, scoring, and template summaries run locally.
- Cloud backup, cloud-generated stories, contact synchronization, face identity,
  and trained custom models are outside the initial MVP.
- Permission denial and limited-photo access are normal supported states.
- Demo mode remains fully usable without gallery permission or device media.
- People identities are assigned only after explicit user confirmation.
- Sensitive or hidden memories cannot produce revealing lock-screen content.
- External integrations remain replaceable behind interfaces.

## Verified environment baseline

The workspace was empty when inspected: no files, no Flutter project, and no Git
repository were present.

| Component | Verified finding | Readiness |
|---|---|---|
| Flutter | 3.35.4 stable, framework `d693b4b9dbac2acd4477aea4555ca6dcbea44ba2` | Installed |
| Flutter engine | `c29809135135e262a912cf583b2c90deb9ded610` | Installed |
| Dart | 3.9.2 stable, Windows x64 | Installed |
| DevTools | 2.48.0 | Installed |
| Flutter location | `C:\flutter` | Installed, runner caveat below |
| System Java/Javac | Oracle 26.0.1 | Installed but not selected for Android builds |
| `JAVA_HOME` | `C:\Program Files\Java\jdk-17` | Invalid; directory does not exist |
| Android Studio JBR | OpenJDK 21.0.7, build `21.0.7+-13880790-b1038.58` | Recommended Gradle JDK |
| Android Studio | Build `AI-251.26094.121.2513.14007798` | Installed |
| `ANDROID_HOME` | `C:\Users\HP\AppData\Local\Android\Sdk` | Valid |
| `ANDROID_SDK_ROOT` | Unset | Non-blocking when `ANDROID_HOME` is valid |
| Android platforms | 31, 33, 34, 35, 35-ext14, 36 | Required API 36 installed |
| Android Build Tools | 35.0.0, 36.0.0, 36.1.0-rc1 | Stable 36.0.0 installed |
| Command-line Tools | 19.0 | Installed |
| Platform Tools / ADB | 36.0.0 / ADB 1.0.41 | Installed |
| Emulator | 36.1.9, build 13823996 | Installed |
| NDK | 27.0.12077973 | Installed |
| Android licenses | Accepted; `flutter doctor -v` reports no issues | Verified |
| Standalone Gradle | Not on PATH | Expected; use the project wrapper |

The installed Flutter 3.35.4 template defines these compatible Android defaults:

| Setting | Value |
|---|---|
| Dart environment | `>=3.9.0 <4.0.0` |
| Minimum Android SDK | 24 |
| Compile Android SDK | 36 |
| Target Android SDK | 36 |
| Gradle wrapper | 8.12 |
| Android Gradle Plugin | 8.9.1 |
| Kotlin Gradle Plugin | 2.1.0 |
| NDK | 27.0.12077973 |

These defaults should remain in place unless a selected dependency has a documented,
tested requirement to change one of them.

## Verified environment and remaining constraints

`flutter doctor -v` completed successfully after applying process-local PATH and
JBR 21 overrides and reported **No issues found**. Dependency resolution, Drift
generation, static analysis, 31 automated tests, and the signed debug APK build
now succeed. The machine-wide
`JAVA_HOME` still points to a missing JDK, so documented commands continue to use
Android Studio's JBR 21 without changing global settings.

Remaining validation is device-specific: Android full/selected gallery access,
OCR against real assets, foreground voice recording, biometrics, notification
delivery/reboot behavior, and destructive-data UX must be smoke-tested on an
emulator or physical device. Real scans, corrections, score factors,
recommendations, reminders, and feedback are repository-backed through an atomic
normalized Drift snapshot; production-scale libraries should later replace full
snapshot writes with incremental DAO updates.

## Status legend

- [x] Verified or completed
- [ ] Pending
- **Blocked**: attempted, with a documented external/tooling constraint

## Phase roadmap

### Phase 1 — Environment and planning

- [x] Inspect the opened workspace and preserve existing contents.
- [x] Identify Flutter, Dart, Java, Android Studio, SDK, build tools, emulator, and
  NDK versions.
- [x] Run `flutter doctor -v` successfully with process-local toolchain overrides.
- [x] Define compatible Flutter/Android build constraints.
- [x] Create `PROJECT_PLAN.md`.
- [x] Create `ARCHITECTURE.md`.
- [x] Create the Flutter project with the required identity.
- [x] Configure build commands to use Android Studio JBR 21.
- [x] Capture a clean `flutter doctor -v` result.
- [x] Resolve and lock compatible package versions.

Exit gate: a generated Android-focused Flutter project exists, the architecture is
recorded, dependency resolution succeeds, and all remaining environment exceptions
are explicitly documented.

### Phase 2 — Foundation

- [x] Establish feature-first clean-architecture folders.
- [x] Configure Riverpod, GoRouter, Material 3 themes, and reusable UI states.
- [x] Configure Drift, foreign keys, migrations, repositories, and indexes.
- [x] Add deterministic demo fixtures, including the final-year review scenario.
- [x] Implement splash, onboarding, privacy explanation, permission state, and
  dashboard.
- [x] Add error, empty, loading, permission-denied, and demo-mode states.
- [x] Add foundation unit and widget tests.

Exit gate: demo mode reaches a functional dashboard from a fresh install, persists
seed data locally, and passes foundation analysis/tests.

### Phase 3 — Media intelligence

- [x] Request only the Android media permissions needed for the OS version.
- [x] Support full, limited/selected, and denied access with demo fallback.
- [x] Implement incremental and idempotent gallery scanning.
- [ ] Add user-initiated cancellation and resumable scan cursors.
- [x] Persist asset references and metadata without storing original bytes.
- [x] Extract time, optional location, dimensions, duration, size, and media type.
- [x] Generate a duplicate fingerprint from a thumbnail/derived representation.
- [x] Run on-device OCR on bounded-size thumbnails through a replaceable adapter.
- [x] Implement deterministic event clustering with configurable thresholds.
- [x] Persist scan start/completion/failure audit data and generated events.
- [x] Test empty galleries and missing time, GPS, or OCR signals.

Exit gate: permitted media can be scanned twice without duplicates, derived event
groups are persisted, and denial/demo paths remain fully operational.

### Phase 4 — Memory management

- [x] Build story timeline and event-detail experiences.
- [x] Implement rename, story, cover, favourite, rating, and sensitivity.
- [x] Implement merge, split, and add/remove-media operations transactionally.
- [x] Add manual people and place tagging.
- [x] Add written notes and locally stored voice-note references.
- [x] Build the interactive memory graph and node-detail navigation.
- [x] Ensure derived-data deletion cannot delete source gallery assets.

Exit gate: the user can correct generated groups and navigate event, media, person,
place, note, and voice-note relationships without data corruption.

### Phase 5 — Prediction and preservation

- [x] Implement explainable significance scoring.
- [x] Implement explainable rediscovery-risk scoring.
- [x] Implement context-completeness scoring.
- [x] Implement the sensitivity gate and preservation-need calculation.
- [x] Persist normalized factor contributions, score version, and timestamp.
- [x] Generate local, editable, template-based timeline summaries.
- [x] Build recommendation inbox and recommendation-detail explanations.
- [x] Add exact actions for missing people, story, voice context, and time capsule.
- [x] Validate the supplied demo values as illustrative fixtures, not research claims.

Exit gate: every displayed score has reproducible inputs and factor-level
explanations, and sensitive fixtures never create unsafe recommendations.

### Phase 6 — Reminders and security

- [x] Implement inexact local notification scheduling.
- [x] Use neutral lock-screen notification wording.
- [x] Implement future time capsules, dismissal, completion, and feedback.
- [x] Add optional biometric protection with a non-crashing fallback.
- [x] Store the biometric preference through secure local storage.
- [x] Build privacy dashboard and derived-data management.
- [x] Keep cloud backup disabled and absent from runtime behavior.

Exit gate: time capsules work locally, privacy controls are enforceable, and locked
or sensitive content is never exposed through notification previews.

### Phase 7 — Quality assurance and handoff

- [x] Run Dart formatting over maintained source and tests.
- [x] Run `flutter analyze` with no issues.
- [x] Run all unit, repository, feature, and widget tests.
- [x] Build and verify a debug APK.
- [ ] Smoke-test fresh install, demo mode, denial, limited access, and full access.
- [x] Verify schema creation, foreign keys, and derived-data deletion.
- [ ] Add a historical migration fixture when schema version 2 is introduced.
- [x] Complete README, database, privacy, testing, demo, and future-work documents.
- [x] Record known limitations and device-specific validation status honestly.

Exit gate: the application launches, all required MVP paths work, automated checks
pass, a debug APK is produced, and documentation is reproducible.

## Required verification matrix

| Area | Minimum evidence |
|---|---|
| Clustering | Unit tests for time/location/OCR similarity, missing signals, and boundaries |
| Scoring | Golden numeric tests for each factor and final preservation need |
| Sensitivity | Tests proving hidden/sensitive memories cannot reach unsafe notifications |
| Persistence | Snapshot/repository round trips, atomic replacement, foreign keys, safe deletion, schema version |
| Permissions | Host tests for denial/full access; Android selected-photo behavior remains a device gate |
| Gallery import | Empty gallery, duplicate scan, missing GPS/OCR, and item-scoped failure handling |
| UI | Timeline and recommendation explanation widget tests |
| Build quality | Format, analyze, complete tests, and debug APK |

## MVP acceptance criteria

The MVP is accepted only when all of the following are demonstrably true:

- It launches without crashing and demo mode needs no gallery content.
- Permission denial is safe and recoverable.
- Gallery media can be scanned incrementally after permission is granted.
- Media becomes deterministic, editable event cards.
- Event data can be renamed, split, merged, tagged, and contextualized.
- The personal memory graph is visible and navigable.
- Significance, rediscovery risk, context completeness, and preservation need are
  shown with plain-language explanations.
- Recommendations lead to working story, voice-note, people-tag, revisit, or
  time-capsule actions.
- Sensitive memories do not leak through recommendations or notifications.
- SQLite contains references and derived data, not original gallery bytes.
- Formatting, analysis, automated tests, and the debug APK build succeed.

## Risk register

| Risk | Impact | Mitigation |
|---|---|---|
| Android permission behavior differs by API level | Scan unavailable or overbroad access | Capability adapter, API-level tests, demo fallback |
| Plugin requirements conflict | Build failure | Lock only verified versions; preserve Flutter template defaults |
| OCR/thumbnail work causes memory pressure | Jank or process termination | Bounded thumbnails, background queues, concurrency limits |
| Missing or inaccurate metadata | Incorrect grouping | Treat signals as optional; expose correction tools |
| Event merge/split loses relationships | Data corruption | Single Drift transaction plus repository tests |
| Rule scores are misread as scientific predictions | Research-integrity failure | Explicit labels, methodology page, stored factor explanations |
| Notifications reveal sensitive context | Privacy harm | Hard sensitivity gate and neutral text |
| Gallery assets become unavailable | Broken preview | Preserve stable asset ID, surface missing-media state, never cascade-delete source |
| Schema evolves during development | Lost derived data | Versioned, tested forward migrations |

## Working protocol

At the end of every implementation phase:

1. Format maintained code.
2. Run static analysis.
3. Run relevant deterministic tests.
4. Fix discovered failures rather than merely documenting them.
5. Update this checklist and any affected architecture decision.
6. Report completed work, evidence, blockers, and remaining scope without overstating
   untested device behavior.
