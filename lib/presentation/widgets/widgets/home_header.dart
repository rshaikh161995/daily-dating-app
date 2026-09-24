import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../core/constants/app_colors.dart';
import '../../screens/notification/notifications_screen.dart' show NotificationsScreen;

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        15,
        7,
        15,
        8,
      ),
      child: Row(
        children: [
          // Menu
          _HeaderButton(
            icon: Icons.menu,
            onTap: () {},
          ),

          const Spacer(),

          // Daily 25
          Container(
            height: 38,
            padding: const EdgeInsets.symmetric(
              horizontal: 15,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 7,
                  height: 7,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),

                const SizedBox(width: 6),

                const Text(
                  'Daily 25',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textDark,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          // Lightning
          _HeaderButton(
            icon: Icons.bolt_outlined,
            onTap: () {},
          ),

          const SizedBox(width: 7),

          // Filter
          _HeaderButton(
            icon: Icons.tune,
            onTap: () {},
          ),

          const SizedBox(width: 7),

          // Notification
          Stack(
            clipBehavior: Clip.none,
            children: [
              _HeaderButton(
                icon: Icons.notifications_none,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const NotificationsScreen(),
                    ),
                  );
                },
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  width: 5,
                  height: 5,
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _HeaderButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 38,
          height: 38,
          child: Icon(
            icon,
            size: 20,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }
}