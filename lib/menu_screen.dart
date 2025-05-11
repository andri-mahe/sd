import 'package:coba/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'location_screen.dart';
import 'home_tab.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> with TickerProviderStateMixin {
  final box = GetStorage();
  int _selectedIndex = 0;
  late final AnimationController _animationController;

  final List<IconData> iconList = [
    Icons.home,
    Icons.location_on,
    Icons.calendar_today,
    Icons.bookmark,
    Icons.settings,
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  final List<Widget> _pages = [
    HomeTab(),
    LocationScreen(),
    const Center(child: Text("Calendar")),
    const Center(child: Text("Bookmark")),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 300),
        child: KeyedSubtree(
          key: ValueKey<int>(_selectedIndex),
          child: _pages[_selectedIndex],
        ),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
      ),
      bottomNavigationBar: AnimatedBottomNavigationBar.builder(
        itemCount: iconList.length,
        tabBuilder: (int index, bool isActive) {
          final color =
              isActive
                  ? colorScheme.primary
                  : colorScheme.onSurface.withOpacity(0.6);
          final bgColor =
              isActive
                  ? colorScheme.primary.withOpacity(0.15)
                  : Colors.transparent;

          return AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOutBack,
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: bgColor,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(iconList[index], size: isActive ? 30 : 24, color: color),
                const SizedBox(height: 4),
                if (isActive)
                  Container(
                    height: 4,
                    width: 20,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
              ],
            ),
          );
        },
        backgroundColor: colorScheme.surface,
        activeIndex: _selectedIndex,
        gapLocation: GapLocation.none,
        notchSmoothness: NotchSmoothness.softEdge,
        splashColor: colorScheme.primary,
        splashRadius: 30,
        elevation: 10,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
            _animationController.forward(from: 0);
          });
        },
      ),
    );
  }
}
