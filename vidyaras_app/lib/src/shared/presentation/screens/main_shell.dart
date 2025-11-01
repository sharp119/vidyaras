import 'package:flutter/material.dart';
import '../../../features/home/1_presentation/screens/home_screen_v2.dart';
import '../../../features/my_courses/1_presentation/screens/learn_screen.dart';
import '../../../features/tests/1_presentation/screens/test_series_screen.dart';
import '../components/navigation/bottom_nav_bar.dart';
import 'profile_screen.dart';
import 'more_screen.dart';

/// Main app shell with bottom navigation
/// Manages tab navigation between Home, Learn, Tests, Profile, More
class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;
  late PageController _pageController;

  late final List<Widget> _screens = [
    const HomeScreenV2(),
    const LearnScreen(),
    const TestSeriesScreen(),
    const ProfileScreen(),
    const MoreScreen(),
  ];

  final List<BottomNavItem> _navItems = const [
    BottomNavItem(icon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.school, label: 'Learn'),
    BottomNavItem(icon: Icons.assignment, label: 'Tests'),
    BottomNavItem(icon: Icons.person, label: 'Profile'),
    BottomNavItem(icon: Icons.grid_view, label: 'More'),
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
    _pageController.jumpToPage(index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics: const NeverScrollableScrollPhysics(),
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: _navItems,
      ),
    );
  }
}
