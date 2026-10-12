# Privacy and security

## Principles

1. The Android gallery remains the owner of original photos and videos.
2. Required MVP behavior works without an account, network, paid API, or cloud.
3. Permission denial and selected-photo access are supported product states.
4. Sensitive-event policy is enforced before proactive UI and notification output.
5. Research/demo language must not overstate what local scoring can infer.

## Data processed locally

Smart Memory may store asset IDs, media type, timestamps, optional embedded
coordinates, dimensions, duration, file size when available, thumbnail fingerprint,
OCR text, processing versions, events, confirmed people/places, stories, app-private
voice-note paths, graph relationships, score factors, recommendations, reminders,
feedback, and scan history.

Original image/video bytes are not SQLite columns. A bounded thumbnail may be held
in memory or a temporary app file for OCR/fingerprinting and is not treated as a new
gallery original.

## Permissions

- Media read permissions are requested only from the import flow.
- Android selected-photo access is respected and can legitimately return no items.
- Embedded media location access is distinct from current-device location; no
  fine/coarse/background location permission is declared.
- Microphone access is requested only after the user taps record.
- Biometrics are optional and cannot be enabled on an unsupported device; once
  enabled, app entry requires successful device authentication.
- Notification access is requested only when scheduling a time capsule.
- Contacts, all-files access, gallery write/delete, and exact-alarm permissions are
  absent. Flutter's debug/profile manifests add development Internet access for the
  debugger/hot reload; the main manifest and application code add no network client
  or upload path.

## Photo location names

Capture coordinates are read from accessible gallery media and stored locally.
The optional device geocoding service translates these coordinates into place
names; that operating-system service may use its own network provider. A place
name is not required: coordinates remain usable offline, and photos without GPS
can be assigned a manual place. The app never substitutes the device's current
location for a photo's capture location.

Hidden events are excluded from the personal memory graph, and their locations
are concealed on timeline cards.

## Sensitivity gate

Sensitivity is user-controlled in the MVP; the app does not infer it from content.
A hidden/sensitive event:

- conceals its preview;
- is removed from proactive recommendations;
- cannot schedule an automatic notification;
- can only receive a reminder after an explicit action, using neutral text;
- never exposes a title, people, place, OCR text, story, or thumbnail in a payload.

The lock-screen message is: **“You have a memory ready to revisit.”**

## Security controls and limitations

- `flutter_secure_storage` protects small preferences such as the biometric-gate
  flag; it does not encrypt the Drift database.
- `local_auth` is an optional application access gate, not encryption at rest.
- Android backup is disabled (`allowBackup=false`).
- Cleartext traffic is disabled. The main manifest has no Internet permission; the
  supplied debug APK includes Flutter's standard development Internet permission.
- Ordinary app-private SQLite/OCR/person data is not claimed to be cryptographically
  encrypted. SQLCipher or equivalent is future work.
- Logs should never print asset identifiers, OCR text, names, stories, coordinates,
  audio paths, or secure values.

## Derived-data deletion

The data-management screen clears normalized derived database rows, cancels local
notifications, and removes known app-private voice-note files after explicit
confirmation. OCR temporary files are already deleted by their adapter, and
thumbnails are held in memory/reloaded from the Android asset identifier rather than
persisted as gallery copies. Small privacy preferences are retained. The operation
never invokes an Android gallery deletion API, so source photos and videos remain in
their original location.

## Cloud policy

Cloud backup, cloud stories, contact sync, and remote AI processing are disabled and
not silently mocked. A future encrypted backup must be explicit opt-in, document
keys/retention/deletion, and preserve an offline-only mode.
