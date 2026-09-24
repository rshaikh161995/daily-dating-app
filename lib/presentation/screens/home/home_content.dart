import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/models/user_model.dart';
import '../../bloc/home/home_bloc.dart';
import '../../bloc/home/home_event.dart';
import '../../bloc/home/home_state.dart';
import '../../widgets/widgets/home_header.dart';
import '../../widgets/widgets/profile_card.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  // ============================================================
  // CONTROLLERS
  // ============================================================

  late PageController pageController;

  final TextEditingController complimentController =
  TextEditingController();

  // ============================================================
  // VARIABLES
  // ============================================================

  int selectedIndex = 0;

  int roseBalance = 5567;

  bool isLiked = false;

  String selectedComplimentType = 'Sweet';

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      viewportFraction: 0.88,
    );
  }

  @override
  void dispose() {
    pageController.dispose();
    complimentController.dispose();
    super.dispose();
  }

  // ============================================================
  // BUILD
  // ============================================================

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          // ------------------------------------------------------
          // HEADER
          // ------------------------------------------------------

          const HomeHeader(),

          const SizedBox(height: 6),

          // ------------------------------------------------------
          // CONTENT
          // ------------------------------------------------------

          Expanded(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (context, state) {
                // ==================================================
                // LOADING
                // ==================================================

                if (state.status == HomeStatus.loading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                // ==================================================
                // ERROR
                // ==================================================

                if (state.status == HomeStatus.failure) {
                  return _errorView(context);
                }

                // ==================================================
                // EMPTY
                // ==================================================

                if (state.users.isEmpty) {
                  return RefreshIndicator(
                    onRefresh: _refreshUsers,
                    child: ListView(
                      physics:
                      const AlwaysScrollableScrollPhysics(),
                      children: const [
                        SizedBox(height: 250),
                        Center(
                          child: Text(
                            'No users found',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }

                // ==================================================
                // USERS
                // ==================================================

                final List<UserModel> users = state.users;

                // Safety
                if (selectedIndex >= users.length) {
                  selectedIndex = 0;
                }

                final UserModel selectedUser =
                users[selectedIndex];

                // ==================================================
                // VERTICAL SCROLL
                // ==================================================

                return RefreshIndicator(
                  onRefresh: _refreshUsers,
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),

                        // ==================================================
                        // HORIZONTAL PROFILE CARDS
                        // ==================================================

                        SizedBox(
                          height: 600,
                          child: PageView.builder(
                            controller: pageController,
                            scrollDirection: Axis.horizontal,
                            itemCount: users.length,
                            physics:
                            const BouncingScrollPhysics(),

                            onPageChanged: (index) {
                              setState(() {
                                selectedIndex = index;
                                isLiked = false;
                              });
                            },

                            itemBuilder: (context, index) {
                              final UserModel user =
                              users[index];

                              return AnimatedBuilder(
                                animation: pageController,

                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(
                                    horizontal: 5,
                                  ),
                                  child: Stack(
                                    children: [
                                      // ====================================
                                      // PROFILE CARD
                                      // ====================================

                                      Positioned.fill(
                                        child: ProfileCard(
                                          imageUrl: user.image,
                                          name: user.firstName,
                                          age: user.age,
                                          location:
                                          user.city,
                                          profession:
                                          'Designer',
                                          height: '5\'6"',
                                          relationship:
                                          'Looking for relationship',
                                          gender:user.gender,
                                          state:user.state,
                                          country:user.country,
                                        ),
                                      ),

                                      // ====================================
                                      // COMPLIMENT BUTTON
                                      // ====================================

                                      Positioned(
                                        right: 18,
                                        bottom: 24,
                                        child:
                                        _complimentButton(
                                          user,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                // ==========================================
                                // 3D ANIMATION
                                // ==========================================

                                builder:
                                    (context, child) {
                                  double page = 0;

                                  if (pageController
                                      .hasClients &&
                                      pageController
                                          .position
                                          .haveDimensions) {
                                    page =
                                        pageController.page ??
                                            0;
                                  }

                                  final double difference =
                                      index - page;

                                  // Horizontal rotation
                                  final double rotation =
                                      difference * 0.10;

                                  // Card scale
                                  final double scale =
                                  (1 -
                                      difference
                                          .abs() *
                                          0.10)
                                      .clamp(0.86, 1.0);

                                  // Small vertical movement
                                  final double verticalOffset =
                                      difference.abs() * 8;

                                  return Transform.translate(
                                    offset: Offset(
                                      0,
                                      verticalOffset,
                                    ),
                                    child: Transform(
                                      alignment:
                                      Alignment.center,
                                      transform:
                                      Matrix4.identity()
                                        ..setEntry(
                                          3,
                                          2,
                                          0.0015,
                                        )
                                        ..rotateY(
                                          rotation,
                                        )
                                        ..scale(scale),
                                      child: child,
                                    ),
                                  );
                                },
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 12),

                        // ==================================================
                        // PAGE COUNTER
                        // ==================================================

                        Center(
                          child: Container(
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 13,
                              vertical: 7,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                              BorderRadius.circular(20),
                            ),
                            child: Text(
                              '${selectedIndex + 1} / ${users.length}',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 28),

                        // ==================================================
                        // ABOUT
                        // ==================================================

                        // ==================================================
// ABOUT
// ==================================================

                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              const Text(
                                'About',
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.w800,
                                  letterSpacing: -0.3,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // ABOUT TEXT
                              Container(
                                width: double.infinity,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(22),
                                ),
                                child: Text(
                                  'I am ${selectedUser.firstName}, '
                                      'looking to meet someone genuine and interesting. '
                                      'I enjoy good conversations, exploring new places '
                                      'and spending quality time with people I care about.',
                                  style: TextStyle(
                                    fontSize: 15,
                                    height: 1.55,
                                    color: Colors.grey.shade700,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 28),

                              // THE BASICS TITLE
                              const Text(
                                'THE BASICS',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFCE6680),
                                  letterSpacing: 1.8,
                                ),
                              ),

                              const SizedBox(height: 12),

                              // BASICS CARD
                              _profileDetails(selectedUser),
                            ],
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // COMPLEMENTING
                        // ==================================================

                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Send a compliment',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(height: 14),

                        Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 20),
                          child: _complimentPreview(
                            selectedUser,
                          ),
                        ),

                        const SizedBox(height: 30),

                        // ==================================================
                        // PEOPLE YOU MAY LIKE
                        // ==================================================

                        const Padding(
                          padding:
                          EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'People you may like',
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),

                        const SizedBox(height: 15),

                        SizedBox(
                          height: 125,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            physics:
                            const BouncingScrollPhysics(),
                            padding:
                            const EdgeInsets.symmetric(
                              horizontal: 20,
                            ),
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              final UserModel user =
                              users[index];

                              return GestureDetector(
                                onTap: () {
                                  pageController.animateToPage(
                                    index,
                                    duration:
                                    const Duration(
                                      milliseconds: 500,
                                    ),
                                    curve:
                                    Curves.easeOutCubic,
                                  );
                                },
                                child: Container(
                                  width: 100,
                                  margin:
                                  const EdgeInsets.only(
                                    right: 14,
                                  ),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          CircleAvatar(
                                            radius: 40,
                                            backgroundColor:
                                            Colors.grey
                                                .shade200,
                                            backgroundImage:
                                            NetworkImage(
                                              user.image,
                                            ),
                                          ),

                                          // ONLINE DOT
                                          Positioned(
                                            right: 1,
                                            bottom: 1,
                                            child: Container(
                                              width: 16,
                                              height: 16,
                                              decoration:
                                              BoxDecoration(
                                                color:
                                                Colors.green,
                                                shape:
                                                BoxShape
                                                    .circle,
                                                border:
                                                Border.all(
                                                  color:
                                                  Colors.white,
                                                  width: 2,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                      const SizedBox(height: 7),

                                      Text(
                                        user.firstName,
                                        maxLines: 1,
                                        overflow:
                                        TextOverflow
                                            .ellipsis,
                                        textAlign:
                                        TextAlign.center,
                                        style:
                                        const TextStyle(
                                          fontWeight:
                                          FontWeight.w600,
                                          fontSize: 13,
                                        ),
                                      ),

                                      const SizedBox(height: 2),

                                      Text(
                                        '${user.age}',
                                        style:
                                        const TextStyle(
                                          color: Colors.grey,
                                          fontSize: 11,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),

                        const SizedBox(height: 35),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // ERROR VIEW
  // ============================================================

  Widget _errorView(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _refreshUsers,
      child: ListView(
        physics:
        const AlwaysScrollableScrollPhysics(),
        children: [
          const SizedBox(height: 200),

          const Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.redAccent,
          ),

          const SizedBox(height: 15),

          const Center(
            child: Text(
              'Something went wrong',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          const SizedBox(height: 15),

          Center(
            child: ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(
                  FetchUsers(),
                );
              },
              child: const Text('Retry'),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // REFRESH API
  // ============================================================

  Future<void> _refreshUsers() async {
    context.read<HomeBloc>().add(
      RefreshUsers(),
    );

    // Give Bloc time to make API request.
    await Future.delayed(
      const Duration(milliseconds: 500),
    );
  }

  // ============================================================
  // PROFILE DETAILS
  // ============================================================

  Widget _profileDetails(UserModel user) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: 18,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 18,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        children: [

          // AGE
          _basicDetailRow(
            icon: Icons.cake_outlined,
            title: 'Age',
            value: '${user.age} years old',
          ),

          _basicDivider(),

          // HEIGHT
          _basicDetailRow(
            icon: Icons.straighten_outlined,
            title: 'Height',
            value: '5\'6" (168 cm)',
          ),

          _basicDivider(),

          // LIVES IN
          _basicDetailRow(
            icon: Icons.location_on_outlined,
            title: 'Lives in',
            value: user.city,
            subtitle: user.state,
          ),

          _basicDivider(),

          // GENDER
          _basicDetailRow(
            icon: Icons.person_outline,
            title: 'Gender',
            value: _capitalize(user.gender),
          ),

          _basicDivider(),

          // COUNTRY
          _basicDetailRow(
            icon: Icons.public_outlined,
            title: 'Country',
            value: user.country,
          ),

          _basicDivider(),

          // STATE
          _basicDetailRow(
            icon: Icons.map_outlined,
            title: 'State',
            value: user.state,
          ),

        ],
      ),
    );
  }
  Widget _basicDivider() {
    return Divider(
      height: 1,
      thickness: 0.7,
      color: Colors.grey.shade200,
    );
  }
  Widget _basicDetailRow({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          // ICON
          SizedBox(
            width: 38,
            child: Icon(
              icon,
              size: 24,
              color: const Color(0xFFCC6680),
            ),
          ),

          const SizedBox(width: 10),

          // TITLE
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade700,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),

          const SizedBox(width: 12),

          // VALUE
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Text(
                  value,
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF292929),
                  ),
                ),

                if (subtitle != null &&
                    subtitle.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
  // ============================================================
  // DETAIL ROW
  // ============================================================

  Widget _detailRow(
      String title,
      String value,
      ) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 9,
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(width: 15),

          Flexible(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ============================================================
  // COMPLIMENT PREVIEW
  // ============================================================

  Widget _complimentPreview(UserModel user) {
    return GestureDetector(
      onTap: () {
        _openComplimentDialog(user);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(22),
        ),
        child: Row(
          children: [
            Container(
              width: 55,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFFCE5EB),
                borderRadius:
                BorderRadius.circular(17),
              ),
              child: const Center(
                child: Text(
                  '💬',
                  style: TextStyle(
                    fontSize: 27,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Give a compliment',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    'Make ${user.firstName} smile 🌹',
                    style: const TextStyle(
                      fontSize: 13,
                      color: Colors.grey,
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
      ),
    );
  }

  // ============================================================
  // ROSE BUTTON ON PROFILE CARD
  // ============================================================

  Widget _complimentButton(UserModel user) {
    return GestureDetector(
      onTap: () {
        _openComplimentDialog(user);
      },
      child: Container(
        width: 58,
        height: 58,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              blurRadius: 13,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: const Center(
          child: Text(
            '🌹',
            style: TextStyle(
              fontSize: 27,
            ),
          ),
        ),
      ),
    );
  }

  // ============================================================
  // COMPLIMENT BOTTOM SHEET
  // ============================================================

  void _openComplimentDialog(UserModel user) {
    complimentController.clear();

    selectedComplimentType = 'Sweet';
    isLiked = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomContext) {
        return StatefulBuilder(
          builder: (
              modalContext,
              setModalState,
              ) {
            return Container(
              height:
              MediaQuery.of(context).size.height *
                  0.92,
              decoration: const BoxDecoration(
                color: Color(0xFFF7F5F2),
                borderRadius:
                BorderRadius.vertical(
                  top: Radius.circular(28),
                ),
              ),
              child: SafeArea(
                child: Column(
                  children: [
                    // ==================================================
                    // HEADER
                    // ==================================================

                    Container(
                      padding:
                      const EdgeInsets.fromLTRB(
                        16,
                        12,
                        16,
                        20,
                      ),
                      decoration:
                      const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFFDE8F2),
                            Color(0xFFEFF1FF),
                          ],
                        ),
                        borderRadius:
                        BorderRadius.vertical(
                          top: Radius.circular(28),
                        ),
                      ),
                      child: Column(
                        children: [
                          // Drag handle
                          Container(
                            width: 42,
                            height: 5,
                            decoration:
                            BoxDecoration(
                              color:
                              Colors.grey.shade400,
                              borderRadius:
                              BorderRadius.circular(
                                10,
                              ),
                            ),
                          ),

                          const SizedBox(height: 14),

                          // Back + balance
                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(
                                    modalContext,
                                  );
                                },
                                child: Container(
                                  width: 45,
                                  height: 45,
                                  decoration:
                                  const BoxDecoration(
                                    color: Colors.white,
                                    shape:
                                    BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons
                                        .arrow_back_ios_new,
                                    size: 19,
                                  ),
                                ),
                              ),

                              const Spacer(),

                              // Rose balance
                              Container(
                                padding:
                                const EdgeInsets
                                    .symmetric(
                                  horizontal: 13,
                                  vertical: 9,
                                ),
                                decoration:
                                BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                  BorderRadius
                                      .circular(
                                    20,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    const Text(
                                      '🌹',
                                      style:
                                      TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '$roseBalance',
                                      style:
                                      const TextStyle(
                                        fontWeight:
                                        FontWeight
                                            .w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 12),

                          const Text(
                            '💬',
                            style: TextStyle(
                              fontSize: 52,
                            ),
                          ),

                          const SizedBox(height: 3),

                          const Text(
                            'Compliment Ideas',
                            style: TextStyle(
                              fontSize: 27,
                              fontWeight:
                              FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 5),

                          const Text(
                            'pick one to make a great first impression',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // ==================================================
                    // BODY
                    // ==================================================

                    Expanded(
                      child: SingleChildScrollView(
                        physics:
                        const BouncingScrollPhysics(),
                        padding:
                        const EdgeInsets.fromLTRB(
                          16,
                          15,
                          16,
                          25,
                        ),
                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            // ==================================================
                            // CATEGORY CHIPS
                            // ==================================================

                            SizedBox(
                              height: 48,
                              child: ListView(
                                scrollDirection:
                                Axis.horizontal,
                                physics:
                                const BouncingScrollPhysics(),
                                children: [
                                  _complimentTypeChip(
                                    'Sweet',
                                    setModalState,
                                  ),
                                  _complimentTypeChip(
                                    'Playful',
                                    setModalState,
                                  ),
                                  _complimentTypeChip(
                                    'Admiring',
                                    setModalState,
                                  ),
                                  _complimentTypeChip(
                                    'Flirty',
                                    setModalState,
                                  ),
                                  _complimentTypeChip(
                                    'Funny',
                                    setModalState,
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 15),

                            // ==================================================
                            // IDEAS
                            // ==================================================

                            ..._getComplimentIdeas(
                              selectedComplimentType,
                            ).map(
                                  (comment) {
                                return _complimentIdeaCard(
                                  comment,
                                  setModalState,
                                );
                              },
                            ),

                            const SizedBox(height: 8),

                            // ==================================================
                            // WRITE YOUR OWN
                            // ==================================================

                            const Text(
                              'Write your own',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),

                            const SizedBox(height: 10),

                            Container(
                              decoration:
                              BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                BorderRadius.circular(
                                  18,
                                ),
                                border: Border.all(
                                  color:
                                  Colors.grey.shade200,
                                ),
                              ),
                              child: TextField(
                                controller:
                                complimentController,

                                // MAX 3 LINES
                                maxLines: 3,
                                minLines: 1,

                                maxLength: 180,

                                textInputAction:
                                TextInputAction
                                    .newline,

                                decoration:
                                const InputDecoration(
                                  hintText:
                                  'Write a nice compliment...',
                                  hintStyle: TextStyle(
                                    color: Colors.grey,
                                  ),
                                  border:
                                  InputBorder.none,
                                  contentPadding:
                                  EdgeInsets.all(
                                    16,
                                  ),
                                  counterText: '',
                                ),
                              ),
                            ),

                            const SizedBox(height: 15),

                            // ==================================================
                            // ROSE + LIKE + SEND
                            // ==================================================

                            Row(
                              children: [
                                // ROSE BALANCE
                                Container(
                                  padding:
                                  const EdgeInsets
                                      .symmetric(
                                    horizontal: 13,
                                    vertical: 11,
                                  ),
                                  decoration:
                                  BoxDecoration(
                                    color: Colors.white,
                                    borderRadius:
                                    BorderRadius
                                        .circular(
                                      16,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      const Text(
                                        '🌹',
                                        style:
                                        TextStyle(
                                          fontSize: 21,
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        '$roseBalance',
                                        style:
                                        const TextStyle(
                                          fontWeight:
                                          FontWeight
                                              .w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // LIKE
                                GestureDetector(
                                  onTap: () {
                                    setModalState(() {
                                      isLiked =
                                      !isLiked;
                                    });
                                  },
                                  child: Container(
                                    width: 48,
                                    height: 48,
                                    decoration:
                                    BoxDecoration(
                                      color: isLiked
                                          ? const Color(
                                        0xFFFCE5EB,
                                      )
                                          : Colors.white,
                                      shape:
                                      BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isLiked
                                          ? Icons.favorite
                                          : Icons
                                          .favorite_border,
                                      color:
                                      const Color(
                                        0xFFE84F78,
                                      ),
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                // SEND
                                Expanded(
                                  child: SizedBox(
                                    height: 48,
                                    child:
                                    ElevatedButton(
                                      onPressed: () {
                                        _sendCompliment(
                                          modalContext,
                                          user,
                                        );
                                      },
                                      style:
                                      ElevatedButton
                                          .styleFrom(
                                        backgroundColor:
                                        const Color(
                                          0xFFE84F78,
                                        ),
                                        foregroundColor:
                                        Colors.white,
                                        elevation: 0,
                                        shape:
                                        RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius
                                              .circular(
                                            16,
                                          ),
                                        ),
                                      ),
                                      child: const Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment
                                            .center,
                                        children: [
                                          Text(
                                            'Send Compliment',
                                            style:
                                            TextStyle(
                                              fontWeight:
                                              FontWeight
                                                  .w700,
                                            ),
                                          ),
                                          SizedBox(
                                              width: 6),
                                          Icon(
                                            Icons.send,
                                            size: 18,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 10),

                            Center(
                              child: Text(
                                '🌹 1 rose will be used',
                                style: TextStyle(
                                  color: Colors
                                      .grey.shade600,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  // ============================================================
  // COMPLIMENT CATEGORY CHIP
  // ============================================================

  Widget _complimentTypeChip(
      String title,
      StateSetter setModalState,
      ) {
    final bool selected =
        selectedComplimentType == title;

    return GestureDetector(
      onTap: () {
        setModalState(() {
          selectedComplimentType = title;
          complimentController.clear();
        });
      },
      child: Container(
        margin:
        const EdgeInsets.only(right: 10),
        padding:
        const EdgeInsets.symmetric(
          horizontal: 20,
        ),
        decoration: BoxDecoration(
          color: selected
              ? const Color(0xFFE84F78)
              : const Color(0xFFFFFAF5),
          borderRadius:
          BorderRadius.circular(25),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: TextStyle(
            color: selected
                ? Colors.white
                : const Color(0xFF333333),
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
      ),
    );
  }

  // ============================================================
  // COMPLIMENT IDEA CARD
  // ============================================================

  Widget _complimentIdeaCard(
      String text,
      StateSetter setModalState,
      ) {
    final bool isSelected =
        complimentController.text == text;

    return GestureDetector(
      onTap: () {
        setModalState(() {
          complimentController.text = text;

          // Move cursor to end
          complimentController.selection =
              TextSelection.fromPosition(
                TextPosition(
                  offset:
                  complimentController.text.length,
                ),
              );
        });
      },
      child: AnimatedContainer(
        duration:
        const Duration(milliseconds: 180),
        width: double.infinity,
        margin:
        const EdgeInsets.only(bottom: 12),
        padding:
        const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 19,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius:
          BorderRadius.circular(18),
          border: Border.all(
            color: isSelected
                ? const Color(0xFFE84F78)
                : const Color(0xFFE9E5E2),
            width: isSelected ? 1.5 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color:
              Colors.black.withOpacity(0.025),
              blurRadius: 5,
            ),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.35,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            const SizedBox(width: 8),

            if (isSelected)
              const Icon(
                Icons.check_circle,
                color: Color(0xFFE84F78),
                size: 21,
              ),
          ],
        ),
      ),
    );
  }

  // ============================================================
  // COMPLIMENT IDEAS
  // ============================================================

  List<String> _getComplimentIdeas(
      String type,
      ) {
    switch (type) {
      case 'Playful':
        return [
          'You look like trouble — the good kind 😏',
          'Okay, your profile definitely caught my attention 👀',
          'I have a feeling you are way too much fun.',
          'Should I say hi or pretend I was playing it cool? 😄',
          'You seem like someone I would never get bored with.',
        ];

      case 'Admiring':
        return [
          'You have such a beautiful smile.',
          'Your profile has such a lovely vibe.',
          'You really stand out from the crowd.',
          'There is something genuinely charming about you.',
          'Your style is seriously impressive ✨',
        ];

      case 'Flirty':
        return [
          'Not gonna lie, you stopped my scroll 😍',
          'You’re trouble, I can already tell — the good kind.',
          'If you’re as fun in person as your profile, I’m in.',
          'I think we’d make a dangerously good team ☕➡️🍷',
          'You’ve got a vibe I can’t quite look away from.',
          'Coffee, you, and good conversation — when’s good for you?',
        ];

      case 'Funny':
        return [
          'I was going to think of something clever, but then I saw your profile 😂',
          'Okay, I blame you for making me stop scrolling.',
          'Important question: coffee or pizza first? 😄',
          'I promise my opening line gets better after coffee.',
          'Is being this photogenic actually legal? 😅',
        ];

      case 'Sweet':
      default:
        return [
          'You have such a beautiful smile 😊',
          'Your profile made me smile.',
          'You seem like a really lovely person.',
          'I really like your vibe ❤️',
          'You look genuinely wonderful.',
          'I had to say hello after seeing your profile.',
        ];
    }
  }

  // ============================================================
  // SEND COMPLIMENT
  // ============================================================

  void _sendCompliment(
      BuildContext modalContext,
      UserModel user,
      ) {
    final String text =
    complimentController.text.trim();

    // Empty
    if (text.isEmpty) {
      _showMessage(
        'Please select or write a compliment first.',
      );
      return;
    }

    // Rose balance
    if (roseBalance <= 0) {
      _showMessage(
        'You do not have enough roses.',
      );
      return;
    }

    // Deduct one rose
    setState(() {
      roseBalance--;
    });

    // Close bottom sheet
    Navigator.pop(modalContext);

    // Clear
    complimentController.clear();

    // Success
    _showMessage(
      'Compliment sent to ${user.firstName} 🌹',
    );
  }

  // ============================================================
  // MESSAGE
  // ============================================================

  void _showMessage(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          behavior:
          SnackBarBehavior.floating,
          shape:
          RoundedRectangleBorder(
            borderRadius:
            BorderRadius.circular(15),
          ),
          content: Text(message),
        ),
      );
  }

  // ============================================================
  // CAPITALIZE
  // ============================================================

  String _capitalize(String value) {
    if (value.isEmpty) {
      return value;
    }

    return value[0].toUpperCase() +
        value.substring(1);
  }
}