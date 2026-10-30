# Smart Memory 1.0.2 (build 4)

## Recording comparison

Compared the supplied recordings using timestamped frames. The earlier recording shows an event-centred circular graph at approximately 3:35 and 4:05, event media and selection/sharing at 2:55–3:25, and a separate Companion bottom tab. The newer recording shows three search fields at 0:05–0:25, a crowded multi-event graph at 0:35–0:55, and multiple preservation suggestions for the same event at 1:35–2:25.

## Changes in this release

- Graph: event selector, central circular thumbnail, related circular media/person/place/story/voice nodes, pan/zoom and reset controls. Open the event to see all media and people.
- Navigation: Home, Timeline, Graph, Preserve and Companion are separate bottom destinations.
- Timeline: one search field matches event titles, tagged people and saved places. A funnel to its left opens calendar filters including yesterday, last week, last month and an inclusive custom date range. Favourites can be combined with search and dates.
- Events: browsable photo/video thumbnails, full-screen previews, original-photo/video opening, multiple selection and Android sharing. Sharing occurs only when the user chooses a recipient in the system share sheet.
- Preservation: the event itself shows its saved story and voice note. Voice notes have play/pause and progress controls and can be replaced by a new recording. The Preserve tab lists each event once, with direct story/voice actions.
- OCR: new imports use an aspect-preserving image up to 2048 pixels instead of the 512-pixel cover. In the photo viewer, Extract text opens a readable/copyable sheet; Read original photo reruns recognition and saves the result to the library. OCR remains the bundled local Latin recognizer; blurred text and unsupported scripts can still fail.
- Locations: asynchronous gallery metadata plus original-image EXIF/content-URI video metadata fallback. Existing imports can be rechecked without duplicate events. A manually confirmed event place also labels media without GPS, separately from original capture coordinates.
- Companion: fixes duplicate per-event person tags, polite/plural favourites queries, missing-story queries and unknown-place matching. Person/place answers use stored tags; ambiguous actions ask the user to choose an event. Retrieval is local and deterministic, with up to 20 event matches per answer.
- Appearance: phone-size light/dark layout coverage and better score-label contrast in dark mode.

## Location expectations

Camera media can expose capture coordinates if the camera saved them and Android grants media-location access. Screenshots, screen recordings, downloaded files and movies commonly contain no capture GPS. No app can recover exact historical capture coordinates that were never recorded. Use **Add location** to supply a known place for those events. The app never substitutes the phone's present location for historical GPS.

For existing imports: Timeline → Scan → Review gallery & location access → enable Recheck missing photo locations → Start on-device scan. Optional device place-name lookup can turn saved GPS into names; it requires the device service to be available. Coordinates remain usable without it.

Technical references: [Android shared-media access](https://developer.android.com/training/data-storage/shared/media), [video metadata](https://developer.android.com/reference/android/media/MediaMetadataRetriever), [ML Kit text recognition image requirements](https://developers.google.com/ml-kit/vision/text-recognition/v2/android).

## Verification and artifact

- Flutter analysis: no issues found; full regression suite: 95 tests passed on 28 October 2026.
- Release build completed successfully on 28 October 2026: version 1.0.2, build 4, package `com.mkce.smartmemory`, minimum Android API 24, target API 36.
- APK: `build/app/outputs/flutter-apk/app-release.apk`, 96,729,649 bytes. Build output is local and excluded from Git.
- SHA-256: `A1012912BCFE6F432E27D78F8A6632EE56F6628BD130001654473F3380884DAF`.
- APK ZIP integrity and v2 signature verified. This review build uses the existing local Android debug signing certificate.
- Installed successfully over 1.0.1 on the Vivo V2303, preserving 457 events. Phone checks confirmed the circular graph, navigation, date-filter options, favourite persistence after restart, and opening the share chooser for selected media. The test favourite was restored and the share chooser dismissed without sending media.
- Full microphone/playback, OCR and location checks on physical hardware remain incomplete; automated tests cover their applicable logic and controls. The remaining phone check was interrupted by a tool approval-review usage limit.

Older build results in other project notes describe earlier versions. The proposed Memory Survival Test feature has not been implemented in this release.
