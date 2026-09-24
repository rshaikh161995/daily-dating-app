import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart' show AppColors;
import '../../core/constants/app_colors.dart';

class HomeBottomNavigation extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const HomeBottomNavigation({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 76,
      decoration: const BoxDecoration(
        color: AppColors.navBackground,
      ),
      child: Row(
        children: [
          _NavItem(
            icon: Icons.home_outlined,
            activeIcon: Icons.home_outlined,
            label: 'Home',
            selected: currentIndex == 0,
            onTap: () => onTap(0),
          ),

          _NavItem(
            icon: Icons.play_circle_outline,
            activeIcon: Icons.play_circle_outline,
            label: 'Date Now',
            selected: currentIndex == 1,
            onTap: () => onTap(1),
          ),

          _NavItem(
            icon: Icons.favorite_border,
            activeIcon: Icons.favorite_border,
            label: 'Admirers',
            selected: currentIndex == 2,
            onTap: () => onTap(2),
          ),

          _NavItem(
            icon: Icons.chat_bubble_outline,
            activeIcon: Icons.chat_bubble_outline,
            label: 'Chat',
            selected: currentIndex == 3,
            onTap: () => onTap(3),
          ),

          _NavItem(
            icon: Icons.event_outlined,
            activeIcon: Icons.event_outlined,
            label: 'Events',
            selected: currentIndex == 4,
            onTap: () => onTap(4),
          ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final IconData activeIcon;
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            Icon(
              selected ? activeIcon : icon,
              size: 22,
              color: selected
                  ? AppColors.primary
                  : AppColors.textDark,
            ),

            const SizedBox(height: 5),

            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                color: selected
                    ? AppColors.primary
                    : AppColors.textDark,
                fontWeight: selected
                    ? FontWeight.w500
                    : FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}