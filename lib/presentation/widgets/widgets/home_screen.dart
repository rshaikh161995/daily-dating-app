import 'package:flutter/material.dart';

import '../../screens/admirers/admirers_screen.dart' show AdmirersScreen;
import '../../screens/chat/chat_screen.dart' show ChatScreen;
import '../../screens/date_now/date_now_screen.dart';
import '../../screens/events/events_screen.dart' show EventsScreen;
import '../../screens/home/home_content.dart' show HomeContent;
import '../../widgets/widgets/profile_card.dart';
import 'home_bottom_navigation.dart';
import 'home_header.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final PageController pageController = PageController();

  final List<Widget> screens = const [
    HomeContent(),
    DateNowScreen(),
    AdmirersScreen(),
    ChatScreen(),
    EventsScreen(),
    // ChatScreen(),
    // EventsScreen(),
  ];

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1EFEC),

      body: IndexedStack(
        index: currentIndex,
        children: screens,
      ),

      bottomNavigationBar: HomeBottomNavigation(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
    );
  }
}

