# Kepli — Developer Handoff

**(formerly "Kepli")**

**Audience:** junior developers implementing this from scratch. Read the product spec first: `WarrantyVault-Product-Specification.md`. This document is the technical contract — architecture, data model, APIs, and acceptance tests.

**Stack:** Flutter/Dart, single codebase, 5 targets: Windows, Linux, macOS, iOS, Android.

**Verified differentiator (do not build this if the cross-platform desktop support is dropped from scope):** every inspected competitor on Google Play/App Store is mobile-only. The Windows/Linux/macOS desktop builds ARE the product's core competitive claim, not a nice-to-have — if desktop scope is ever cut for time, the positioning collapses to "just another local warranty tracker" (Warry already occupies that niche on Android). See spec §0 for full competitive research.

---

## 1. Project setup

```
flutter create --platforms=windows,linux,macos,ios,android kepli
```

Minimum Flutter SDK: stable channel, current LTS (verify `flutter --version` ≥ 3.24 at implementation time — desktop support and plugin compatibility move fast; recheck plugin support matrices before locking versions).

### Recommended package set (verify latest stable versions at implementation time — do not hardcode versions into this doc)

| Concern | Package | Notes |
|---|---|---|
| Local database | `sqflite` (mobile/desktop via `sqflite_common_ffi`) or `drift` | `drift` recommended: type-safe queries, works across all 5 platforms via `drift_sqlite3` |
| File picking | `file_picker` | Cross-platform file/folder picker for backup export/import and receipt import |
| Camera capture | `image_picker` | Mobile camera + desktop file fallback |
| Native share sheet | `share_plus` | For sending exported files (mobile); desktop falls back to "reveal in file manager" |
| Local notifications | `flutter_local_notifications` | Supports Windows, Linux, macOS, iOS, Android — verify each platform's setup steps individually, they differ significantly |
| Zip handling | `archive` | Pure-Dart zip read/write, no native dependency — critical for cross-platform consistency |
| UUID generation | `uuid` | v4 UUIDs for item IDs |
| Path/filesystem | `path_provider` | Platform-appropriate app-data directories |
| State management | `provider` or `riverpod` | Either acceptable; pick one and use consistently |

---

## 2. Data model (Dart classes)

```dart
class WarrantyItem {
  final String id; // UUID v4, generated once at creation, immutable
  String name;
  String category; // free-form but constrained to user-managed tag list
  DateTime purchaseDate;
  double? price; // nullable — optional field
  String? vendor;
  int warrantyLengthMonths; // store as months internally; UI may offer years as a multiplier
  DateTime get expiryDate => DateTime(
    purchaseDate.year,
    purchaseDate.month + warrantyLengthMonths,
    purchaseDate.day,
  );
  List<String> attachmentFilenames; // relative filenames only, e.g. "receipt1.jpg"
  String? notes;
  ItemStatus status; // active, expired, claimed
  DateTime createdAt;
  DateTime updatedAt;
}

enum ItemStatus { active, expired, claimed }
```

**Do not** store `expiryDate` as a persisted field — always derive it from `purchaseDate + warrantyLengthMonths` to avoid drift between stored and computed values. Status `expired` should be computed at query/display time by comparing `expiryDate` to `DateTime.now()`, except `claimed` which is an explicit user action that overrides the computed expired/active state.

---

## 3. Local database schema (drift/SQLite)

```sql
CREATE TABLE items (
  id TEXT PRIMARY KEY,
  name TEXT NOT NULL,
  category TEXT NOT NULL,
  purchase_date TEXT NOT NULL,       -- ISO-8601, UTC
  price REAL,
  vendor TEXT,
  warranty_length_months INTEGER NOT NULL,
  notes TEXT,
  status TEXT NOT NULL DEFAULT 'active',  -- active | expired | claimed
  created_at TEXT NOT NULL,
  updated_at TEXT NOT NULL
);

CREATE TABLE attachments (
  id TEXT PRIMARY KEY,               -- UUID
  item_id TEXT NOT NULL REFERENCES items(id) ON DELETE CASCADE,
  filename TEXT NOT NULL,            -- relative filename, stored under app-data/attachments/<item_id>/
  original_name TEXT,                -- filename as picked by user, for display only
  added_at TEXT NOT NULL
);

CREATE TABLE app_meta (
  key TEXT PRIMARY KEY,
  value TEXT
);
-- app_meta seeds: schema_version, install_id (random UUID, for debugging only, never transmitted)
```

**All dates stored as ISO-8601 strings in UTC.** Convert to local time only at display. This avoids timezone bugs when a backup is restored on a device in a different timezone.

---

## 4. File storage layout

```
<app-support-dir>/
  kepli.db
  attachments/
    <item-id>/
      <uuid>.jpg
      <uuid>.pdf
```

Use `path_provider`'s `getApplicationSupportDirectory()` for the database and attachment originals — **not** the same directory used for the export/import zip staging (use a temp directory via `path_provider`'s `getTemporaryDirectory()` for building zips before the user picks a save location).

---

## 5. Backup export — exact format

**Filename convention:** `kepli-backup-YYYYMMDD-HHMMSS.zip` (local time in the filename for user readability; UTC inside the manifest).

**Zip structure:**
```
kepli-backup-20261001-143000.zip
├── manifest.json
└── attachments/
    ├── <item-id-1>/
    │   ├── <uuid>.jpg
    │   └── <uuid>.pdf
    └── <item-id-2>/
        └── <uuid>.jpg
```

**`manifest.json` schema (version 1):**

```json
{
  "schema_version": 1,
  "exported_at": "2026-10-01T14:30:00Z",
  "exported_by_platform": "windows",
  "items": [
    {
      "id": "3f2a1b4c-...",
      "name": "Dyson V11 Vacuum",
      "category": "appliances",
      "purchase_date": "2025-11-15",
      "price": 449.99,
      "vendor": "Best Buy",
      "warranty_length_months": 24,
      "notes": "Extended warranty via card benefit",
      "status": "active",
      "created_at": "2025-11-16T09:00:00Z",
      "updated_at": "2025-11-16T09:00:00Z",
      "attachments": [
        {
          "id": "a1b2c3d4-...",
          "filename": "attachments/3f2a1b4c-.../f9e8d7c6.jpg",
          "original_name": "receipt_photo.jpg",
          "added_at": "2025-11-16T09:00:00Z"
        }
      ]
    }
  ]
}
```

**Rules:**
- `filename` inside each attachment entry is the **zip-relative path**, always forward-slash separated, regardless of host OS.
- Never include absolute paths, drive letters, or OS-specific separators anywhere in `manifest.json`.
- `schema_version` is an integer, incremented only on breaking format changes. Additive optional fields do not require a version bump; document any bump in a `CHANGELOG.md` in the repo.

---

## 6. Restore logic

1. User picks a `.zip` file via `file_picker`.
2. Validate: file is a valid zip, contains `manifest.json`, `manifest.json` parses as JSON, `schema_version` is a known/supported value (reject with a clear error if newer than the app supports — **never attempt to guess-parse an unknown future schema**).
3. Present the user two choices before importing anything:
   - **Merge:** items are matched by `id` (UUID). Existing item with the same ID → prompt per-item or bulk "keep newest by `updated_at`" (recommend bulk default: newest `updated_at` wins, with an option to review conflicts). New IDs → added.
   - **Replace all:** delete all existing items/attachments first, then import everything from the backup. Require an explicit confirmation dialog with red/destructive styling: *"This will permanently delete all N existing items on this device. This cannot be undone."*
4. Extract attachments into `<app-support-dir>/attachments/<item-id>/` under **newly generated local filenames** if a collision would occur — but preserve the manifest's logical structure (an item's attachment list still refers to correct files after extraction; rewrite internal references, don't rely on the zip's exact filenames persisting after extraction).
5. Run a post-import integrity check: every attachment referenced in an item's attachment list must exist on disk; log/report any missing files rather than silently dropping them.

---

## 7. Notifications

Use `flutter_local_notifications`. Per-platform setup differs significantly — treat each as a separate implementation task, not one shared code path beyond the plugin's common API surface:

- **Android:** requires `POST_NOTIFICATIONS` runtime permission (Android 13+/API 33+); schedule via `zonedSchedule` with `AndroidScheduleMode.exactAllowWhileIdle` for reliability, but disclose that OEM battery-optimization settings can still suppress it.
- **iOS:** requires explicit permission request (`requestPermissions`); background app refresh restrictions mean scheduled local notifications are the reliable mechanism (not silent background fetches) — use `UNCalendarNotificationTrigger` equivalent via the plugin.
- **Windows:** requires a valid AUMID/app registration for the notification to display correctly; test on a clean Windows profile, not just the dev machine (already-registered COM/AUMID state can mask setup bugs).
- **Linux:** relies on the desktop's notification daemon (varies by DE); if no notification server available, the app must fail silently and rely on the in-app expiring-soon list — do not crash.
- **macOS:** requires notification permission via the system prompt; sandboxed apps must have the correct entitlements for local notifications.

**Scheduling rule:** on every app launch and on every item create/edit, recompute and reschedule notifications for that item's configured thresholds (default 30/7/1 days before `expiryDate`). Cancel and reschedule rather than accumulate duplicate pending notifications — key the notification ID deterministically from `item.id` + threshold (e.g., hash to a stable int).

---

## 8. Export/share integration

- **Mobile (iOS/Android):** after building the zip in a temp directory, invoke `share_plus`'s share sheet so the user can send it via any installed app or save to a file provider (Files/Google Drive/Dropbox as configured on their device) — the app does not integrate with any cloud API directly.
- **Desktop (Windows/Linux/macOS):** use `file_picker`'s save-dialog to let the user choose a destination folder directly; a share-sheet equivalent isn't standard on desktop, so default to "Save As" with a sensible default filename and open the containing folder afterward (`url_launcher` or platform-specific "reveal in explorer/finder" call) as a convenience, not a requirement.

---

## 9. CSV / PDF export (separate from backup)

- **CSV:** flat table, one row per item — name, category, purchase date, price, vendor, warranty length, expiry date, status, notes. Use the `csv` package; escape commas/quotes correctly (standard RFC 4180). This is a **reporting export**, not a backup — it must not be treated as restorable.
- **Per-item PDF:** use `pdf` + `printing` packages; include item details plus embedded receipt image if the attachment is an image; if the attachment is itself a PDF, either embed a reference/link text (page count and filename) or merge if using a PDF library capable of merging (evaluate `pdf` package capability at implementation time — do not overcommit to true PDF merging without a spike).

---

## 10. Acceptance tests (must pass before release)

1. **Cross-platform restore matrix:** export a backup with ≥3 items (mixed image/PDF attachments) on Windows; restore successfully on Linux, macOS, iOS, Android. Repeat exporting from each of the other 4 platforms — full 5×4 matrix, or at minimum export-once-from-each/restore-on-all-others (5 exports × 4 restores = 20 combinations minimum; document actual matrix run in the release checklist).
2. **Merge conflict:** import a backup containing an item with the same `id` as an existing item but a newer `updated_at` — verify the newer version wins under default merge behavior.
3. **Replace-all:** verify confirmation dialog blocks accidental data loss; verify all prior items/attachments are actually gone after confirming.
4. **Unknown schema version:** hand-craft a `manifest.json` with `schema_version: 999`; verify the app refuses cleanly with a readable error, does not crash, does not partially import.
5. **Missing attachment file:** hand-craft a backup where `manifest.json` references a file not present in the zip; verify the app reports it instead of crashing.
6. **Notification scheduling:** create an item with a purchase date such that the 7-day threshold fires within test-observable time (or use a debug-only "trigger in 1 minute" override) on each of the 5 platforms; confirm the notification appears.
7. **CSV export round-trip readability:** open the exported CSV in Excel/LibreOffice/Google Sheets and confirm no column misalignment from unescaped commas/quotes in names or notes.
8. **Timezone correctness:** create an item on a device set to UTC+12, export, restore on a device set to UTC-8; confirm `expiryDate` computation (derived from stored UTC `purchase_date`) is identical on both, not shifted by a day.

---

## 11. Explicit non-goals (do not build these without a scope change)

- No OCR/auto-extraction of receipt data.
- No cloud account, login, or server-side sync of any kind.
- No automatic/background sync between devices — restore is always a manual, user-initiated file import.
- No manufacturer warranty-registration API integrations.
- No guaranteed notification delivery — document platform limitations in-app (Settings → About/Help) rather than promising reliability the OS itself doesn't guarantee.

---

## 12. Release checklist

- [ ] Cross-platform backup/restore matrix executed and documented (§10.1).
- [ ] Notification permission flow tested on a clean install on each platform.
- [ ] Replace-all destructive-action confirmation verified.
- [ ] CSV and PDF export manually opened and visually checked on at least one real device per platform family (desktop + mobile).
- [ ] App does not crash when notification server/daemon is unavailable (Linux edge case).
- [ ] Store listings (Microsoft Store, Google Play, Apple App Store) clearly state: local-only storage, manual backup/restore, no cloud sync — to set correct user expectations and avoid review rejection for unsubstantiated "sync" claims.
