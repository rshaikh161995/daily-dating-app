import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class AdmirersScreen extends StatefulWidget {
  const AdmirersScreen({super.key});

  @override
  State<AdmirersScreen> createState() => _AdmirersScreenState();
}

class _AdmirersScreenState extends State<AdmirersScreen> {
  int selectedFilter = 0;

  final List<String> filters = [
    'All',
    'New',
    'Online',
    'Nearby',
    'Roses',
  ];

  final List<Admirer> admirers = [
    Admirer(
      name: 'Aanya',
      age: 25,
      image: 'https://randomuser.me/api/portraits/women/44.jpg',
      match: 92,
      location: '4 km away',
      profession: 'Fashion Designer',
      isOnline: true,
      hasRose: true,
      message: 'Liked your profile',
    ),
    Admirer(
      name: 'Jordan',
      age: 27,
      image: 'https://randomuser.me/api/portraits/men/32.jpg',
      match: 88,
      location: '6 km away',
      profession: 'Photographer',
      isOnline: true,
      hasRose: false,
      message: 'Sent you a like',
    ),
    Admirer(
      name: 'Elena',
      age: 23,
      image: 'https://randomuser.me/api/portraits/women/32.jpg',
      match: 95,
      location: '3 km away',
      profession: 'Designer',
      isOnline: true,
      hasRose: true,
      message: 'Sent you a Rose',
    ),
    Admirer(
      name: 'Dev',
      age: 27,
      image: 'https://randomuser.me/api/portraits/men/75.jpg',
      match: 81,
      location: '8 km away',
      profession: 'Software Engineer',
      isOnline: false,
      hasRose: true,
      message: 'Liked your profile',
    ),
    Admirer(
      name: 'Sarah',
      age: 26,
      image: 'https://randomuser.me/api/portraits/women/68.jpg',
      match: 89,
      location: '5 km away',
      profession: 'Marketing',
      isOnline: true,
      hasRose: false,
      message: 'Viewed your profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: Column(
          children: [
            _buildHeader(),
            _buildTopStats(),
            _buildFilters(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  18,
                  12,
                  18,
                  25,
                ),
                children: [
                  const Text(
                    'PEOPLE WHO ADMIRE YOU',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.1,
                      color: AppColors.textGrey,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...admirers.map(
                        (admirer) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _AdmirerCard(
                        admirer: admirer,
                        onLike: () {
                          _showMessage(
                            '${admirer.name} liked ❤️',
                          );
                        },
                        onRose: () {
                          _showMessage(
                            'Rose sent to ${admirer.name} 🌹',
                          );
                        },
                        onProfile: () {
                          _openProfile(admirer);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 8),
      child: Row(
        children: [
          _circleButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () {
              Navigator.of(context).maybePop();
            },
          ),

          const SizedBox(width: 16),

          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Admirers',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    height: 1,
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  'People who are interested in you',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          _circleButton(
            icon: Icons.tune_rounded,
            onTap: () {
              _showMessage('Filters');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildTopStats() {
    return Container(
      height: 112,
      margin: const EdgeInsets.fromLTRB(18, 12, 18, 5),
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: _statItem(
              icon: Icons.favorite_rounded,
              value: '24',
              title: 'Admirers',
              iconColor: AppColors.primary,
            ),
          ),
          Container(
            width: 1,
            height: 55,
            color: AppColors.border,
          ),
          Expanded(
            child: _statItem(
              icon: Icons.favorite_border_rounded,
              value: '8',
              title: 'New today',
              iconColor: const Color(0xFFD79500),
            ),
          ),
          Container(
            width: 1,
            height: 55,
            color: AppColors.border,
          ),
          Expanded(
            child: _statItem(
              icon: Icons.bolt_rounded,
              value: '12',
              title: 'Matches',
              iconColor: const Color(0xFF8B72D8),
            ),
          ),
        ],
      ),
    );
  }

  Widget _statItem({
    required IconData icon,
    required String value,
    required String title,
    required Color iconColor,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: iconColor,
          size: 22,
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: const TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: AppColors.textDark,
          ),
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 11,
            color: AppColors.textGrey,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 54,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 7,
        ),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        separatorBuilder: (_, __) {
          return const SizedBox(width: 9);
        },
        itemBuilder: (context, index) {
          final isSelected = selectedFilter == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(
                milliseconds: 200,
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.primary
                    : AppColors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(
                  color: isSelected
                      ? AppColors.primary
                      : AppColors.border,
                ),
                boxShadow: [
                  if (!isSelected)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.025),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Text(
                filters[index],
                style: TextStyle(
                  color: isSelected
                      ? AppColors.white
                      : AppColors.textDark,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.035),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 19,
          color: AppColors.textDark,
        ),
      ),
    );
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppColors.textDark,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }

  void _openProfile(Admirer admirer) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AdmirerProfileScreen(
          admirer: admirer,
        ),
      ),
    );
  }
}

class _AdmirerCard extends StatelessWidget {
  final Admirer admirer;
  final VoidCallback onLike;
  final VoidCallback onRose;
  final VoidCallback onProfile;

  const _AdmirerCard({
    required this.admirer,
    required this.onLike,
    required this.onRose,
    required this.onProfile,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(13),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(23),
        border: Border.all(
          color: AppColors.border,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          _buildImage(),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${admirer.name}, ${admirer.age}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w800,
                          color: AppColors.textDark,
                        ),
                      ),
                    ),

                    const SizedBox(width: 6),

                    const Icon(
                      Icons.verified_rounded,
                      color: AppColors.primary,
                      size: 16,
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.primaryLight,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${admirer.match}% Match',
                        style: const TextStyle(
                          color: AppColors.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),

                    const SizedBox(width: 7),

                    if (admirer.isOnline)
                      const Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: AppColors.online,
                            size: 8,
                          ),
                          SizedBox(width: 4),
                          Text(
                            'Online',
                            style: TextStyle(
                              color: AppColors.online,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                  ],
                ),

                const SizedBox(height: 7),

                Text(
                  admirer.message,
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(width: 3),
                    Text(
                      admirer.location,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textGrey,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        admirer.profession,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textGrey,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 10),

                Row(
                  children: [
                    Expanded(
                      child: _smallButton(
                        title: 'Profile',
                        icon: Icons.person_outline_rounded,
                        onTap: onProfile,
                        filled: false,
                      ),
                    ),

                    const SizedBox(width: 7),

                    _iconAction(
                      icon: Icons.favorite_border_rounded,
                      onTap: onLike,
                    ),

                    const SizedBox(width: 7),

                    _iconAction(
                      icon: Icons.local_florist_outlined,
                      onTap: onRose,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage() {
    return Stack(
      children: [
        Container(
          width: 92,
          height: 118,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(19),
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Image.network(
              admirer.image,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: const Color(0xFFE8E8E8),
                  child: const Icon(
                    Icons.person,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),

        if (admirer.isOnline)
          Positioned(
            right: 4,
            bottom: 4,
            child: Container(
              width: 17,
              height: 17,
              decoration: BoxDecoration(
                color: AppColors.online,
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.white,
                  width: 2,
                ),
              ),
            ),
          ),

        if (admirer.hasRose)
          Positioned(
            left: 4,
            top: 4,
            child: Container(
              width: 27,
              height: 27,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 6,
                  ),
                ],
              ),
              child: const Icon(
                Icons.local_florist,
                color: AppColors.primary,
                size: 15,
              ),
            ),
          ),
      ],
    );
  }

  Widget _smallButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
    required bool filled,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 35,
        decoration: BoxDecoration(
          color: filled
              ? AppColors.primary
              : AppColors.primaryLight,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 16,
              color: filled
                  ? AppColors.white
                  : AppColors.primary,
            ),
            const SizedBox(width: 5),
            Text(
              title,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                color: filled
                    ? AppColors.white
                    : AppColors.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconAction({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 35,
        height: 35,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.border,
          ),
        ),
        child: Icon(
          icon,
          size: 17,
          color: AppColors.primary,
        ),
      ),
    );
  }
}

class Admirer {
  final String name;
  final int age;
  final String image;
  final int match;
  final String location;
  final String profession;
  final bool isOnline;
  final bool hasRose;
  final String message;

  const Admirer({
    required this.name,
    required this.age,
    required this.image,
    required this.match,
    required this.location,
    required this.profession,
    required this.isOnline,
    required this.hasRose,
    required this.message,
  });
}

class AdmirerProfileScreen extends StatelessWidget {
  final Admirer admirer;

  const AdmirerProfileScreen({
    super.key,
    required this.admirer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: AppColors.textDark,
          ),
        ),
        title: const Text(
          'Profile',
          style: TextStyle(
            color: AppColors.textDark,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.fromLTRB(18, 5, 18, 30),
        child: Column(
          children: [
            Container(
              height: 390,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(28),
                image: DecorationImage(
                  image: NetworkImage(admirer.image),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    left: 18,
                    bottom: 18,
                    right: 18,
                    child: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.58),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${admirer.name}, ${admirer.age}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '${admirer.location} · ${admirer.profession}',
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Why you match',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${admirer.match}% compatibility based on your interests, location and preferences.',
                    style: const TextStyle(
                      color: AppColors.textGrey,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 15),

            Row(
              children: [
                Expanded(
                  child: _profileAction(
                    context,
                    icon: Icons.chat_bubble_outline,
                    title: 'Message',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _profileAction(
                    context,
                    icon: Icons.local_florist_outlined,
                    title: 'Send Rose',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _profileAction(
      BuildContext context, {
        required IconData icon,
        required String title,
      }) {
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title tapped'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      },
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(17),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: AppColors.white,
            ),
            const SizedBox(width: 7),
            Text(
              title,
              style: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}