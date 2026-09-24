import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../core/constants/app_colors.dart';

class ProfileBadges extends StatelessWidget {
  final int match;
  final int trust;

  const ProfileBadges({
    super.key,
    this.match = 74,
    this.trust = 98,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _Badge(
          dotColor: Colors.white,
          text: '$match% Match',
        ),

        const SizedBox(width: 5),

        _Badge(
          dotColor: AppColors.online,
          text: '$trust% Trust',
        ),

        const SizedBox(width: 5),

        _Badge(
          dotColor: AppColors.replyYellow,
          text: '~5m Reply',
        ),
      ],
    );
  }
}

class _Badge extends StatelessWidget {
  final Color dotColor;
  final String text;

  const _Badge({
    required this.dotColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 24,
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
      ),
      decoration: BoxDecoration(
        color: AppColors.badgeBackground,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(
          color: Colors.white.withOpacity(.25),
          width: .6,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),

          const SizedBox(width: 4),

          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}