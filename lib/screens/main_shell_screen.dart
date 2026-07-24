import 'package:flutter/material.dart';
import '../widgets/app_bottom_nav_bar.dart';
import 'home/home_screen.dart';
import 'home/shop_screen.dart';
import 'home/my_workspace_screen.dart';
import 'home/basket_screen.dart';
import 'home/more_screen.dart';

class MainShellScreen extends StatefulWidget {
  final int initialIndex;

  const MainShellScreen({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainShellScreen> createState() => _MainShellScreenState();
}

class _MainShellScreenState extends State<MainShellScreen> {
  late int _currentIndex;
  final List<int> _tabHistory = [];

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _tabHistory.add(_currentIndex);
  }

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
        _tabHistory.add(index);
      });
    }
  }

  void _goBackTab() {
    if (_tabHistory.length > 1) {
      setState(() {
        _tabHistory.removeLast();
        _currentIndex = _tabHistory.last;
      });
    } else if (_currentIndex != 0) {
      setState(() {
        _currentIndex = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _tabHistory.length <= 1 && _currentIndex == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;
        _goBackTab();
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            HomeScreen(
              currentNavIndex: _currentIndex,
              onNavTap: _onTabTapped,
            ),
            ShopScreen(
              currentIndex: _currentIndex,
              onNavTap: _onTabTapped,
              onBackTap: _goBackTab,
            ),
            MyWorkspaceScreen(
              currentNavIndex: _currentIndex,
              onNavTap: _onTabTapped,
            ),
            BasketScreen(
              currentNavIndex: _currentIndex,
              onNavTap: _onTabTapped,
            ),
            MoreScreen(
              currentNavIndex: _currentIndex,
              onNavTap: _onTabTapped,
            ),
          ],
        ),
        bottomNavigationBar: AppBottomNavBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }
}
