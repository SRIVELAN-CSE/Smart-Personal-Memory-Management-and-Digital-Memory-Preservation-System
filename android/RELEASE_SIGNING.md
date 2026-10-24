# Updating the existing Smart Memory installation

Android requires an update to keep application ID `com.mkce.smartmemory` and use
the original signing key (or a valid signing-key rotation). Increasing the version
number alone does not fix a signing-key mismatch.

On 23 October 2026, the local historical APKs (`previous-schema1.apk` and
`app-debug.apk`) were verified with this signing-certificate SHA-256:

```
697978d4e52d391b3de08de7a78ed340c92e96fb45e3bb99b6bb4fa4417f8b31
```

The release APK built on this PC on 23 October used a newly created debug key:

```
2d7b4f5e31f47672bb9aa35a0d7024a95be10b844de61f5f8beb38ff00628935
```

These certificates are different. That release APK cannot replace an installation
signed with the historical key. On 23 October, the authorized phone's installed
version 1.0.0 (code 1) APK was copied and verified: it uses the historical key above.

## Preserve existing memories

Keep the existing app installed and do not clear its storage. Its database, stories,
voice notes, and other private data must remain available to the update. The app's
manifest disables Android backup; do not assume uninstalling is recoverable.

Find the original `.android/debug.keystore` on the computer/account that built the
old APK, or restore that file from a backup. A debug certificate's public metadata
and an APK do not contain the private signing key. Creating another debug keystore
with the same alias/password does not recreate the original key.

## Configure and verify the original key

### Starting from the GitHub ZIP on the original laptop

Extract the ZIP into a new folder. Keep the original project and its signing key
until the update has been installed and the saved memories have been checked.
The latest checks used Flutter 3.47.7, Java 17, Android Platform 36, and NDK
28.2.13676358. Gradle, AGP, and Kotlin versions are pinned in this repository.
The ZIP does not include downloaded SDKs, dependency caches, machine-specific
`local.properties`, APKs, or signing keys.

On the original Windows laptop, locate the existing key at
`C:/Users/<your-username>/.android/debug.keystore`. Do not replace or regenerate it.
In the extracted project's root, run:

```powershell
Copy-Item android/key.properties.example android/key.properties
notepad android/key.properties
```

Change `storeFile` to that original key's absolute path using forward slashes.
Keep the example alias/password only if the original debug key used the standard
Android defaults. Then run:

```powershell
flutter doctor -v
flutter pub get
flutter build apk --release
```

Ensure Flutter reports Java 17; if necessary, set it with
`flutter config --jdk-dir="C:/path/to/your/jdk-17"` using the actual local JDK path.
Flutter prepares the Android wrapper files when building from a fresh checkout.
The release build automatically validates the key against the original certificate.
If validation reports a mismatch, stop and locate the correct original key.
The resulting APK is `build/app/outputs/flutter-apk/app-release.apk`.

### Signing checklist

1. Keep the recovered keystore in a secure location outside `build/`.
2. Copy `android/key.properties.example` to `android/key.properties` and set its
   `storeFile` to that recovered file. The example passwords/alias are Android's
   standard debug-key defaults; use the original values if they were customized.
3. Once Flutter has prepared the wrapper, from `android/` you can run
   `./gradlew.bat :app:validateReleaseSigning` with Java 17 as a separate check.
4. Once validation succeeds, run `flutter build apk --release` from the project
   root. If the installed app has a higher version code than `pubspec.yaml`, use
   a higher `--build-number` too.
5. Verify the output using `apksigner verify --verbose --print-certs`, compare its
   certificate with the installed APK, and install it as an update without clearing
   app data. Check saved memories after the update.

Release builds no longer fall back to this machine's debug key. The
`validateReleaseSigning` task checks the private-key entry and pins the historical
certificate before release packaging. Missing or mismatched keys fail the build.
Do not change the pinned fingerprint simply to make validation pass.

`key.properties`, `*.keystore`, and `*.jks` under `android/` are ignored by Git.
Never commit signing keys or passwords.

If the original key cannot be recovered, a normal in-place update preserving the
installed app's private data is blocked. Do not claim that rebuilding or resigning
with a new key resolves this. A device-specific data-recovery or export path would
need to be assessed separately before any uninstall.

Reference: https://developer.android.com/studio/publish/app-signing

## Verification on 23 October 2026

- `flutter analyze --no-pub`: no issues found.
- `flutter test --no-pub --reporter expanded`: all 94 tests passed, including
  upgrades from database schemas 1, 2, and 3 preserving saved memory context.
- Missing `key.properties`: release signing validation rejected the build.
- This PC's new debug key: `preReleaseBuild` invoked validation and rejected the
  mismatched certificate. The temporary test configuration was removed.
- The historical `previous-schema1.apk` is debuggable, but the actual installed
  release is not. An authorized USB check returned `run-as: package not debuggable`.
- The installed manifest sets `android:allowBackup="false"`. The app's privacy
  settings and data-management screen provide no backup/export control.
- The installed APK was saved locally under `build/device-recovery/`. This copies
  the application binary only, NOT its saved memories, database, or signing key.
- No replacement APK has been built with the original key, and installation on
  the user's phone is blocked by the missing original key. No uninstall, data
  clearing, or replacement was performed. Passing tests is not proof of a compatible
  signature or a successful on-device update.
