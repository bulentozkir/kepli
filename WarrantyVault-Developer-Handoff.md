# Kepli - Developer Handoff

Read the [product specification](WarrantyVault-Product-Specification.md) first.
This document describes the implemented contract rather than the earlier
prototype snippets. Historical filenames are retained for existing links.

## 1. Targets and toolchain

One Flutter/Dart codebase targets Android phones/tablets, iPhone/iPad, Windows,
Linux, and macOS. Mobile camera/photo workflows are first-class. Desktop may
omit unsupported capture or background-notification features, but must retain
the core local data and cross-platform backup functionality.

Pinned development baseline: Flutter 3.44.7 / Dart 3.12.2, Java 17,
Android SDK 36. Use [pubspec.lock](pubspec.lock), not independently guessed
package versions. See [README.md](README.md) for setup and native prerequisites.

```text
flutter pub get
flutter gen-l10n
dart run build_runner build
flutter analyze
flutter test --concurrency 1
```

On Windows, [tool/dev.ps1](tool/dev.ps1) discovers the normal Flutter installation
or the private Kepli development SDK, with process-local Java/Android settings.
It also supports `.\tool\dev.ps1 dart run build_runner build`.

Flutter 3.47.5 exhibited intermittent native test-runner access violations on
the current Windows host. The project pins stable 3.44.7 in `.fvmrc` and CI.
Preserve the distinction between native runner crashes and Dart test failures;
never mark an incomplete suite as passing. See the README's validation notes.

## 2. Architecture

| Area | Responsibility |
|---|---|
| [lib/domain](lib/domain) | Immutable models, strict validation, calendar arithmetic, localized numeric input |
| [lib/data](lib/data) | Typed Drift/SQLite storage, immutable owned files, integrity checks, serialized operations |
| [lib/application](lib/application) | Riverpod state, mutations, refresh, exports, restore and reminder coordination |
| [lib/services](lib/services) | ZIP validation/streaming, reports, scans, native file APIs and reminders |
| [lib/ui](lib/ui) | Adaptive and accessible forms, lists, contacts/cards, scan editor, settings and backup review |
| [lib/l10n](lib/l10n) | Thirty complete ARB catalogs, generated localization API and shared labels |

`initializeKepli` opens the vault, protects local storage, initializes reminder
capabilities without prompting, and recovers interrupted Android photo imports.
Startup failures display a retryable error; they never reset the database.

Drift code is generated only for
[kepli_database.dart](lib/data/kepli_database.dart). Regenerate after schema
changes. Localization code is generated from ARB files using
[l10n.yaml](l10n.yaml).

## 3. Data contract

### Warranty

- UUID generated at creation and retained across exports/restores.
- Name, managed category, purchase calendar date, integer warranty months.
- Optional price as exact decimal text, three-letter currency, vendor, notes.
- Explicit `claimed` boolean; Active/Expired is derived.
- Immutable creation/update UTC timestamps.
- Lists of contacts and attachments.

Purchase dates use `YYYY-MM-DD`, without timezone conversion. Add months by
clamping the day to the target month's last day. An unclaimed warranty is active
on its expiry day and expired on the next calendar day. Do not persist expiry.

Prices are optional nonnegative decimal strings with up to two fractional
digits; there are no currency conversions or accounting calculations.

### Contacts and attachments

Contacts have UUID, `sales` or `service` role, name, and optional organization,
phone, email and notes. Multiple contacts are supported.

Attachment roles are `receipt`, `warranty`, `product`, and `businessCard`.
Every attachment has UUID, owned relative path, original display name, MIME
type, size, SHA-256, and UTC addition timestamp. Business cards require a
`contact_id` referring to a contact on the same warranty. Removing a contact
must also remove its cards, not leave orphan references.

Imported originals are JPEG, PNG, GIF, WebP, BMP, or PDF. Camera/photo-library
selection requests a bounded high-quality image. Other original file formats
must be converted before file import. Original filenames are display metadata,
never extraction destinations.

### SQLite

- `items`: typed warranty fields and validated `contacts_json`.
- `attachments`: foreign key to item with cascade deletion, position/order,
  content metadata and optional contact ID.
- `app_meta`: portable settings, database schema version, local installation ID.

Database schema version and backup schema version are independent. Version 1
is the initial schema; there is no previously released database migration.
Future schema upgrades must implement and test a real migration, not reset
existing data.

One repository owns a vault at a time. Operations are serialized in-process,
and an OS file lock protects against a second app instance collecting files
while a write is in flight.

## 4. Files and write safety

```text
application-support/
  vault/
    kepli.db
    .kepli.lock
    attachments/
      <item-uuid>/
        <generated-file-uuid>.jpg
        <generated-file-uuid>.pdf
```

Use `getApplicationSupportDirectory` for durable data and
`getTemporaryDirectory` for import/scan/export staging.

Mutation sequence:

1. Validate metadata and references.
2. Copy incoming bytes under fresh generated filenames and verify them.
3. Commit item/settings/attachment metadata in one SQLite transaction.
4. Delete unreferenced files only after the commit.

A crash before commit leaves old records and bytes intact; unused copies are
collected when opening the vault. A crash after commit leaves valid new
references, with cleanup retried later. Never overwrite active bytes in place.

`VaultCleanupException` means metadata was committed but obsolete-file cleanup
failed. The controller reloads committed data and displays the warning rather
than presenting a false failed-save state.

Source files selected by the user are not deleted or edited. Missing local
attachments are reported by export/use checks; readable item metadata remains
available so a backup can repair the vault.

## 5. Portable ZIP schema v1

Filename: `kepli-backup-YYYYMMDD-HHMMSS.zip`, with local time only in the filename.

```text
manifest.json
attachments/<item-uuid>/<file-uuid>.<extension>
```

Manifest top-level fields:

- `schema_version`: integer `1`.
- `exported_at`: UTC ISO-8601 timestamp.
- `exported_by_platform`: informational platform string.
- `settings`: categories, reminder thresholds/hour/enabled state, currency,
  language, contrast and motion preferences.
- `items`: complete warranty records, nested contacts and attachments.

Item fields are `id`, `name`, `category`, `purchase_date`,
`warranty_length_months`, `price`, `currency`, `vendor`, `notes`, `status`,
`created_at`, `updated_at`, `contacts`, `attachments`.

An exported `status` is `active` for any unclaimed record or `claimed`.
Import also accepts `expired`, but expiry is always recalculated from the
calendar date. Contact fields are `id`, `role`, `name`, `organization`, `phone`,
`email`, `notes`.

Attachment fields are `id`, `filename`, `original_name`, `mime_type`, `role`,
`size`, `sha256`, `added_at`, `contact_id`. `filename` is a ZIP-relative,
forward-slash path. Do not export absolute paths or native path separators.
Local filenames may change on restore; logical attachment/contact IDs do not.

The initial optional-field defaults include empty contacts, English language,
and disabled contrast/motion overrides. Unknown optional fields may be ignored;
unknown schema versions, role values, or invalid required data are not guessed.
Document and test breaking format changes before releasing them.

### Preflight and bounds

Inspect central and local ZIP headers before decompression. Reject duplicate
names (including case-folded collisions), traversal/absolute paths, symlinks,
special files, unsupported encryption/compression, hidden/overlapping entries,
CRC mismatch, missing/unreferenced files, invalid IDs, and incorrect size/hash.
Bound actual decompression output, not just advertised sizes.

Current defensive limits:

- 256 MiB per attachment.
- 2 GiB total expanded archive; compressed input up to that plus 16 MiB.
- 16 MiB manifest; 20,000 entries; 8 MiB central directory.
- Store/deflate only; no ZIP64, encryption, or multi-volume archives.

Export holds a consistent repository snapshot while streaming file bytes.
Import validates and stages all required data before exposing a usable preview.
Backups are unencrypted and unsigned; integrity is not authenticity.

### Restore policy

- Merge by stable UUID, never by item name.
- The newer UTC `updated_at` wins as a complete item, including contacts/files.
- Equal timestamps keep the local item. Conflict review can retain local data.
- Merge does not synchronize deletion and keeps local preferences, combining
  categories case-insensitively.
- Replace restores all records and portable preferences, after explicit
  destructive confirmation showing the current record count.
- Notification permissions and OS queue IDs are never restored from a file.
- Re-read current local data when applying merge, rather than trusting a stale
  preview. Recheck staged attachment integrity before committing.

## 6. Capture, scanning and reports

Mobile uses `image_picker` camera/photo selection. Android persists the pending
attachment role/contact before leaving for the picker and uses
`retrieveLostData` at startup. The UI reconnects recovered cards to an existing
contact or requests contact details before saving.

Desktop uses image/PDF file import; it does not pretend the mobile camera API
works on desktop.

Document scanning is local image processing, not OCR or automatic edge
detection. Users add pages, rotate, adjust crop edges using labeled controls,
and optionally enhance contrast. Processing runs in a Dart isolate, with
orientation normalization and white transparency flattening. The resulting
PDF is an ordinary attachment with its selected role/contact.

Scan limits: 1-50 pages, 64 MiB/40 megapixels per image, 2,400-pixel output edge.
Unsaved editor/scan drafts are not durable records.

CSV is a report, not restorable data. Stable English headers, ISO dates, exact
decimal price strings, contact columns, RFC-style escaping and formula-prefix
neutralization are intentional.

Per-item PDF uses the current locked snapshot, localized labels, bundled
offline fonts, contact information and receipt/card images. Existing PDF files
are listed by filename; users share originals separately. The image budget is
64 MiB input and 32 megapixels rendered. Damaged/unsupported images cause a
visible error, never a silently incomplete successful report.

## 7. Native files and reminders

Android exports through `ACTION_CREATE_DOCUMENT`; Kotlin streams the generated
cache file to the user-chosen document URI without passing whole backups across
the method channel. No broad storage permission is needed. iPhone/iPad uses
`share_plus`, always with a valid popover origin. Desktop uses `file_selector`
Save As plus staged filesystem copy/rename; it does not load a large ZIP into
one byte buffer. Export never overwrites Kepli's internal vault files.

Android automatic cloud/device backup is disabled by native configuration.
Apple vault storage is excluded through a verified native resource flag.
Explicit system-picker/share destinations remain the user's choice.

Reminders:

- Default off; enabling/requesting permission is a user action.
- Defaults 30/7/1 days, 09:00 local time.
- Calendar-date planning with the bundled IANA database; no guessed UTC fallback
  for an unknown device timezone.
- Stable collision-safe integer IDs; cancel old pending requests before adding
  a new bounded queue. Claimed/expired records are excluded.
- Android uses inexact idle-safe scheduling, not exact-alarm permissions.
- iOS/macOS uses native scheduled notifications; at most 60 nearest requests.
- Windows requires an installed MSIX identity. Unpackaged builds explicitly
  report reminders unavailable.
- Linux uses an in-process timer and notification daemon; no closed-app promise.
- Native taps navigate to the warranty; cold-start taps wait for UI readiness.
- Permission, scheduling and daemon errors are logged and displayed. Native
  reminders intentionally survive normal application exit.

## 8. Accessibility and localization

All UI messages use generated localization resources. English is the initial
preference, not an implicit device-language choice. Native-script names are
available in Settings; right-to-left direction and localized date formatting
come from Flutter delegates. Saved user text is never automatically translated.

Keep numeric input normalization shared with domain tests. Preserve native
digits and accept decimal dot/comma/Arabic separators; do not apply ASCII-only
input filters to localized numeric fields.

Use directional padding/alignment, wrapping/scrollable layouts, labeled
actions and non-color status cues. Do not clamp system text scaling to fit.
Keep every operation available without gestures. Respect system and explicit
contrast/motion preferences, maintain visible focus and restore it after
dialogs. Accessible name/target and color-contrast tests are not a substitute
for real TalkBack/VoiceOver/Narrator checks.

Changing an ARB key requires updating all 30 catalogs, including placeholder
types/plurals, then running generation and parity tests. Native-speaker review
and report font-shaping review are release requirements.

## 9. Release checklist

- [ ] Run full analysis/test suite on a supported host; do not count native
      runner crashes or skipped checks as successful coverage.
- [ ] Compile all five native targets in CI and inspect distributable bundles.
- [ ] Test Android phone/tablet and iPhone/iPad camera, photos, file import,
      permission denial, interrupted picker recovery and linked business cards.
- [ ] Test Android save/cancel, iPad share anchoring and desktop Save As,
      including large files and unavailable destinations.
- [ ] Exercise every directed 5 x 4 backup/restore combination on actual OSes,
      with mixed image/PDF files, contacts/cards and exact byte comparisons.
- [ ] Verify merge/ties, repeat import, destructive confirmation, unknown schema,
      missing/corrupt files, disk-full/permission errors and interrupted writes.
- [ ] Verify UTC+12 to UTC-8 calendar portability, month-end/leap-year dates,
      local timezone changes, reminder queues, reboot and permission flows.
- [ ] Check Linux daemon absence and Windows packaged/unpackaged capabilities.
- [ ] Open CSV/PDF reports in real desktop/mobile applications, including
      Unicode, RTL, long notes, contact data and original PDF references.
- [ ] Test keyboard-only navigation, screen readers, 200-300% text,
      contrast/motion settings, landscape, split view and tablet multitasking.
- [ ] Review all translations and complex-script report rendering.
- [ ] Configure store signing, Apple notarization, production icons/metadata
      and accurate privacy/capability disclosures.

No account/server, automatic sync, remote OCR, manufacturer APIs or guaranteed
notification delivery may be implied by the implementation or store listing.
