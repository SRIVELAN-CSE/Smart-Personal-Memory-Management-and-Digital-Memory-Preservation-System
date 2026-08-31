# Future enhancements

The MVP deliberately favors deterministic local behavior. Future modules must
implement existing domain interfaces and must not weaken privacy or research
integrity.

## Priority 1 — production hardening

- Replace the verified atomic whole-snapshot repository with incremental DAO writes
  and Drift streams for production-scale libraries.
- Add resumable background processing with charging/battery/concurrency policies.
- Reconcile moved/deleted gallery assets by soft availability state and fingerprint.
- Add retryable cleanup jobs and cancel individual notification IDs when one event
  is deleted; global derived-data deletion already removes known voice files and
  cancels all local notifications.
- Add historical Drift schema snapshots and forward-migration tests.
- Add Android integration tests for API 31–36 permissions and selected-photo access.

## Priority 2 — stronger private intelligence

- Bundle and version a small, licensed on-device visual embedding model; never
  fabricate embeddings when a model is absent.
- Add on-device face *detection* for optional tag suggestions while keeping identity
  assignment manual and confirmed.
- Add multilingual ML Kit recognizers as optional downloadable/build variants.
- Improve place labels with cached reverse geocoding and reliable manual override.
- Evaluate clustering thresholds on consented, anonymized research fixtures.

## Priority 3 — privacy and resilience

- Offer SQLCipher/SQLite3MultipleCiphers with documented licensing and key recovery.
- Add encrypted export/import with user-held recovery material.
- Add an explicit opt-in, end-to-end encrypted backup adapter; preserve a permanent
  offline-only mode and a verified remote-deletion path.
- Add per-event access controls and screenshot/recents-screen protection where
  supported.

## Priority 4 — richer preservation

- Event-to-event relationship editing and semantic graph filters.
- Audio playback, waveform, transcription performed locally, and accessible captions.
- Anniversary/seasonal time-capsule recurrence with user-controlled frequency.
- Recommendation cooldown learning based only on local explicit feedback.
- Tablet/foldable layouts, desktop read-only archive view, localization, and full
  accessibility audit.

## Explicit non-goals until validated

- No claim of emotion detection or biological forgetting prediction.
- No automatic face identity assignment.
- No cloud story generation or media upload by default.
- No contact/music-history synchronization without separate explicit permission and
  a documented product need.
- No scientific-effectiveness claim from the supplied demo scores.
