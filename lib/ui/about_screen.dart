import 'dart:io';

import 'package:flutter/material.dart';

import 'ui_support.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return PageBody(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeading(l10n.appTitle),
          Text(l10n.tagline),
          const SizedBox(height: 16),
          LabeledValue(label: l10n.appVersion, value: '1.0.0'),
          SectionHeading(l10n.privacyTitle),
          Text(l10n.privacyBody),
          SectionHeading(l10n.backups),
          Text(l10n.backupExplanation),
          const SizedBox(height: 12),
          Text(l10n.backupPrivacy),
          SectionHeading(l10n.notifications),
          Text(l10n.notificationPrivacy),
          const SizedBox(height: 12),
          Text(l10n.reminderLimit),
          if (Platform.isLinux) ...[
            const SizedBox(height: 12),
            Text(l10n.linuxReminderHelp),
          ],
          SectionHeading(l10n.scanDocument),
          Text(l10n.scanHelp),
          const SizedBox(height: 12),
          Text(l10n.desktopScanHelp),
          SectionHeading(l10n.accessibility),
          Text(l10n.accessibilityHelp),
        ],
      ),
    );
  }
}
