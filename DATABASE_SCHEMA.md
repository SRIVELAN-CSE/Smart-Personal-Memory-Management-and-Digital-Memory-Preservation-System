# Database schema

Smart Memory uses Drift over SQLite. Schema version 1 contains 21 normalized tables.
Timestamps represent UTC instants; Drift may materialize them in the host local time
zone, so domain comparisons normalize with `toUtc()`.

## Storage boundary

`media_items` stores Android asset identifiers, metadata, bounded-analysis results,
and availability state. It does **not** store original photo/video bytes. Voice-note
rows point to app-private audio files rather than storing audio blobs.

## Tables

| Table | Purpose |
|---|---|
| `scan_history` | Scan status, optional resume cursor, counts, permission mode, and sanitized error summary |
| `media_items` | Unique source/asset identifier, type, capture metadata, OCR, fingerprint, optional embedding metadata |
| `places` | Confirmed/manual place label and optional coordinates |
| `events` | Generated/confirmed event data, cover, rating, favourite, sensitivity, interaction summaries |
| `event_media` | Ordered many-to-many event/media membership with origin and confidence |
| `persons` | User-confirmed names only |
| `event_persons` | Event/person relationships |
| `media_persons` | Optional media/person relationships |
| `notes` | Written context linked to an event |
| `voice_notes` | App-private path, duration, and event relationship |
| `graph_nodes` | Rebuildable typed-node projection |
| `graph_edges` | Contains/attended/occurred-at/has-note/related relationships |
| `significance_scores` | Normalized score, algorithm version, evaluation time, factor JSON |
| `rediscovery_scores` | App-usage risk and factor contributions |
| `context_scores` | Completeness score and factor contributions |
| `preservation_recommendations` | Action, explanation, need, sensitivity policy, and status |
| `reminders` | Scheduled local time capsule, notification ID, neutral-content policy |
| `user_feedback` | Recommendation feedback/dismissal information |
| `privacy_settings` | Singleton local privacy/security preferences |
| `event_interactions` | Append-only views, corrections, reminder impressions/dismissals |
| `processing_jobs` | Deduplicated resumable OCR/clustering/graph/scoring work |

## Relationships

```mermaid
erDiagram
  EVENTS ||--o{ EVENT_MEDIA : contains
  MEDIA_ITEMS ||--o{ EVENT_MEDIA : belongs_to
  EVENTS ||--o{ EVENT_PERSONS : attended_by
  PERSONS ||--o{ EVENT_PERSONS : attends
  MEDIA_ITEMS ||--o{ MEDIA_PERSONS : depicts_confirmed
  PERSONS ||--o{ MEDIA_PERSONS : tagged_in
  PLACES o|--o{ EVENTS : location
  EVENTS ||--o{ NOTES : has
  EVENTS ||--o{ VOICE_NOTES : has
  EVENTS ||--o| SIGNIFICANCE_SCORES : evaluated_by
  EVENTS ||--o| REDISCOVERY_SCORES : evaluated_by
  EVENTS ||--o| CONTEXT_SCORES : evaluated_by
  EVENTS ||--o{ PRESERVATION_RECOMMENDATIONS : receives
  PRESERVATION_RECOMMENDATIONS ||--o{ REMINDERS : schedules
  EVENTS ||--o{ EVENT_INTERACTIONS : records
  GRAPH_NODES ||--o{ GRAPH_EDGES : source
  GRAPH_NODES ||--o{ GRAPH_EDGES : target
```

Foreign keys cascade for event-owned joins, scores, recommendations, and graph
projection rows. Removing a place sets the event place to null. A missing gallery
asset is soft-marked unavailable. Deleting a derived event deliberately retains
`media_items` references and never touches the Android gallery.

`MemorySnapshotRepository` serializes writes and replaces non-demo normalized rows
inside one transaction. This makes split/merge/membership corrections atomic while
retaining demo rows and scan audit rows. It also reconstructs the complete domain
snapshot on restart, including unassigned media, factor explanations, reminders,
and feedback.

## Indexes and constraints

Important indexes cover media capture time/fingerprint/processing state, event
start/sensitivity, both directions of junctions, graph source/target, pending
recommendations, scheduled reminders, scans, jobs, and event interactions.
Uniqueness includes source asset identity and junction composite keys. Scoring
engines clamp values to 0–1 before persistence; schema-level score checks are a
future hardening option.

## Migration strategy

- `schemaVersion` starts at 1.
- `createAll()` creates the initial normalized schema and annotated indexes.
- `PRAGMA foreign_keys = ON` runs before use; production also enables WAL and a busy
  timeout in the background database connection.
- Future versions must add explicit sequential migrations, add/backfill nullable or
  defaulted fields first, and test every historical schema.
- Generated `app_database.g.dart` is recreated with:

```powershell
dart run build_runner build --delete-conflicting-outputs
```

## Demo seed

`DemoSeedRepository.ensureSeeded()` is idempotent and creates the supplied academic
event, 18 media references, two people, a place, graph projection, three score rows,
and one recommendation. `isIllustrative` remains true on demo score data.
