import 'package:b2b_mobile_app/core/l10n/arb/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ForceUpdateScreen extends StatelessWidget {
  final String currentVersion;
  final int currentBuildNumber;
  final String requiredVersion;
  final int requiredBuildNumber;

  /// Can be null if server didn't send it in extra.
  final String? updateUrl;

  const ForceUpdateScreen({
    super.key,
    required this.currentVersion,
    required this.currentBuildNumber,
    required this.requiredVersion,
    required this.requiredBuildNumber,
    required this.updateUrl,
  });

  Future<void> _openUpdateUrl(BuildContext context) async {
    final url = updateUrl;
    final localizations = AppLocalizations.of(context)!;
    if (url == null || url.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.updateNotAvailable),
        ),
      );
      return;
    }

    final uri = Uri.tryParse(url);
    if (uri == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.updateLinkIsInvalid),
        ),
      );
      return;
    }

    final ok = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (!ok && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(localizations.notOpenUpdateLink),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final current = localizations.current;
    final required = localizations.required;
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.system_update_alt_rounded,
                  size: 96,
                  color: Color(0xFFFFC93C),
                ),
                const SizedBox(height: 24),
                Text(
                  localizations.updateRequired,
                  style: theme.textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 12),
                Text(
                  localizations.updateTitle,
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 24),

                Text('$current: $currentVersion+$currentBuildNumber'),
                const SizedBox(height: 6),
                Text(
                  '$required: $requiredVersion+$requiredBuildNumber',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => _openUpdateUrl(context),
                    child: Text(localizations.updateNow),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
