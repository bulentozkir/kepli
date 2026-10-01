# Kepli — Product Specification

**Implementation scope:** Android phones/tablets, iPhone/iPad, Windows, Linux,
and macOS. Mobile gets camera/photo workflows; desktop uses file import where
camera or scanner hardware integration is not available.

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

Users buy electronics, appliances and tools with warranties and lose the receipt or forget the expiry date, missing free repairs/replacements. The verified opportunity is the combination of local-only storage and phone/tablet/desktop portability. Do not use the unverified competitor names listed in section 0 as evidence.

**Not:** an inventory-management system, expense tracker, or accounting tool. It stores warranty/receipt records and reminds the user before expiry.

## 2. Core data model

Each item:
- Name, category tag (electronics/appliances/tools/other — user-editable list).
- Purchase calendar date, exact-decimal price (optional), currency, vendor/store name.
- Warranty length (months/years) → auto-calculated expiry date.
- Attached files: receipt photo/PDF, warranty papers, optional product photos,
  and business cards (local storage only).
- Multiple sales/service contacts: person, organization, phone, email, notes.
  Business-card attachments belong to an explicit contact on the same item.
- Notes (free text).
- Status: Active / Expired / Claimed (user marks manually if they used the warranty).

Purchase and expiry dates are calendar dates, not UTC timestamps. Adding months
clamps to the target month's last day. Coverage includes the expiry day.
Persist claimed state; derive Active/Expired. Creation/update/export timestamps
are UTC instants.

## 3. Required MVP features

1. **Manual entry** with the fields above; camera capture or file import for receipts on mobile/desktop.
2. **Local notifications**: configurable thresholds (default 30/7/1 days before expiry). Must work per-platform (each OS's own notification system); app must be running or use platform background scheduling where available — clearly disclose limitations (e.g., iOS background restrictions) rather than promise guaranteed delivery.
3. **Search/filter**: by name, vendor, category, expiring-soon, expired.
4. **List/dashboard**: sorted by soonest expiry by default.
5. **CSV export** and **per-item PDF export** (for insurance claims) — includes attached receipt image inline or as reference.
6. **Backup export**: single file (zip containing a JSON manifest + all attached receipt/photo files). User chooses where to save it (native file picker/share sheet) — no cloud integration, no account, no server.
7. **Restore from backup**: user picks a previously exported backup file on any device/platform; app validates format/version and merges or replaces items (user choice: merge vs. replace-all, with a warning before replace-all).
8. **Cross-platform compatibility of the backup format**: JSON schema + file references must be platform-agnostic (no OS-specific paths, use relative filenames inside the zip). This is the key differentiator over same-platform-only apps — must be tested by exporting on one platform and restoring on each of the other four before release (**RELEASE GATE**).
9. **Offline document/business-card scanning:** mobile capture or image import,
   multiple pages, manual crop/rotation/contrast adjustment, and local PDF
   creation. Contact details are entered manually; scanning does not imply OCR.
10. **Accessibility:** screen-reader labels, keyboard access, minimum 48 logical
    pixel action targets, non-color status cues, scalable text and reflow,
    system dark/high-contrast/reduced-motion support, plus in-app contrast and
    reduced-motion preferences.
11. **30 interface languages:** Settings selection, English default, persistent
    preference, RTL where appropriate, bundled fonts, and localized dates,
    reminders and PDF labels. The exact supported set is in [README.md](README.md);
    it is a practical language set, not an immutable speaker-ranking claim.

## 4. Explicit non-requirements

- No cloud account, sync server, or automatic multi-device sync — restore is always a manual, user-initiated action.
- No guarantee of delivery for notifications if the app isn't running/permitted (especially iOS/Android background limits) — disclose this in-app.
- No OCR/auto-extraction of receipt or business-card data in MVP. Capture,
  crop, enhancement and PDF creation are included; extraction is not.
- No warranty-registration/manufacturer-API integration.
- No desktop webcam, TWAIN/WIA scanner integration, or Linux background daemon.
- No automatic translation of user-entered warranty/contact text.

## 5. Backup/restore format (technical)

- Export: `kepli-backup-YYYYMMDD-HHMMSS.zip`
  - `manifest.json` — schema version, UTC export timestamp, exporting platform,
    portable settings/categories, items/contacts, and relative attachment
    filenames, sizes, MIME types and SHA-256 digests.
  - `attachments/<item-id>/<filename>` — receipt/photo files.
- Import: validate `manifest.json` schema version; if newer than app supports, warn and refuse rather than silently corrupt data. If older, migrate forward.
- Conflict handling on merge: match by a stable item ID (UUID generated at creation, preserved across exports) — not by name, to avoid accidental duplicate merges.
- Newer `updated_at` wins for the complete item; ties preserve the local item.
  Conflict review can preserve a local version. Merge does not propagate
  deletions and keeps local preferences while combining categories.
- Validate and stage the complete archive **before** a replace operation.
  Stage immutable attachment copies, commit metadata in one transaction, then
  remove obsolete files. A failed validation/copy must not erase existing data.
- Backups are unencrypted and unsigned. Integrity checks are not authentication.
- The technical handoff defines defensive archive and image-processing limits.

## 6. Release gates

- Backup file exported on each platform successfully restores full item + attachment data on each of the other four platforms.
- Notification permission flows tested per-platform (especially iOS/Android runtime permission prompts).
- Replace-all restore requires explicit confirmation with a clear warning it's destructive.
- Physical phone/tablet camera, permission, save/share and business-card
  association checks; clean-install native build checks for desktop.
- TalkBack/VoiceOver, keyboard-only navigation, large text, high contrast,
  reduced motion, orientation changes and iPad multitasking checks.
- Translation/native-script review, including RTL and report font shaping.
- Host-side unit tests that vary an export's platform label do not satisfy the
  physical 20-combination restore gate.

## 7. Implemented defaults and platform limits

- Duration presets plus custom integer months/years; product photos optional.
- Warn above 10 MiB per attachment. Separate documented safety limits protect
  archive parsing and image processing; they are not claims of unlimited storage.
- Defaults: reminders off until enabled, 30/7/1 days, 09:00 local time, English UI.
- At most 60 nearest reminders are queued. Linux delivery is app-open-only.
  Windows native reminders require an installed MSIX identity.
- Android exports use the system document picker; iPhone/iPad use the share
  sheet; desktop uses native Save As.
- Desktop capability omissions must not remove core records, contacts,
  attachment import, reporting, or portable backup/restore.
