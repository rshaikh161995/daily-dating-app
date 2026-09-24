import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  int selectedFilter = 0;

  final List<String> filters = [
    'All  56',
    'Likes & roses',
    'Matches',
    'Gifts',
    'Dates',
  ];

  final List<NotificationItem> notifications = [
    NotificationItem(
      name: 'Dev',
      age: 27,
      image: 'https://randomuser.me/api/portraits/men/75.jpg',
      title: 'sent you a Rose',
      message: '"Your trekking photos sold me — let’s swap trail stories."',
      time: '12 min ago',
      type: NotificationType.rose,
      buttonText: 'View profile',
      unread: true,
    ),
    NotificationItem(
      name: 'Arjun',
      age: 28,
      image: 'https://randomuser.me/api/portraits/men/32.jpg',
      title: 'complimented your About',
      message: '"Equally driven and equally curious — that line got me."',
      time: '3 h ago',
      type: NotificationType.compliment,
      unread: false,
    ),
    NotificationItem(
      name: 'Aanya',
      age: 25,
      image: 'https://randomuser.me/api/portraits/women/44.jpg',
      title: 'It\'s a match with',
      message: 'You both liked each other. Say hello before the spark fades.',
      time: '40 min ago',
      type: NotificationType.match,
      buttonText: 'Send a message',
      unread: true,
    ),
    NotificationItem(
      name: 'Elena',
      age: 23,
      image: 'https://randomuser.me/api/portraits/women/32.jpg',
      title: 'sent you a message',
      message: '"Haha okay that café pick was elite. When are you free?"',
      time: '1 h ago',
      type: NotificationType.message,
      unread: true,
    ),
    NotificationItem(
      name: 'Kabir',
      age: null,
      image: '',
      title: 'approved your date request',
      message: 'Coffee at Blue Tokai · Today, 7:00 PM · Koregaon Park',
      time: '2 h ago',
      type: NotificationType.date,
      buttonText: 'Open chat',
      unread: true,
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
            _buildFilters(),
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.fromLTRB(18, 8, 18, 25),
                children: [
                  const Padding(
                    padding: EdgeInsets.only(
                      left: 2,
                      bottom: 12,
                      top: 4,
                    ),
                    child: Text(
                      'TODAY',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 1.2,
                        color: AppColors.textGrey,
                      ),
                    ),
                  ),

                  ...notifications.map(
                        (notification) => Padding(
                      padding: const EdgeInsets.only(bottom: 14),
                      child: _NotificationCard(
                        item: notification,
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
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _CircleButton(
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
                  'Notifications',
                  style: TextStyle(
                    fontSize: 29,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                    height: 1.05,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  '9 new updates',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          GestureDetector(
            onTap: () {
              setState(() {
                for (final item in notifications) {
                  item.unread = false;
                }
              });
            },
            child: const Text(
              'Mark all read',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 56,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 18),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final selected = selectedFilter == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                selectedFilter = index;
              });
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 220),
              curve: Curves.easeOut,
              padding: const EdgeInsets.symmetric(
                horizontal: 19,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.textDark
                    : AppColors.white,
                borderRadius: BorderRadius.circular(28),
                border: Border.all(
                  color: selected
                      ? AppColors.textDark
                      : AppColors.border,
                ),
                boxShadow: selected
                    ? null
                    : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.035),
                    blurRadius: 7,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: Text(
                filters[index],
                style: TextStyle(
                  color: selected
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
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;

  const _NotificationCard({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasButton = item.buttonText != null;

    return Container(
      padding: const EdgeInsets.fromLTRB(15, 15, 15, 15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xFFE8E3E1),
          width: 1,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileAvatar(item: item),

          const SizedBox(width: 13),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildTitle(),

                const SizedBox(height: 7),

                Text(
                  item.message,
                  style: TextStyle(
                    fontSize: 14,
                    height: 1.35,
                    fontStyle: item.type ==
                        NotificationType.compliment ||
                        item.type == NotificationType.message
                        ? FontStyle.italic
                        : FontStyle.normal,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 8),

                Text(
                  item.time,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                if (hasButton) ...[
                  const SizedBox(height: 10),
                  _ActionButton(
                    title: item.buttonText!,
                  ),
                ],
              ],
            ),
          ),

          if (item.unread)
            Container(
              margin: const EdgeInsets.only(
                left: 8,
                top: 5,
              ),
              width: 9,
              height: 9,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildTitle() {
    switch (item.type) {
      case NotificationType.rose:
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: '${item.name}, ${item.age} ',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              TextSpan(
                text: item.title,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        );

      case NotificationType.compliment:
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: '${item.name}, ${item.age} ',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const TextSpan(
                text: 'complimented your ',
              ),
              const TextSpan(
                text: 'About',
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );

      case NotificationType.match:
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
            children: [
              const TextSpan(
                text: 'It\'s a match with ',
              ),
              TextSpan(
                text: '${item.name}, ${item.age}',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        );

      case NotificationType.message:
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: '${item.name}, ${item.age} ',
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const TextSpan(
                text: 'sent you a message',
              ),
            ],
          ),
        );

      case NotificationType.date:
        return RichText(
          text: TextSpan(
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textDark,
              fontWeight: FontWeight.w500,
            ),
            children: [
              TextSpan(
                text: item.name,
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                ),
              ),
              const TextSpan(
                text: ' approved your date request',
              ),
            ],
          ),
        );
    }
  }
}

class _ProfileAvatar extends StatelessWidget {
  final NotificationItem item;

  const _ProfileAvatar({
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    if (item.type == NotificationType.date) {
      return Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: const Color(0xFFFFF0E5),
          borderRadius: BorderRadius.circular(18),
        ),
        child: const Icon(
          Icons.calendar_month_outlined,
          color: Color(0xFFD98953),
          size: 30,
        ),
      );
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 60,
          height: 60,
          padding: const EdgeInsets.all(2.5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: AppColors.primary,
              width: 2,
            ),
          ),
          child: ClipOval(
            child: Image.network(
              item.image,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,
              errorBuilder: (_, __, ___) {
                return Container(
                  color: const Color(0xFFE7E7E7),
                  child: const Icon(
                    Icons.person,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
        ),

        Positioned(
          right: -2,
          bottom: -1,
          child: Container(
            width: 23,
            height: 23,
            decoration: BoxDecoration(
              color: _iconBackground(),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.white,
                width: 2,
              ),
            ),
            child: Icon(
              _notificationIcon(),
              size: 13,
              color: _notificationIconColor(),
            ),
          ),
        ),
      ],
    );
  }

  Color _iconBackground() {
    switch (item.type) {
      case NotificationType.rose:
        return const Color(0xFFFFDCE5);
      case NotificationType.compliment:
        return const Color(0xFFFFE8B5);
      case NotificationType.match:
        return const Color(0xFFCFF4DF);
      case NotificationType.message:
        return const Color(0xFFFFDDE8);
      case NotificationType.date:
        return const Color(0xFFFFF0E5);
    }
  }

  IconData _notificationIcon() {
    switch (item.type) {
      case NotificationType.rose:
        return Icons.local_florist;
      case NotificationType.compliment:
        return Icons.chat_bubble_outline;
      case NotificationType.match:
        return Icons.check;
      case NotificationType.message:
        return Icons.chat_bubble_outline;
      case NotificationType.date:
        return Icons.calendar_month;
    }
  }

  Color _notificationIconColor() {
    switch (item.type) {
      case NotificationType.rose:
        return AppColors.primary;
      case NotificationType.compliment:
        return const Color(0xFFD79500);
      case NotificationType.match:
        return const Color(0xFF22A765);
      case NotificationType.message:
        return AppColors.primary;
      case NotificationType.date:
        return const Color(0xFFD98953);
    }
  }
}

class _ActionButton extends StatelessWidget {
  final String title;

  const _ActionButton({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 9,
      ),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.18),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Text(
        title,
        style: const TextStyle(
          color: AppColors.white,
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }
}

class _CircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _CircleButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 52,
        height: 52,
        decoration: BoxDecoration(
          color: AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.border,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Icon(
          icon,
          size: 20,
          color: AppColors.textDark,
        ),
      ),
    );
  }
}

enum NotificationType {
  rose,
  compliment,
  match,
  message,
  date,
}

class NotificationItem {
  final String name;
  final int? age;
  final String image;
  final String title;
  final String message;
  final String time;
  final NotificationType type;
  final String? buttonText;
  bool unread;

  NotificationItem({
    required this.name,
    required this.age,
    required this.image,
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    this.buttonText,
    required this.unread,
  });
}