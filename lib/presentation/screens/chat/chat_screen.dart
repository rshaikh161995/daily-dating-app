import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import 'chat_detail_screen.dart' show ChatDetailScreen;

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  int selectedFilter = 0;

  final List<String> filters = [
    'All',
    'Unread',
    'Online',
    'Nearby',
    'Date',
  ];

  final List<ChatUser> users = [
    ChatUser(
      name: 'Aanya',
      age: 25,
      image:
      'https://randomuser.me/api/portraits/women/44.jpg',
      match: '92% Match',
      message:
      "Can't wait to see you tonight at the...",
      time: '2m',
      unread: 2,
      progress: 0.82,
      reward: '🎁 Gift unlocked!',
      online: true,
      badge: 'NEW',
    ),
    ChatUser(
      name: 'Jordan',
      age: 27,
      image:
      'https://randomuser.me/api/portraits/men/32.jpg',
      match: '88% Match',
      message: 'Typing...',
      time: 'Now',
      unread: 0,
      progress: 0.68,
      reward: '18/25 for Premium Rose 🌹',
      online: true,
    ),
    ChatUser(
      name: 'Marcus',
      age: 29,
      image:
      'https://randomuser.me/api/portraits/men/11.jpg',
      match: '75% Match',
      message:
      'That sounds like an amazing hobby! Ho...',
      time: '1h',
      unread: 0,
      progress: 0.20,
      reward: '5/25 · Deadline 14h ⏰',
      online: false,
    ),
    ChatUser(
      name: 'Elena',
      age: 23,
      image:
      'https://randomuser.me/api/portraits/women/65.jpg',
      match: '95% Match',
      message: 'You: Hey! I’m heading over now.',
      time: '3h',
      unread: 0,
      progress: 0.72,
      reward: '22/25 for Silver Ring 💍',
      online: true,
    ),
    ChatUser(
      name: 'Rohan',
      age: 26,
      image:
      'https://randomuser.me/api/portraits/men/75.jpg',
      match: '81% Match',
      message: 'See you soon!',
      time: 'Yesterday',
      unread: 0,
      progress: 0.45,
      reward: '12/25',
      online: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(
                  18,
                  18,
                  18,
                  10,
                ),
                child: Column(
                  crossAxisAlignment:
                  CrossAxisAlignment.start,
                  children: [
                    _buildHeader(),

                    const SizedBox(height: 20),

                    _buildSearch(),

                    const SizedBox(height: 25),

                    _buildMatchesHeader(),

                    const SizedBox(height: 12),

                    _buildNewMatches(),

                    const SizedBox(height: 20),

                    _buildFilters(),

                    const SizedBox(height: 15),

                    _buildChatList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // HEADER
  // ============================================================

  Widget _buildHeader() {
    return Row(
      children: [
        const Text(
          'Messages',
          style: TextStyle(
            color: Color(0xFF151515),
            fontSize: 31,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.7,
          ),
        ),

        const Spacer(),

        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFE7E4E2),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 10,
              ),
            ],
          ),
          child: const Icon(
            Icons.settings_outlined,
            color: Color(0xFF222222),
            size: 23,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // SEARCH
  // ============================================================

  Widget _buildSearch() {
    return Container(
      height: 58,
      padding: const EdgeInsets.symmetric(
        horizontal: 17,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFE8E5E2),
        ),
      ),
      child: const Row(
        children: [
          Icon(
            Icons.search,
            color: Color(0xFF9A9A9A),
            size: 23,
          ),
          SizedBox(width: 11),
          Text(
            'Search matches or messages',
            style: TextStyle(
              color: Color(0xFFA1A1A1),
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // MATCHES HEADER
  // ============================================================

  Widget _buildMatchesHeader() {
    return const Row(
      children: [
        Text(
          'NEW MATCHES',
          style: TextStyle(
            color: Color(0xFFD95072),
            fontSize: 14,
            fontWeight: FontWeight.w800,
            letterSpacing: 1.4,
          ),
        ),
        Spacer(),
        Text(
          'See all →',
          style: TextStyle(
            color: Color(0xFF777777),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // ============================================================
  // NEW MATCHES
  // ============================================================

  Widget _buildNewMatches() {
    final matches = [
      ['Sarah', 'https://randomuser.me/api/portraits/women/1.jpg'],
      ['Ariya', 'https://randomuser.me/api/portraits/women/32.jpg'],
      ['Liam', 'https://randomuser.me/api/portraits/men/13.jpg'],
      ['Chloe', 'https://randomuser.me/api/portraits/women/30.jpg'],
      ['Dev', 'https://randomuser.me/api/portraits/men/93.jpg'],
    ];

    return SizedBox(
      height: 105,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: matches.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 17),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: 68,
                    height: 68,
                    padding: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: const Color(0xFFE56A89),
                        width: 2,
                      ),
                    ),
                    child: ClipOval(
                      child: Image.network(
                        matches[index][1],
                        fit: BoxFit.cover,
                        errorBuilder:
                            (_, __, ___) =>
                        const Icon(
                          Icons.person,
                        ),
                      ),
                    ),
                  ),

                  if (index == 0)
                    Positioned(
                      right: -5,
                      top: -5,
                      child: _matchBadge('NEW'),
                    ),

                  if (index == 1)
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFFFC52F),
                          borderRadius:
                          BorderRadius.circular(7),
                        ),
                        child: const Icon(
                          Icons.card_giftcard,
                          size: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),

                  if (index == 3)
                    Positioned(
                      right: -4,
                      top: -4,
                      child: Container(
                        width: 22,
                        height: 22,
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFE95075),
                          borderRadius:
                          BorderRadius.circular(7),
                        ),
                        child: const Icon(
                          Icons.card_giftcard,
                          size: 13,
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 7),

              Text(
                matches[index][0],
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _matchBadge(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 3,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFE95075),
        borderRadius: BorderRadius.circular(7),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 9,
          fontWeight: FontWeight.w800,
        ),
      ),
    );
  }

  // ============================================================
  // FILTERS
  // ============================================================

  Widget _buildFilters() {
    return SizedBox(
      height: 46,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        separatorBuilder: (_, __) =>
        const SizedBox(width: 9),
        itemBuilder: (context, index) {
          final selected =
              selectedFilter == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = index;
              });
            },
            child: AnimatedContainer(
              duration:
              const Duration(milliseconds: 180),
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: selected
                    ? const Color(0xFFE95075)
                    : Colors.white,
                borderRadius:
                BorderRadius.circular(24),
                border: Border.all(
                  color: selected
                      ? const Color(0xFFE95075)
                      : const Color(0xFFE6E3E1),
                ),
              ),
              child: Text(
                filters[index],
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : const Color(0xFF333333),
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

  // ============================================================
  // CHAT LIST
  // ============================================================

  Widget _buildChatList() {
    return Column(
      children: users.map((user) {
        return Padding(
          padding:
          const EdgeInsets.only(bottom: 12),
          child: _buildChatItem(user),
        );
      }).toList(),
    );
  }

  Widget _buildChatItem(ChatUser user) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ChatDetailScreen(
              user: user,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          14,
          14,
          14,
          13,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(23),
          border: Border.all(
            color: const Color(0xFFE8E5E2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.025),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: [
            _profileImage(user),

            const SizedBox(width: 12),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${user.name}, ${user.age}',
                        style: const TextStyle(
                          fontSize: 17,
                          fontWeight:
                          FontWeight.w800,
                        ),
                      ),

                      const SizedBox(width: 7),

                      Container(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          horizontal: 7,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color:
                          const Color(0xFFFFE7EE),
                          borderRadius:
                          BorderRadius.circular(
                            8,
                          ),
                        ),
                        child: Text(
                          user.match,
                          style:
                          const TextStyle(
                            color:
                            Color(0xFFC9486B),
                            fontSize: 10,
                            fontWeight:
                            FontWeight.w800,
                          ),
                        ),
                      ),

                      const Spacer(),

                      Text(
                        user.time,
                        style: const TextStyle(
                          color: Color(0xFF999999),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 5),

                  Text(
                    user.message,
                    maxLines: 1,
                    overflow:
                    TextOverflow.ellipsis,
                    style: TextStyle(
                      color: user.message ==
                          'Typing...'
                          ? const Color(
                        0xFFE95075,
                      )
                          : const Color(
                        0xFF666666,
                      ),
                      fontSize: 14,
                      fontWeight:
                      user.message ==
                          'Typing...'
                          ? FontWeight.w600
                          : FontWeight.w400,
                    ),
                  ),

                  const SizedBox(height: 9),

                  Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius:
                          BorderRadius.circular(
                            10,
                          ),
                          child:
                          LinearProgressIndicator(
                            value: user.progress,
                            minHeight: 5,
                            backgroundColor:
                            const Color(
                              0xFFF0ECEC,
                            ),
                            valueColor:
                            AlwaysStoppedAnimation(
                              user.progress > 0.7
                                  ? const Color(
                                0xFF43B982,
                              )
                                  : const Color(
                                0xFFE95075,
                              ),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 10),

                      Flexible(
                        child: Text(
                          user.reward,
                          maxLines: 1,
                          overflow:
                          TextOverflow.ellipsis,
                          style: TextStyle(
                            color: user.progress >
                                0.7
                                ? const Color(
                              0xFF4E9C79,
                            )
                                : const Color(
                              0xFFC8556F,
                            ),
                            fontSize: 11,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            if (user.unread > 0)
              Padding(
                padding:
                const EdgeInsets.only(
                  left: 7,
                  top: 42,
                ),
                child: Container(
                  width: 25,
                  height: 25,
                  decoration:
                  const BoxDecoration(
                    color: Color(0xFFE95075),
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${user.unread}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _profileImage(ChatUser user) {
    return Stack(
      children: [
        Container(
          width: 67,
          height: 67,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: const Color(0xFFE95075),
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              user.image,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) =>
              const Icon(
                Icons.person,
                size: 30,
              ),
            ),
          ),
        ),

        if (user.online)
          Positioned(
            right: 0,
            bottom: 2,
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: const Color(0xFF35C779),
                shape: BoxShape.circle,
                border: Border.all(
                  color: Colors.white,
                  width: 2,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

// ================================================================
// CHAT USER MODEL
// ================================================================

class ChatUser {
  final String name;
  final int age;
  final String image;
  final String match;
  final String message;
  final String time;
  final int unread;
  final double progress;
  final String reward;
  final bool online;
  final String? badge;

  ChatUser({
    required this.name,
    required this.age,
    required this.image,
    required this.match,
    required this.message,
    required this.time,
    required this.unread,
    required this.progress,
    required this.reward,
    required this.online,
    this.badge,
  });
}