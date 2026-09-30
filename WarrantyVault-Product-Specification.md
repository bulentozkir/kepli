# Kepli — Product Specification

**(formerly "Kepli")**

**Tagline:** When does this warranty run out — and where's the receipt?

**Positioning:** *The only warranty tracker that works on your phone AND your PC/Mac/Linux box — no account, no subscription, no cloud. Your data, backed up to one file you control.*

## 0. Competitive differentiation (verified 2026-09-30)

Researched 7+ active competitors on Google Play and Apple App Store (Warranty Keeper App, WarrantyTrackr, WarrantyVault: Receipt Tracker, Warry, Check My Warranty, Warranty Tracker: AI Coverage, CoverKeep, Warranty Tracker: Easy Track, MyWarranty). Verified findings:

- **Every competitor inspected is mobile-only (iOS and/or Android) — zero desktop (Windows/Linux/macOS) builds found for any of them.** This is the real, citable structural gap.
- **Most require a cloud account.** Real user complaints found: broken login/password recovery after reinstall (Warranty Keeper App, 2-star review), and one app (MyWarranty) flagged by a reviewer as scam-adjacent — selling fake warranties, account-gated so users can't independently verify/export their data.
- **One competitor (Warry, Android-only)** already advertises "no account and no server, stored on your phone" — proving local-only/no-account alone is not unique. It has no desktop support and no cross-platform backup/restore.
- **$0.99 one-time pricing already exists in this niche** (Warranty Tracker: Easy Track, iOS) — validated as a used model, not a novel pricing angle.
- Four previously-assumed competitors (WarrantyRoster, Warrantee, TrackMyThings, Proofly) could not be verified as currently active/listed apps during this research — treat as unconfirmed, do not cite them as evidence either way.

**Honest framing:** this is a plausible niche differentiation (cross-platform + local-only + manual zip backup, verified as not offered by any inspected competitor), not a proven blue ocean. Confidence is medium — search tooling was degraded during research (Reddit/review-aggregator sources couldn't be mined), so treat competitor-complaint volume as thin, not exhaustive.

**Store listing implication:** lead with "Works on Windows, Mac, Linux, iPhone and Android — no account needed" as the primary headline differentiator, since this is the one claim directly verified against real, currently-listed competitors.

**Platforms:** Windows, Linux, macOS, iOS, Android — single Flutter/Dart codebase.
**Distribution:** Microsoft Store, Google Play, Apple App Store, plus direct/Flatpak builds for Linux and a notarized build for macOS as feasible.
**Price:** Free.

## 1. Problem & positioning

Users buy electronics, appliances and tools with warranties and lose the receipt or forget the expiry date, missing free repairs/replacements. No dominant free Windows desktop app was found for this; closest competitors (WarrantyRoster, TrackMyThings) are cloud-based or mobile-only, not local-first cross-platform desktop+mobile.

**Not:** an inventory-management system, expense tracker, or accounting tool. It stores warranty/receipt records and reminds the user before expiry.

## 2. Core data model

Each item:
- Name, category tag (electronics/appliances/tools/other — user-editable list).
- Purchase date, price (optional), vendor/store name.
- Warranty length (months/years) → auto-calculated expiry date.
- Attached files: receipt photo/PDF, product photo (local storage only).
- Notes (free text).
- Status: Active / Expired / Claimed (user marks manually if they used the warranty).

## 3. Required MVP features

1. **Manual entry** with the fields above; camera capture or file import for receipts on mobile/desktop.
2. **Local notifications**: configurable thresholds (default 30/7/1 days before expiry). Must work per-platform (each OS's own notification system); app must be running or use platform background scheduling where available — clearly disclose limitations (e.g., iOS background restrictions) rather than promise guaranteed delivery.
3. **Search/filter**: by name, vendor, category, expiring-soon, expired.
4. **List/dashboard**: sorted by soonest expiry by default.
5. **CSV export** and **per-item PDF export** (for insurance claims) — includes attached receipt image inline or as reference.
6. **Backup export**: single file (zip containing a JSON manifest + all attached receipt/photo files). User chooses where to save it (native file picker/share sheet) — no cloud integration, no account, no server.
7. **Restore from backup**: user picks a previously exported backup file on any device/platform; app validates format/version and merges or replaces items (user choice: merge vs. replace-all, with a warning before replace-all).
8. **Cross-platform compatibility of the backup format**: JSON schema + file references must be platform-agnostic (no OS-specific paths, use relative filenames inside the zip). This is the key differentiator over same-platform-only apps — must be tested by exporting on one platform and restoring on each of the other four before release (**RELEASE GATE**).

## 4. Explicit non-requirements

- No cloud account, sync server, or automatic multi-device sync — restore is always a manual, user-initiated action.
- No guarantee of delivery for notifications if the app isn't running/permitted (especially iOS/Android background limits) — disclose this in-app.
- No OCR/auto-extraction of receipt data in MVP (manual entry only) — flag as a possible future enhancement, not MVP.
- No warranty-registration/manufacturer-API integration.

## 5. Backup/restore format (technical)

- Export: `warranty-vault-backup-YYYYMMDD.zip`
  - `manifest.json` — schema version, export timestamp, list of items with all fields, and relative filenames for attachments.
  - `attachments/<item-id>/<filename>` — receipt/photo files.
- Import: validate `manifest.json` schema version; if newer than app supports, warn and refuse rather than silently corrupt data. If older, migrate forward.
- Conflict handling on merge: match by a stable item ID (UUID generated at creation, preserved across exports) — not by name, to avoid accidental duplicate merges.

## 6. Release gates

- Backup file exported on each platform successfully restores full item + attachment data on each of the other four platforms.
- Notification permission flows tested per-platform (especially iOS/Android runtime permission prompts).
- Replace-all restore requires explicit confirmation with a clear warning it's destructive.

## 7. Open questions for implementation spike

- Exact warranty-length input UX (dropdown presets vs. free months/years entry).
- Whether product photo is required or optional per item (recommend optional).
- Maximum attachment size/count per item (recommend a soft cap with a warning, not a hard block).
