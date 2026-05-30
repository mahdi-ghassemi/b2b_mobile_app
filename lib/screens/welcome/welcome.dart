import 'package:b2b_mobile_app/app/app_config.dart';
import 'package:b2b_mobile_app/app/language_controller.dart';
import 'package:b2b_mobile_app/app/theme_controller.dart';
import 'package:b2b_mobile_app/l10n/app_localizations.dart';
import 'package:b2b_mobile_app/screens/sms/sms_code.dart';
import 'package:flutter/material.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  final TextEditingController phoneCtrl = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? _lastBackPress;

  late Country _selectedCountry;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOut,
    );

    _slide = Tween<Offset>(
      begin: const Offset(0, 0.03),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );

    _initSelectedCountry();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  void _initSelectedCountry() {
    final currentLangCode = languageController.locale.languageCode;
    final lang = findLanguageOption(currentLangCode);
    final byLang = findCountryByCode(lang.defaultCountryCode);
    _selectedCountry = byLang ?? kCountries.first;
  }

  @override
  void dispose() {
    phoneCtrl.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    final now = DateTime.now();
    if (_lastBackPress == null ||
        now.difference(_lastBackPress!) > const Duration(seconds: 2)) {
      _lastBackPress = now;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Press back again to exit'),
          duration: Duration(seconds: 2),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final langCode = languageController.locale.languageCode;
    final langOption = findLanguageOption(langCode);

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: SafeArea(
          child: FadeTransition(
            opacity: _fade,
            child: SlideTransition(
              position: _slide,
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? const [
                      Color(0xFF020617), // dark navy
                      Color(0xFF020617),
                    ]
                        : const [
                      Color(0xFFFFF7D1), // soft yellow
                      Color(0xFFFFFFFF), // white
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: Column(
                  children: [
                    // Unified header (language + theme + brief info)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                      child: Row(
                        children: [
                          // Language pill
                          InkWell(
                            borderRadius: BorderRadius.circular(999),
                            onTap: () => _showLanguageSheet(context),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(999),
                                color: theme.colorScheme.surface.withOpacity(0.8),
                                border: Border.all(
                                  color: theme.dividerColor.withOpacity(0.2),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  buildFlagWidget(
                                    emoji: langOption.flagEmoji,
                                    asset: langOption.flagAsset,
                                    width: 24,
                                    height: 18,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    langOption.label,
                                    style: theme.textTheme.labelMedium,
                                  ),
                                  const SizedBox(width: 4),
                                  const Icon(Icons.arrow_drop_down, size: 18),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            t.appName,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              themeController.toggle();
                            },
                            icon: Icon(
                              isDark ? Icons.light_mode : Icons.dark_mode,
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 38,
                            height: 38,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isDark
                                  ? const Color(0xFFFFC93C).withOpacity(0.2)
                                  : const Color(0xFFFFC93C).withOpacity(0.25),
                            ),
                            child: const Icon(
                              Icons.storefront_rounded,
                              size: 22,
                              color: Color(0xFF8A4B00),
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  t.welcomeTaglineTitle, // key جدید
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  t.welcomeTaglineSubtitle, // key جدید
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            const SizedBox(height: 16),
                            Text(
                              t.welcomeTitle,
                              style: theme.textTheme.headlineSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              t.welcomeSubtitle,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.textTheme.bodyMedium?.color
                                    ?.withOpacity(0.8),
                              ),
                            ),
                            const SizedBox(height: 24),

                            // Card for phone input
                            Card(
                              elevation: isDark ? 0 : 4,
                              shadowColor: isDark
                                  ? Colors.black.withOpacity(0.4)
                                  : const Color(0xFFFFC93C).withOpacity(0.3),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.08)
                                      : const Color(0xFFFFC93C).withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              color: isDark
                                  ? const Color(0xFF020617).withOpacity(0.95)
                                  : Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16),
                                child: Form(
                                  key: formKey,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.stretch,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 32,
                                            height: 32,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: isDark
                                                  ? const Color(0xFFFFC93C).withOpacity(0.16)
                                                  : const Color(0xFFFFF1B0),
                                            ),
                                            child: const Icon(
                                              Icons.phone_iphone_rounded,
                                              size: 18,
                                              color: Color(0xFF8A4B00),
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Text(
                                            t.mobileNumber,
                                            style: theme.textTheme.labelLarge?.copyWith(
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 12),
                                      Row(
                                        children: [
                                          GestureDetector(
                                            onTap: () => _showCountryPicker(context),
                                            child: Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                              height: 52,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(14),
                                                border: Border.all(
                                                  color: theme.dividerColor.withOpacity(0.4),
                                                ),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  buildFlagWidget(
                                                    emoji: _selectedCountry.flagEmoji,
                                                    asset: _selectedCountry.flagAsset,
                                                    width: 26,
                                                    height: 18,
                                                  ),
                                                  const SizedBox(width: 8),
                                                  Text(
                                                    _selectedCountry.dialCode,
                                                    style: theme.textTheme.bodyMedium,
                                                  ),
                                                  const SizedBox(width: 4),
                                                  const Icon(Icons.arrow_drop_down),
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: TextFormField(
                                              controller: phoneCtrl,
                                              keyboardType: TextInputType.phone,
                                              decoration: InputDecoration(
                                                hintText: '750 000 0000',
                                                border: OutlineInputBorder(
                                                  borderRadius: BorderRadius.circular(14),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 18),
                                      FilledButton(
                                        onPressed: () {
                                          final fullNumber =
                                              '${_selectedCountry.dialCode}${phoneCtrl.text.trim()}';

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (_) => SmsCodeScreen(phone: fullNumber),
                                            ),
                                          );
                                        },
                                        child: Text(t.sendCode),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),

                            const Spacer(),

                            Align(
                              alignment: Alignment.center,
                              child: Text(
                                languageController.locale.languageCode
                                    .toUpperCase(),
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.hintColor.withOpacity(0.7),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showLanguageSheet(BuildContext context) {
    final currentCode = languageController.locale.languageCode;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return Padding(
          padding:
          const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.4),
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              for (final option in kAppLanguages)
                _buildLanguageItem(
                  option: option,
                  isSelected: option.code == currentCode,
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageItem({
    required AppLanguageOption option,
    required bool isSelected,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          final newLocale = option.locale;
          final prevLang = languageController.locale.languageCode;
          languageController.change(option.code);

          final mappedCountry = findCountryByCode(option.defaultCountryCode);
          if (mappedCountry != null && prevLang != option.code) {
            setState(() {
              _selectedCountry = mappedCountry;
            });
          }

          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: isSelected
                ? theme.colorScheme.primary.withOpacity(0.08)
                : theme.colorScheme.surface,
            border: Border.all(
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.dividerColor.withOpacity(0.3),
            ),
          ),
          child: Row(
            children: [
              buildFlagWidget(
                emoji: option.flagEmoji,
                asset: option.flagAsset,
                width: 26,
                height: 18,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  option.label,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                  ),
                ),
              ),
              if (isSelected)
                Icon(
                  Icons.check,
                  color: theme.colorScheme.primary,
                  size: 20,
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _showCountryPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return CountryPickerSheet(
          initialCountry: _selectedCountry,
          onSelected: (country) {
            setState(() {
              _selectedCountry = country;
            });
          },
        );
      },
    );
  }
}

class CountryPickerSheet extends StatefulWidget {
  final Country initialCountry;
  final ValueChanged<Country> onSelected;

  const CountryPickerSheet({
    super.key,
    required this.initialCountry,
    required this.onSelected,
  });

  @override
  State<CountryPickerSheet> createState() => _CountryPickerSheetState();
}

class _CountryPickerSheetState extends State<CountryPickerSheet> {
  late TextEditingController searchCtrl;
  late List<Country> filtered;

  @override
  void initState() {
    super.initState();
    searchCtrl = TextEditingController();
    filtered = List.of(kCountries);
  }

  @override
  void dispose() {
    searchCtrl.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    final query = value.toLowerCase();
    setState(() {
      filtered = kCountries
          .where((c) =>
      c.name.toLowerCase().contains(query) ||
          c.dialCode.contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final currentCode = widget.initialCountry.code;

    return Padding(
      padding:
      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Padding(
        padding:
        const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              margin: const EdgeInsets.only(bottom: 12),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.4),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
            TextField(
              controller: searchCtrl,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search country or code',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 320,
              child: ListView.builder(
                itemCount: filtered.length,
                itemBuilder: (_, index) {
                  final c = filtered[index];
                  final selected = c.code == currentCode;
                  return ListTile(
                    leading: buildFlagWidget(
                      emoji: c.flagEmoji,
                      asset: c.flagAsset,
                      width: 28,
                      height: 18,
                    ),
                    title: Text(c.name),
                    subtitle: Text(c.dialCode),
                    trailing: selected
                        ? Icon(
                      Icons.check,
                      color: theme.colorScheme.primary,
                      size: 20,
                    )
                        : null,
                    onTap: () {
                      widget.onSelected(c);
                      Navigator.pop(context);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}