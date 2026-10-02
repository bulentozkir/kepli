# Kepli releases

Release binaries are **not committed** (they are large and reproducible); this
folder holds them locally, with [SHA256SUMS.txt](SHA256SUMS.txt) committed so
you can verify a copy.

## 1.0.0 (build 1) - Android

| File | Use |
|---|---|
| `kepli-1.0.0-build1-android-release.apk` | Install directly on Android phones and tablets (Android 7.0+, API 24) |
| `kepli-1.0.0-build1-android-release.aab` | Android App Bundle for store upload |

Both were built with Flutter 3.44.7 (`flutter build apk|appbundle --release`),
shrunk with R8, and signed with APK Signature Scheme v2. Requested permissions:
notifications, restore reminders after reboot, and vibration. **No internet
permission is requested.**

Verify a download:

```powershell
Get-FileHash .\kepli-1.0.0-build1-android-release.apk -Algorithm SHA256
```

### Signing - read before distributing

These builds are signed with a **locally generated sideload key**
(`CN=Kepli sideload build`, certificate SHA-256
`a7c947194a00286cf038dd3d644ef39d0200414af5d0c65037bd9dc19817e915`), stored
outside the repository. That means:

- The APK is fine for **sideloading and testing**. Android will show it as
  coming from an unknown developer.
- **Do not upload this AAB to Google Play as-is.** Play requires you to enroll
  in Play App Signing and register your own upload key. Create a keystore you
  control, put it in `android/key.properties` (see below), rebuild, and upload.
- An app signed with a different key cannot update one signed with this key;
  users would have to uninstall first, losing local data unless they export a
  backup. Choose your long-term key before wide distribution.
- Losing the key means you can never ship updates to installs signed with it.
  Back it up safely and never commit it.

Signing is configured by an untracked `android/key.properties`:

```properties
storeFile=C:/path/to/your.jks
storePassword=...
keyAlias=...
keyPassword=...
```

Without that file, release builds are left unsigned rather than silently using
the debug key.

## Other platforms

Not built here. This Windows machine has no Xcode (iOS/macOS) and no Visual
Studio C++ workload (Windows desktop), and Linux needs a Linux host. The
[CI workflow](../.github/workflows/ci.yml) builds iOS (simulator), Windows,
Linux and macOS; store/notarized releases additionally need your Apple
Developer and Windows signing identities.
