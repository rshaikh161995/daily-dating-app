import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../core/constants/app_colors.dart';
import 'profile_badges.dart';

class ProfileCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final int age;
  final String location;
  final String profession;
  final String height;
  final String relationship;
  final String gender;
  final String state;
  final String country;


  const ProfileCard({
    super.key,
    required this.imageUrl,
    required this.name,
    required this.age,
    required this.location,
    required this.profession,
    required this.height,
    required this.relationship,
    required this.gender,
    required this.state,
    required this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(21),
        color: AppColors.cardBlack,
      ),
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Profile image
          Image.network(
            imageUrl,
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            filterQuality: FilterQuality.high,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: Colors.grey.shade300,
                child: const Icon(
                  Icons.person,
                  size: 70,
                  color: Colors.grey,
                ),
              );
            },
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }

              return Container(
                color: Colors.grey.shade200,
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              );
            },
          ),

          // Bottom black gradient
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: const [
                    0.35,
                    0.60,
                    0.78,
                    1,
                  ],
                  colors: [
                    Colors.transparent,
                    Colors.black.withOpacity(.05),
                    Colors.black.withOpacity(.65),
                    Colors.black.withOpacity(.96),
                  ],
                ),
              ),
            ),
          ),

          // Top left refresh
          Positioned(
            top: 13,
            left: 13,
            child: _CircleAction(
              icon: Icons.refresh,
              onTap: () {},
            ),
          ),

          // Top right more
          Positioned(
            top: 13,
            right: 13,
            child: _CircleAction(
              icon: Icons.more_vert,
              onTap: () {},
            ),
          ),

          // Profile information
          Positioned(
            left: 17,
            right: 17,
            bottom: 16,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                const ProfileBadges(),

                const SizedBox(height: 7),

                // Name
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.online,
                        shape: BoxShape.circle,
                      ),
                    ),

                    const SizedBox(width: 7),

                    Flexible(
                      child: Text(
                        '$name $age',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700,
                          height: 1,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    Container(
                      width: 17,
                      height: 17,
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.check,
                        color: Colors.white,
                        size: 11,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                _InfoRow(
                  icon: Icons.location_on,
                  text: location,
                ),

                const SizedBox(height: 4),

                _InfoRow(
                  icon: Icons.work_outline,
                  text: '$profession · $height',
                ),

                const SizedBox(height: 4),

                _InfoRow(
                  icon: Icons.favorite_border,
                  text: relationship,
                ),
              ],
            ),
          ),

          // Rose button
          Positioned(
            right: 13,
            bottom: 15,
            child: _RoseButton(
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}

class _CircleAction extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleAction({
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
          width: 35,
          height: 35,
          child: Icon(
            icon,
            size: 18,
            color: AppColors.textDark,
          ),
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 12,
          color: Colors.white,
        ),

        const SizedBox(width: 5),

        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}

class _RoseButton extends StatelessWidget {
  final VoidCallback onTap;

  const _RoseButton({
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 3,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Container(
              width: 34,
              height: 34,
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  '🌹',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}