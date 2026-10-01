# Kepli

Private, offline warranty and receipt tracking for Android phones and tablets,
iPhone and iPad, Windows, Linux, and macOS.

No account, subscription, analytics, or Kepli cloud. Your records live in a local
SQLite database. A portable ZIP backup contains the records and their attachment
bytes, not links to another device's filesystem.

## Implemented

- Create, edit, search, filter, claim, and delete warranties; calendar-correct
  month/year durations and expiry dates.
- Optional exact-decimal prices, currencies, vendors, notes, and managed
  categories.
- Multiple sales/service contacts per warranty, including company, phone, email,
  notes, and business cards linked to the correct person.
- Receipt, warranty-paper, product-photo, and business-card attachments.
- Mobile camera and photo-library capture; native file import on every target.
- Offline multipage document scanning: capture/import pages, rotate, crop with
  accessible controls, enhance contrast, and create a PDF. **No OCR or automatic
  contact extraction.** Enter contact details manually.
- Versioned ZIP backup, validated preview, newest-by-ID merge, conflict
  overrides, and explicitly confirmed replacement. Files are staged before the
  database commit; current attachment bytes are never overwritten in place.
- CSV reports and per-warranty PDF reports with contact details and embedded
  images. Existing PDF attachments are referenced by filename, not merged into
  the generated report.
- Local reminders with editable day thresholds and local hour.
- Adaptive phone/tablet/desktop layouts, keyboard navigation, screen-reader
  labels, 48 logical-pixel action targets, large-text reflow, dark mode,
  increased contrast, and reduced motion.
- **30 bundled interface languages**, English by default, selected in Settings.
  Arabic, Persian, and Urdu use right-to-left layouts. User-entered text is not
  translated. Native-script numbers and decimal comma/dot input are supported.

### Platform capabilities

| Capability | Android phone/tablet | iPhone/iPad | Windows | Linux | macOS |
|---|---|---|---|---|---|
| Local records, contacts, attachments, backup/restore, reports | Yes | Yes | Yes | Yes | Yes |
| Camera and photo library | Yes | Yes | File import | File import | File import |
| Offline scan editing/PDF creation | Camera or images | Camera or images | Imported images | Imported images | Imported images |
| Save exported files | System document picker | Share sheet / Save to Files | Save As | Save As | Save As |
| Reminders when app is closed | OS-scheduled, approximate | OS-scheduled, bounded queue | Requires installed MSIX identity | Not supported | OS-scheduled |

Desktop does not implement webcam capture, TWAIN/WIA scanner control, or a
background Linux service. Import files produced by a camera or scanner instead.
The UI does not advertise unsupported desktop camera capabilities.

Reminders are not guaranteed: permission, battery optimization, system settings,
clock changes, and OS queue limits affect delivery. At most the nearest 60
reminders are queued; reopen Kepli to replenish them. Linux reminders require an
open app and an available notification daemon. The expiring-soon list is always
available.

### Languages

The supported set is English, Simplified Chinese, Hindi, Spanish, French,
Arabic, Bengali, Portuguese, Russian, Indonesian, Urdu, German, Japanese,
Marathi, Vietnamese, Telugu, Turkish, Gurmukhi Punjabi, Tamil, Korean, Persian,
Swahili, Italian, Gujarati, Thai, Kannada, Polish, Ukrainian, Malayalam, and Dutch.
This is a documented set of 30 widely used languages, not a claim about a fixed
global speaker ranking. Native-speaker review remains part of release QA.

## Development

Pinned toolchain: **Flutter 3.44.7 / Dart 3.12.2**, Java 17, Android SDK 36.
The Flutter pin is in [.fvmrc](.fvmrc) and is also used by CI.
Dependency versions are recorded in [pubspec.lock](pubspec.lock).

```text
flutter pub get
flutter gen-l10n
dart run build_runner build
flutter analyze
flutter test --concurrency 1
flutter run -d <device-id>
```

The checked-in generated database and localization files are reproducible.
Regenerate after changing tables or ARB messages.

On Windows, [tool/dev.ps1](tool/dev.ps1) prefers the project's FVM SDK or private
versioned SDK under `%LOCALAPPDATA%\KepliDev`, then Flutter on PATH. It also discovers the private Java and
Android SDK installations without changing permanent environment variables:

```powershell
.\tool\dev.ps1 pub get
.\tool\dev.ps1 dart run build_runner build
.\tool\dev.ps1 test --concurrency 1
.\tool\dev.ps1 build apk --debug
```

### Native builds

```text
flutter build apk --debug
flutter build ios --simulator --debug
flutter build windows --release
flutter build linux --release
flutter build macos --release
```

- iOS/macOS builds require macOS and Xcode. The iOS target supports both device
  families and iPad multitasking; there is no orientation lock.
- Windows builds require Visual Studio's Desktop development with C++ workload.
- Linux builds require Clang, CMake, Ninja, pkg-config, and GTK development
  libraries.
- Android release builds are deliberately **not signed with the debug key**.
  Configure your own release keystore before distributing a release APK/AAB.
  Apple signing/notarization and Windows Store/MSIX signing are also distributor
  responsibilities. Never commit private signing material.

[CI](.github/workflows/ci.yml) defines analysis/tests, Android and iOS simulator
builds, and all three desktop builds. Adding the workflow does not mean those
remote jobs or physical-device checks have already run.

### Validation boundaries

Local verification with the pinned SDK:

- Static analysis: no issues.
- Complete test run: **190 passed, 1 skipped**. The skip is a filesystem-symlink
  test that needs Windows developer/admin privileges; it remains enabled on
  other hosts.
- Android debug build: produced
  [app-debug.apk](build/app/outputs/flutter-apk/app-debug.apk).
- Native manifest/plist XML checks and formatter checks passed.

The APK is a development build, not a store-signed release. Apple and desktop
binaries have not been built or run on this Windows host; their native
toolchains and the physical-device release checks are still required.

Tests cover persistence/restart, date arithmetic, integrity checks, malformed
archives, interrupted writes, merge/replace, linked contacts/cards, scanning,
CSV/PDF output, native adapters, reminder planning, localization, responsive
layouts, and accessibility semantics.

Flutter 3.47.5 intermittently terminated its test engine on the current Windows
26H2 host with native access violation `0xC0000005`, without a Dart assertion.
Similar SDK behavior is reported in
[flutter/flutter#191069](https://github.com/flutter/flutter/issues/191069).
The project therefore pins the older stable 3.44.7 SDK rather than patching the
engine or suppressing failures. Run the full suite with that pin; **do not count
an incomplete run as passing**. The main CI quality job runs on Ubuntu.
No SDK/engine source is patched by this project.

The current notification plugin also reports a non-fatal legacy Kotlin Gradle
Plugin warning for `flutter_timezone`. Recheck compatibility before upgrading
Flutter or Android build tooling.

Before a public release, complete the physical-device checks in the
[developer handoff](WarrantyVault-Developer-Handoff.md), including all 20 directed
cross-platform restore combinations. Host-side tests with platform labels are
not a substitute for that matrix.

## Data, privacy, and limits

- Purchase/expiry dates are calendar dates. Creation/update/export timestamps
  are UTC instants. January 31 plus one month clamps to February's last day.
- Claimed is explicit; Active/Expired is derived. Coverage includes the expiry
  day.
- Imported files are copied into app-owned storage under generated names.
  Supported originals are JPEG, PNG, GIF, WebP, BMP, and PDF. Mobile camera/photo
  selection requests a bounded, high-quality image; unsupported original file
  formats must be converted before file import.
- Backup files are **unencrypted and unsigned**. SHA-256/CRC checks detect
  damaged bytes; they do not establish who created a backup.
- Merge does not synchronize deletions. The newer complete item wins, including
  its contacts and attachments; tied timestamps keep the current item. Merge
  preserves local preferences and unions categories. Replace restores portable
  preferences; it does not grant notification permissions.
- Defensive limits: 256 MiB per attachment; 2 GiB expanded backup; 2 GiB plus
  16 MiB ZIP input; 16 MiB manifest; 20,000 ZIP entries. Archives are streamed,
  reject unsafe paths/links/duplicates, and do not support ZIP64 or encryption.
  The UI warns about attachments over 10 MiB.
- Scans allow 1-50 pages, up to 64 MiB and 40 megapixels per source image, with
  a 2,400-pixel output edge. PDF reports have a 64 MiB source-image and
  32-megapixel rendered-image budget. Originals remain available in backups.
- CSV is a reporting format, not a backup. Its stable English column headings
  and ISO calendar dates are intentional; textual spreadsheet formula prefixes
  are neutralized.
- Android automatic app backup is disabled. Apple app-owned vault storage is
  marked excluded from OS backups. Explicit exports may be saved to any provider
  the user chooses, including their own cloud provider; Kepli has no cloud API.
- Uninstalling the app or losing the device can erase local data. Export backups
  regularly. Unsaved editor/scan drafts are not durable warranty records.

Noto fonts are bundled for offline multilingual UI and reports under the
licenses in [assets/fonts](assets/fonts). App runtime never downloads fonts.

## Source map

- [lib/domain](lib/domain): immutable records, calendar arithmetic, validation.
- [lib/data](lib/data): typed Drift schema, vault/attachment persistence.
- [lib/services](lib/services): backup, reports, scanner, files, notifications.
- [lib/application](lib/application): state and operation coordination.
- [lib/ui](lib/ui): adaptive, localized user workflows.
- [lib/l10n](lib/l10n): 30 ARB catalogs and generated localization APIs.
- [test](test): domain, storage, service, native-configuration, and widget tests.

See the [product specification](WarrantyVault-Product-Specification.md) and
[technical handoff](WarrantyVault-Developer-Handoff.md). Their historical
filenames are retained for existing links; the app and backup prefix are Kepli.
