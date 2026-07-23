import 'package:flutter/material.dart';

import '../config/theme.dart';
import '../models/category_model.dart';
import '../utils/responsive.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<_NavItem> _items = [
    _NavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Home',
    ),
    _NavItem(
      icon: Icons.store_outlined,
      activeIcon: Icons.store,
      label: 'Shop',
    ),
    _NavItem(
      icon: Icons.grid_view_outlined,
      label: 'My Workspace',
    ),
    _NavItem(
      icon: Icons.shopping_basket_outlined,
      label: 'Basket',
    ),
    _NavItem(
      icon: Icons.more_horiz,
      label: 'More',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.of(context).viewPadding.bottom;

    return ValueListenableBuilder<int>(
      valueListenable: cartChangeNotifier,
      builder: (context, _, __) {
        return Container(
          padding: EdgeInsets.only(bottom: bottomInset),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
              top: BorderSide(
                color: Color(0xFFD9D9D9),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: List.generate(
              _items.length,
              (index) => Expanded(
                child: _buildNavItem(
                  context: context,
                  item: _items[index],
                  isActive: currentIndex == index,
                  onTap: () => onTap(index),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required _NavItem item,
    required bool isActive,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Green indicator bar at top
          // Container(
          //   height: context.rh(3, minScale: 0.8, maxScale: 1.1),
          //   color: isActive ? AppTheme.primaryTeal : Colors.transparent,
          // ),

          Align(
            alignment: Alignment.center,
            child: Container(
              width: context.rw(55),
              height: 3,
              decoration: BoxDecoration(
                color: isActive ? AppTheme.primaryTeal : Colors.transparent,
                borderRadius: BorderRadius.circular(0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: context.rh(8)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      isActive && item.activeIcon != null ? item.activeIcon : item.icon,
                      size: context.rw(24),
                      color: isActive ? AppTheme.primaryTeal : Colors.grey[400],
                    ),
                    if (item.label == 'Basket' && globalCart.isNotEmpty)
                      Positioned(
                        top: -context.rh(8),
                        right: -context.rw(6),
                        child: Container(
                          width: context.rw(10),
                          height: context.rw(10),
                          decoration: const BoxDecoration(
                            color: AppTheme.appTheme,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: context.rh(4)),
                Text(
                  item.label,
                  style: AppTheme.dmSans(
                    fontSize: context.rf(10),
                    fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
                    color: isActive ? AppTheme.primaryTeal : Colors.grey[400] ?? Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final IconData? activeIcon;
  final String label;

  const _NavItem({
    required this.icon,
    this.activeIcon,
    required this.label,
  });
}

