import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: _buildHeader(),
            ),

            SliverToBoxAdapter(
              child: _buildCategoryChips(),
            ),

            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'Featured Events',
                'See all',
              ),
            ),

            SliverToBoxAdapter(
              child: _buildFeaturedEvents(),
            ),

            SliverToBoxAdapter(
              child: _buildSectionTitle(
                'Upcoming Near You',
                'View all',
              ),
            ),

            SliverPadding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 30),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                      (context, index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _eventListCard(
                        event: upcomingEvents[index],
                      ),
                    );
                  },
                  childCount: upcomingEvents.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // HEADER
  // ----------------------------------------------------------

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Events',
                        style: TextStyle(
                          color: AppColors.textDark,
                          fontSize: 28,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      TextSpan(
                        text: ' ✦',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 25,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Meet people. Make memories.',
                  style: TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          _circleButton(
            icon: Icons.search_rounded,
            onTap: () {},
          ),

          const SizedBox(width: 10),

          _circleButton(
            icon: Icons.tune_rounded,
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _circleButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: SizedBox(
          width: 44,
          height: 44,
          child: Icon(
            icon,
            color: AppColors.textDark,
            size: 21,
          ),
        ),
      ),
    );
  }

  // ----------------------------------------------------------
  // CATEGORY CHIPS
  // ----------------------------------------------------------

  Widget _buildCategoryChips() {
    final categories = [
      'All',
      'Tonight',
      'This Weekend',
      'Coffee',
      'Dinner',
      'Activities',
    ];

    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == 0;

          return Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 17,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: selected
                  ? AppColors.primary
                  : AppColors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: selected
                    ? AppColors.primary
                    : AppColors.border,
              ),
            ),
            child: Text(
              categories[index],
              style: TextStyle(
                color: selected
                    ? AppColors.white
                    : AppColors.textDark,
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        },
      ),
    );
  }

  // ----------------------------------------------------------
  // SECTION TITLE
  // ----------------------------------------------------------

  Widget _buildSectionTitle(
      String title,
      String action,
      ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 25, 18, 13),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: AppColors.textDark,
                fontSize: 19,
                fontWeight: FontWeight.w800,
              ),
            ),
          ),
          Text(
            action,
            style: const TextStyle(
              color: AppColors.primary,
              fontSize: 13,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  // ----------------------------------------------------------
  // FEATURED EVENTS
  // ----------------------------------------------------------

  Widget _buildFeaturedEvents() {
    return SizedBox(
      height: 275,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: featuredEvents.length,
        separatorBuilder: (_, __) => const SizedBox(width: 14),
        itemBuilder: (context, index) {
          return _featuredEventCard(
            event: featuredEvents[index],
          );
        },
      ),
    );
  }

  Widget _featuredEventCard({
    required EventData event,
  }) {
    return Container(
      width: 285,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.cardBlack,
        borderRadius: BorderRadius.circular(23),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.network(
              event.image,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: AppColors.imagePurple,
                );
              },
            ),
          ),

          Positioned.fill(
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.10),
                    Colors.black.withValues(alpha: 0.88),
                  ],
                ),
              ),
            ),
          ),

          // Date badge
          Positioned(
            top: 14,
            left: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 11,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Text(
                    event.day,
                    style: const TextStyle(
                      color: AppColors.primary,
                      fontSize: 17,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    event.month,
                    style: const TextStyle(
                      color: AppColors.textDark,
                      fontSize: 10,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Attendees
          Positioned(
            top: 14,
            right: 14,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 7,
              ),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.45),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.people_alt_rounded,
                    color: Colors.white,
                    size: 15,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    '${event.attendees}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom details
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  event.type.toUpperCase(),
                  style: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 1,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 21,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      color: Colors.white70,
                      size: 15,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        event.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
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

  // ----------------------------------------------------------
  // UPCOMING EVENT CARD
  // ----------------------------------------------------------

  Widget _eventListCard({
    required EventData event,
  }) {
    return Container(
      padding: const EdgeInsets.all(11),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: AppColors.border,
        ),
      ),
      child: Row(
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.network(
              event.image,
              width: 78,
              height: 82,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 78,
                  height: 82,
                  color: AppColors.primaryLight,
                  child: const Icon(
                    Icons.event_rounded,
                    color: AppColors.primary,
                  ),
                );
              },
            ),
          ),

          const SizedBox(width: 13),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${event.day} ${event.month}',
                      style: const TextStyle(
                        color: AppColors.primary,
                        fontSize: 11,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const Spacer(),
                    Text(
                      event.distance,
                      style: const TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 5),

                Text(
                  event.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textDark,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),

                const SizedBox(height: 4),

                Text(
                  event.description,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textGrey,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 7),

                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 14,
                      color: AppColors.textGrey,
                    ),
                    const SizedBox(width: 3),
                    Expanded(
                      child: Text(
                        event.location,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: AppColors.textGrey,
                          fontSize: 11,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(width: 8),

          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.arrow_forward_rounded,
              color: AppColors.primary,
              size: 19,
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// EVENT MODEL
// ============================================================

class EventData {
  final String title;
  final String type;
  final String day;
  final String month;
  final String location;
  final String description;
  final String image;
  final String distance;
  final int attendees;

  const EventData({
    required this.title,
    required this.type,
    required this.day,
    required this.month,
    required this.location,
    required this.description,
    required this.image,
    required this.distance,
    required this.attendees,
  });
}

// ============================================================
// FEATURED EVENTS
// ============================================================

const List<EventData> featuredEvents = [
  EventData(
    title: 'Sunset Rooftop Social',
    type: 'Social Night',
    day: '26',
    month: 'SEP',
    location: 'Sky Lounge · 2.4 km',
    description: 'Good music, drinks & new connections',
    image:
    'https://images.unsplash.com/photo-1519671482749-fd09be7ccebf?auto=format&fit=crop&w=900&q=85',
    distance: '2.4 km',
    attendees: 48,
  ),
  EventData(
    title: 'Coffee & Conversations',
    type: 'Coffee Meet',
    day: '27',
    month: 'SEP',
    location: 'The Brew Room · 1.8 km',
    description: 'Small groups. Easy conversations.',
    image:
    'https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?auto=format&fit=crop&w=900&q=85',
    distance: '1.8 km',
    attendees: 26,
  ),
  EventData(
    title: 'Singles Dinner Night',
    type: 'Dinner',
    day: '28',
    month: 'SEP',
    location: 'Olive Bar · 4.1 km',
    description: 'Dinner with interesting people',
    image:
    'https://images.unsplash.com/photo-1515003197210-e0cd71810b5f?auto=format&fit=crop&w=900&q=85',
    distance: '4.1 km',
    attendees: 34,
  ),
];

// ============================================================
// UPCOMING EVENTS
// ============================================================

const List<EventData> upcomingEvents = [
  EventData(
    title: 'Friday Night Mixer',
    type: 'Mixer',
    day: '26',
    month: 'SEP',
    location: 'The Social House',
    description: 'Meet, chat & make a connection',
    image:
    'https://images.unsplash.com/photo-1529156069898-49953e39b3ac?auto=format&fit=crop&w=500&q=85',
    distance: '2.1 km',
    attendees: 42,
  ),
  EventData(
    title: 'Brunch & New Beginnings',
    type: 'Brunch',
    day: '27',
    month: 'SEP',
    location: 'Green Leaf Cafe',
    description: 'Relaxed Sunday brunch meetup',
    image:
    'https://images.unsplash.com/photo-1533777857889-4be7c70b33f7?auto=format&fit=crop&w=500&q=85',
    distance: '3.5 km',
    attendees: 29,
  ),
  EventData(
    title: 'Game Night',
    type: 'Activities',
    day: '28',
    month: 'SEP',
    location: 'Play Arena',
    description: 'Games, laughs and new people',
    image:
    'https://images.unsplash.com/photo-1511512578047-dfb367046420?auto=format&fit=crop&w=500&q=85',
    distance: '5.2 km',
    attendees: 31,
  ),
  EventData(
    title: 'Art & Coffee',
    type: 'Creative',
    day: '29',
    month: 'SEP',
    location: 'Canvas Cafe',
    description: 'Create something together',
    image:
    'https://images.unsplash.com/photo-1513364776144-60967b0f800f?auto=format&fit=crop&w=500&q=85',
    distance: '4.7 km',
    attendees: 18,
  ),
];