import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class DateNowScreen extends StatefulWidget {
  const DateNowScreen({super.key});

  @override
  State<DateNowScreen> createState() => _DateNowScreenState();
}

class _DateNowScreenState extends State<DateNowScreen> {
  int selectedTab = 0;

  final List<String> tabs = [
    'Today',
    'Tomorrow',
    'Weekend',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F7F2),

      body: SafeArea(
        child: Column(
          children: [
            // =========================================================
            // MAIN CONTENT
            // =========================================================

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  16,
                  15,
                  16,
                  20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // =================================================
                    // HEADER
                    // =================================================

                    _buildHeader(),

                    const SizedBox(height: 22),

                    // =================================================
                    // TODAY / TOMORROW / WEEKEND
                    // =================================================

                    _buildDateTabs(),

                    const SizedBox(height: 22),

                    // =================================================
                    // DATE CARD
                    // =================================================

                    _buildDateCard(),

                    const SizedBox(height: 20),

                    // =================================================
                    // MORE DATE CARD
                    // =================================================

                    _buildSecondDateCard(),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            // =========================================================
            // BOTTOM ACTIONS
            // =========================================================

            _buildBottomActions(),
          ],
        ),
      ),
    );
  }

  // ===============================================================
  // HEADER
  // ===============================================================

  Widget _buildHeader() {
    return Row(
      children: [
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Date ',
                style: TextStyle(
                  color: Color(0xFF151515),
                  fontSize: 31,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
              TextSpan(
                text: 'Now',
                style: TextStyle(
                  color: Color(0xFFE44872),
                  fontSize: 31,
                  fontWeight: FontWeight.w800,
                  letterSpacing: -1,
                ),
              ),
            ],
          ),
        ),

        const Spacer(),

        // My Plans
        Container(
          height: 52,
          padding: const EdgeInsets.symmetric(
            horizontal: 17,
          ),
          decoration: BoxDecoration(
            color: const Color(0xFFE44872),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFE44872)
                    .withOpacity(0.22),
                blurRadius: 14,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(
                Icons.calendar_month_outlined,
                color: Colors.white,
                size: 22,
              ),

              const SizedBox(width: 8),

              const Text(
                'My Plans',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(width: 8),

              Container(
                width: 25,
                height: 25,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: const Text(
                  '2',
                  style: TextStyle(
                    color: Color(0xFFE44872),
                    fontSize: 13,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ===============================================================
  // DATE TABS
  // ===============================================================

  Widget _buildDateTabs() {
    return Row(
      children: List.generate(
        tabs.length,
            (index) {
          final bool selected =
              selectedTab == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedTab = index;
                });
              },
              child: AnimatedContainer(
                duration:
                const Duration(milliseconds: 200),
                height: 66,
                margin: EdgeInsets.only(
                  right: index == tabs.length - 1
                      ? 0
                      : 10,
                ),
                decoration: BoxDecoration(
                  color: selected
                      ? const Color(0xFFFFF0F3)
                      : Colors.white,
                  borderRadius:
                  BorderRadius.circular(20),
                  border: Border.all(
                    color: selected
                        ? const Color(0xFFE44872)
                        : const Color(0xFFE7E4E2),
                    width: selected ? 2 : 1,
                  ),
                ),
                alignment: Alignment.center,
                child: Text(
                  tabs[index],
                  style: TextStyle(
                    color: selected
                        ? const Color(0xFFD83D68)
                        : const Color(0xFF242424),
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // ===============================================================
  // MAIN DATE CARD
  // ===============================================================

  Widget _buildDateCard() {
    return Container(
      height: 650,
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(28),
        color: const Color(0xFF201B20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.12),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // =========================================================
          // IMAGE
          // =========================================================

          Positioned.fill(
            child: Image.network(
              'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=900&q=85',
              fit: BoxFit.cover,
              errorBuilder:
                  (context, error, stackTrace) {
                return Container(
                  color: const Color(0xFF393337),
                  child: const Icon(
                    Icons.restaurant,
                    size: 70,
                    color: Colors.white54,
                  ),
                );
              },
            ),
          ),

          // =========================================================
          // DARK GRADIENT
          // =========================================================

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.10),
                    Colors.transparent,
                    Colors.black.withOpacity(0.90),
                  ],
                  stops: const [
                    0,
                    0.45,
                    1,
                  ],
                ),
              ),
            ),
          ),

          // =========================================================
          // TOP LOCATION
          // =========================================================

          Positioned(
            left: 18,
            top: 20,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                _greenBadge(
                  icon: Icons.circle,
                  text: 'Live · Olive Bar, Mahalaxmi',
                ),

                const SizedBox(height: 10),

                _darkBadge(
                  icon: Icons.location_on,
                  text: '3.4 km away',
                ),
              ],
            ),
          ),

          // =========================================================
          // FLAG
          // =========================================================

          Positioned(
            right: 17,
            bottom: 180,
            child: Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: const Color(0xFF403A40)
                    .withOpacity(0.85),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.flag_outlined,
                color: Color(0xFFFF527E),
                size: 22,
              ),
            ),
          ),

          // =========================================================
          // CARD INFORMATION
          // =========================================================

          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                // -----------------------------------------------
                // DATE / TIME / TYPE
                // -----------------------------------------------

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _pinkSmallBadge(
                        Icons.calendar_month_outlined,
                        'TODAY',
                      ),

                      const SizedBox(width: 8),

                      _darkSmallBadge(
                        Icons.access_time,
                        '8:30 PM',
                      ),

                      const SizedBox(width: 8),

                      _darkSmallBadge(
                        Icons.people_outline,
                        'Dinner',
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 13),

                // -----------------------------------------------
                // TITLE
                // -----------------------------------------------

                const Text(
                  'Pasta & Honest Chats',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.w800,
                    height: 1.05,
                  ),
                ),

                const SizedBox(height: 7),

                // -----------------------------------------------
                // DESCRIPTION
                // -----------------------------------------------

                const Text(
                  'Foodie looking for a dinner buddy 🍝',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 13),

                // -----------------------------------------------
                // MATCH DETAILS
                // -----------------------------------------------

                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      _darkSmallBadge(
                        Icons.favorite,
                        '88% match',
                        iconColor:
                        const Color(0xFFDA49F0),
                      ),

                      const SizedBox(width: 8),

                      _darkSmallBadge(
                        Icons.people,
                        'Just 1',
                        iconColor:
                        const Color(0xFF1CA7E8),
                      ),

                      const SizedBox(width: 8),

                      _darkSmallBadge(
                        Icons.handshake_outlined,
                        'I’ll pay',
                        iconColor:
                        const Color(0xFFFFD04A),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 14),

                // -----------------------------------------------
                // PROFILE
                // -----------------------------------------------

                _profileMiniCard(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // PROFILE MINI CARD
  // ===============================================================

  Widget _profileMiniCard() {
    return Container(
      height: 82,
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 10,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF3A343C)
            .withOpacity(0.88),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: Colors.white.withOpacity(0.12),
        ),
      ),
      child: Row(
        children: [
          // Profile image
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: const Color(0xFFE44872),
                width: 3,
              ),
            ),
            child: ClipOval(
              child: Image.network(
                'https://randomuser.me/api/portraits/women/44.jpg',
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) {
                  return const Icon(
                    Icons.person,
                    color: Colors.white,
                  );
                },
              ),
            ),
          ),

          const SizedBox(width: 12),

          // Name
          const Expanded(
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Ananya, 25',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 5),
                    Icon(
                      Icons.verified,
                      color: Color(0xFFFF83A1),
                      size: 17,
                    ),
                  ],
                ),

                SizedBox(height: 4),

                Text(
                  'she/her · Foodie',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),

          // Profile button
          const Text(
            'Profile →',
            style: TextStyle(
              color: Color(0xFFFF9AB2),
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // SECOND DATE CARD
  // ===============================================================

  Widget _buildSecondDateCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: const Color(0xFFE8E4E2),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: const Color(0xFFFFE8EE),
              borderRadius:
              BorderRadius.circular(18),
            ),
            child: const Icon(
              Icons.favorite_outline,
              color: Color(0xFFE44872),
              size: 28,
            ),
          ),

          const SizedBox(width: 14),

          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  'Plan something together',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  'Create a date plan for someone you like.',
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios,
            size: 16,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // BOTTOM ACTIONS
  // ===============================================================

  Widget _buildBottomActions() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        16,
        12,
        16,
        14,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F7F2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 15,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Row(
        children: [
          // =======================================================
          // SKIP
          // =======================================================

          Expanded(
            flex: 1,
            child: SizedBox(
              height: 60,
              child: OutlinedButton(
                onPressed: () {
                  _showSnackBar(
                    'Date skipped',
                  );
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor:
                  const Color(0xFFD94A68),
                  side: const BorderSide(
                    color: Color(0xFFE8E1E1),
                  ),
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.close,
                      size: 24,
                    ),
                    SizedBox(width: 7),
                    Text(
                      'Skip',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(width: 12),

          // =======================================================
          // REQUEST DATE
          // =======================================================

          Expanded(
            flex: 1,
            child: SizedBox(
              height: 60,
              child: ElevatedButton(
                onPressed: () {
                  _showSnackBar(
                    'Date request sent 💗',
                  );
                },
                style:
                ElevatedButton.styleFrom(
                  backgroundColor:
                  const Color(0xFFE44872),
                  foregroundColor: Colors.white,
                  elevation: 5,
                  shadowColor:
                  const Color(0xFFE44872)
                      .withOpacity(0.30),
                  shape:
                  RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(20),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment:
                  MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.calendar_month_outlined,
                      size: 22,
                    ),
                    SizedBox(width: 8),
                    Text(
                      'Request Date',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                        FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // GREEN BADGE
  // ===============================================================

  Widget _greenBadge({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF12C982),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.circle,
            color: Colors.white,
            size: 8,
          ),
          const SizedBox(width: 7),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // DARK BADGE
  // ===============================================================

  Widget _darkBadge({
    required IconData icon,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF252127)
            .withOpacity(0.86),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 13,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // PINK SMALL BADGE
  // ===============================================================

  Widget _pinkSmallBadge(
      IconData icon,
      String text,
      ) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 13,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE44872),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: Colors.white,
            size: 15,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w800,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // DARK SMALL BADGE
  // ===============================================================

  Widget _darkSmallBadge(
      IconData icon,
      String text, {
        Color iconColor = Colors.white70,
      }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFF4B454B)
            .withOpacity(0.86),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: iconColor,
            size: 15,
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ===============================================================
  // SNACKBAR
  // ===============================================================

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior:
          SnackBarBehavior.floating,
          backgroundColor:
          const Color(0xFF292329),
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(15),
          ),
          content: Text(message),
        ),
      );
  }
}