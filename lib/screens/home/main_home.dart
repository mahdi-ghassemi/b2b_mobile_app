import 'package:b2b_mobile_app/app/app_config.dart';
import 'package:b2b_mobile_app/app/language_controller.dart';
import 'package:b2b_mobile_app/app/theme_controller.dart';
import 'package:b2b_mobile_app/l10n/app_localizations.dart';
import 'package:b2b_mobile_app/screens/welcome/welcome.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTabIndex = 0;

  final List<HomeCategory> _categories = const [
    HomeCategory(
      id: 'agri',
      name: 'Agriculture',
      icon: Icons.grass_rounded,
    ),
    HomeCategory(
      id: 'food',
      name: 'Food & Beverage',
      icon: Icons.restaurant_rounded,
    ),
    HomeCategory(
      id: 'construction',
      name: 'Construction',
      icon: Icons.house_siding_rounded,
    ),
    HomeCategory(
      id: 'machines',
      name: 'Machines',
      icon: Icons.agriculture_rounded,
    ),
    HomeCategory(
      id: 'packaging',
      name: 'Packaging',
      icon: Icons.inventory_2_rounded,
    ),
    HomeCategory(
      id: 'more',
      name: 'More',
      icon: Icons.more_horiz,
    ),
  ];

  String _selectedCategoryId = 'all';

  final List<AdItem> _ads = const [
    AdItem(
      id: '1',
      title: 'Premium dates (Mazafati)',
      city: 'Kermanshah',
      region: 'Iran',
      minOrder: '1 ton',
      priceLabel: '\$980 / ton',
      badge: 'Featured',
      imageUrl: null, // in demo we use placeholder
    ),
    AdItem(
      id: '2',
      title: 'Greenhouse cucumbers',
      city: 'Erbil',
      region: 'Kurdistan Region',
      minOrder: '500 kg',
      priceLabel: 'Price on request',
      badge: 'New',
      imageUrl: null,
    ),
    AdItem(
      id: '3',
      title: 'Industrial packing tape 8000',
      city: 'Sulaymaniyah',
      region: 'Kurdistan Region',
      minOrder: '100 cartons',
      priceLabel: '\$2.4 / piece',
      badge: 'Special offer',
      imageUrl: null,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final langCode = languageController.locale.languageCode;
    final langOption = findLanguageOption(langCode);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // AppBar custom
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
                        color: theme.colorScheme.surface.withOpacity(0.9),
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
                            width: 22,
                            height: 16,
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

            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: isDark
                        ? const [
                      Color(0xFF020617),
                      Color(0xFF020617),
                    ]
                        : const [
                      Color(0xFFFFF7D1),
                      Color(0xFFFFFFFF),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 8,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            _buildSignupBanner(context, theme),
                            const SizedBox(height: 16),
                            _buildSearchBar(theme),
                            const SizedBox(height: 16),
                            _buildCategoryStrip(theme),
                            const SizedBox(height: 16),
                            _buildSectionHeader(theme),
                            const SizedBox(height: 8),
                          ],
                        ),
                      ),
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      sliver: SliverList.builder(
                        itemCount: _ads.length,
                        itemBuilder: (context, index) {
                          final ad = _ads[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: _AdCard(ad: ad),
                          );
                        },
                      ),
                    ),
                    const SliverPadding(padding: EdgeInsets.only(bottom: 16)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomBar(theme),
    );
  }

  Widget _buildSignupBanner(BuildContext context, ThemeData theme) {
    final t = AppLocalizations.of(context)!;
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark
            ? const Color(0xFFFFC93C).withOpacity(0.12)
            : const Color(0xFFFFF1B0),
        border: Border.all(
          color: const Color(0xFFFFC93C).withOpacity(0.7),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Color(0xFFFFC93C),
            ),
            child: const Icon(
              Icons.person_add_alt_1_rounded,
              color: Color(0xFF8A4B00),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Start wholesale trading with free signup',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Browse all listings now. Register your business when you are ready.',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.textTheme.bodySmall?.color?.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.tonal(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const WelcomeScreen(),
                ),
              );
            },
            child: const Text('Free signup'),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar(ThemeData theme) {
    return TextField(
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.search),
        hintText: 'Search products or suppliers',
        filled: true,
        fillColor: theme.colorScheme.surface,
        contentPadding: const EdgeInsets.symmetric(vertical: 0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(999),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildCategoryStrip(ThemeData theme) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length + 1, // +1 for "All"
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _buildCategoryChip(
              theme: theme,
              id: 'all',
              label: 'All',
              icon: Icons.all_inclusive_rounded,
            );
          }
          final cat = _categories[index - 1];
          return _buildCategoryChip(
            theme: theme,
            id: cat.id,
            label: cat.name,
            icon: cat.icon,
          );
        },
      ),
    );
  }

  Widget _buildCategoryChip({
    required ThemeData theme,
    required String id,
    required String label,
    required IconData icon,
  }) {
    final bool isSelected = _selectedCategoryId == id;
    return InkWell(
      borderRadius: BorderRadius.circular(999),
      onTap: () {
        setState(() {
          _selectedCategoryId = id;
        });
        // فیلتر واقعی را بعداً می‌توان اضافه کرد
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(999),
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.12)
              : theme.colorScheme.surface,
          border: Border.all(
            color: isSelected
                ? theme.colorScheme.primary
                : theme.dividerColor.withOpacity(0.3),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 18,
              color: isSelected
                  ? theme.colorScheme.primary
                  : theme.iconTheme.color?.withOpacity(0.8),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme) {
    return Row(
      children: [
        Icon(
          Icons.bolt_rounded,
          size: 18,
          color: theme.colorScheme.primary,
        ),
        const SizedBox(width: 6),
        Text(
          'Latest listings',
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildBottomBar(ThemeData theme) {
    return BottomNavigationBar(
      currentIndex: _currentTabIndex,
      onTap: (index) {
        if (index == 0) {
          setState(() {
            _currentTabIndex = 0;
          });
          return;
        }
        setState(() {
          _currentTabIndex = index;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('This tab is demo only in current version.'),
            duration: Duration(seconds: 2),
          ),
        );
      },
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_rounded),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.grid_view_rounded),
          label: 'Categories',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_box_rounded),
          label: 'Post request',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble_rounded),
          label: 'Messages',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_rounded),
          label: 'Profile',
        ),
      ],
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
          languageController.change(option.code);
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
}

// Models for demo

class HomeCategory {
  final String id;
  final String name;
  final IconData icon;

  const HomeCategory({
    required this.id,
    required this.name,
    required this.icon,
  });
}

class AdItem {
  final String id;
  final String title;
  final String city;
  final String region;
  final String minOrder;
  final String priceLabel;
  final String badge;
  final String? imageUrl;

  const AdItem({
    required this.id,
    required this.title,
    required this.city,
    required this.region,
    required this.minOrder,
    required this.priceLabel,
    required this.badge,
    this.imageUrl,
  });
}

class _AdCard extends StatelessWidget {
  final AdItem ad;

  const _AdCard({required this.ad});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: isDark ? 0 : 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Image + badge
          Stack(
            children: [
              Container(
                height: 140,
                color: isDark
                    ? Colors.grey[900]
                    : const Color(0xFFE5ECF3),
                child: ad.imageUrl == null
                    ? Center(
                  child: Icon(
                    Icons.image_rounded,
                    size: 40,
                    color: theme.iconTheme.color?.withOpacity(0.4),
                  ),
                )
                    : Image.network(
                  ad.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                left: 8,
                child: Container(
                  padding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(999),
                    color: Colors.orange.withOpacity(0.9),
                  ),
                  child: Text(
                    ad.badge,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ad.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    const Icon(Icons.location_on_rounded, size: 16),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        '${ad.city} • ${ad.region}',
                        style: theme.textTheme.bodySmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.inventory_2_rounded, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Min. order: ${ad.minOrder}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Padding(
            padding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                Text(
                  ad.priceLabel,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const Spacer(),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('View details'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}