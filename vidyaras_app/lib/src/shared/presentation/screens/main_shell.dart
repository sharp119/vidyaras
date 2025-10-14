import 'package:flutter/material.dart';
import '../../../features/home/1_presentation/screens/home_screen_v2.dart';
import '../components/navigation/bottom_nav_bar.dart';
import 'courses_screen.dart';
import 'community_screen.dart';
import 'tests_screen.dart';
import 'profile_screen.dart';

/// Main app shell with bottom navigation
/// Manages tab navigation between Home, Courses, Community, Tests, Profile
class MainShell extends StatefulWidget {
  const MainShell({super.key, this.initialIndex = 0});

  final int initialIndex;

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  late int _currentIndex;
  late PageController _pageController;

  final List<Widget> _screens = const [
    HomeScreenV2(),
    CoursesScreen(),
    CommunityScreen(),
    TestsScreen(),
    ProfileScreen(),
  ];

  final List<BottomNavItem> _navItems = const [
    BottomNavItem(icon: Icons.home, label: 'Home'),
    BottomNavItem(icon: Icons.book, label: 'Courses'),
    BottomNavItem(icon: Icons.chat, label: 'Community'),
    BottomNavItem(icon: Icons.assignment, label: 'Tests'),
    BottomNavItem(icon: Icons.person, label: 'Profile'),
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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _screens,
      ),
      bottomNavigationBar: BottomNavBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: _navItems,
      ),
    );
  }
}
