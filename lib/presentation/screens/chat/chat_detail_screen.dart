import 'package:flutter/material.dart';

import 'chat_screen.dart';

class ChatDetailScreen extends StatefulWidget {
  final ChatUser user;

  const ChatDetailScreen({
    super.key,
    required this.user,
  });

  @override
  State<ChatDetailScreen> createState() =>
      _ChatDetailScreenState();
}

class _ChatDetailScreenState
    extends State<ChatDetailScreen> {
  final TextEditingController messageController =
  TextEditingController();

  final ScrollController scrollController =
  ScrollController();

  final List<ChatMessage> messages = [
    ChatMessage(
      text:
      "If you're as fun in person as your profile, I'm in.",
      isMe: true,
      time: '10:04 PM',
    ),
  ];

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F6F2),
      body: SafeArea(
        child: Column(
          children: [
            // ======================================================
            // TOP PROFILE HEADER
            // ======================================================

            _buildTopHeader(),

            // ======================================================
            // RELATIONSHIP PROGRESS
            // ======================================================

            _buildRelationshipProgress(),

            // ======================================================
            // TABS
            // ======================================================

            _buildActionTabs(),

            // ======================================================
            // CHAT AREA
            // ======================================================

            Expanded(
              child: SingleChildScrollView(
                controller: scrollController,
                physics:
                const BouncingScrollPhysics(),
                padding:
                const EdgeInsets.fromLTRB(
                  18,
                  10,
                  18,
                  20,
                ),
                child: Column(
                  children: [
                    _buildPrivacyCard(),

                    const SizedBox(height: 17),

                    const Text(
                      'TODAY',
                      style: TextStyle(
                        color: Color(0xFF9B9696),
                        fontSize: 12,
                        fontWeight:
                        FontWeight.w700,
                        letterSpacing: 1.3,
                      ),
                    ),

                    const SizedBox(height: 13),

                    _buildReactionText(),

                    const SizedBox(height: 8),

                    ...messages.map(
                          (message) =>
                          _buildMessage(message),
                    ),

                    const SizedBox(height: 18),

                    _buildRoseCard(),
                  ],
                ),
              ),
            ),

            // ======================================================
            // MESSAGE INPUT
            // ======================================================

            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // TOP HEADER
  // ==============================================================

  Widget _buildTopHeader() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        16,
        10,
        12,
        10,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: _circleButton(
              Icons.arrow_back_ios_new,
            ),
          ),

          const SizedBox(width: 10),

          // PROFILE IMAGE
          Stack(
            children: [
              Container(
                width: 58,
                height: 58,
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color:
                    const Color(0xFFE95075),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    widget.user.image,
                    fit: BoxFit.cover,
                    errorBuilder:
                        (_, __, ___) =>
                    const Icon(
                      Icons.person,
                    ),
                  ),
                ),
              ),
              Positioned(
                right: 1,
                bottom: 1,
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: BoxDecoration(
                    color:
                    const Color(0xFF35C779),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(width: 10),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${widget.user.name}, ${widget.user.age}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),

                    const SizedBox(width: 6),

                    Container(
                      padding:
                      const EdgeInsets
                          .symmetric(
                        horizontal: 7,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color:
                        const Color(0xFF26221D),
                        borderRadius:
                        BorderRadius.circular(
                          7,
                        ),
                      ),
                      child: const Text(
                        'PLATINUM',
                        style: TextStyle(
                          color:
                          Color(0xFFFFD66B),
                          fontSize: 8,
                          fontWeight:
                          FontWeight.w800,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 4),

                const Row(
                  children: [
                    Icon(
                      Icons.circle,
                      color:
                      Color(0xFF35C779),
                      size: 8,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Online',
                      style: TextStyle(
                        color:
                        Color(0xFF35B878),
                        fontSize: 14,
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          _circleAction(
            Icons.call_outlined,
          ),

          const SizedBox(width: 7),

          _circleAction(
            Icons.videocam_outlined,
          ),

          const SizedBox(width: 7),

          const Icon(
            Icons.more_vert,
            size: 27,
            color: Color(0xFF333333),
          ),
        ],
      ),
    );
  }

  Widget _circleButton(IconData icon) {
    return Container(
      width: 46,
      height: 46,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 19,
        color: Color(0xFF222222),
      ),
    );
  }

  Widget _circleAction(IconData icon) {
    return Container(
      width: 43,
      height: 43,
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8FA),
        shape: BoxShape.circle,
        border: Border.all(
          color: const Color(0xFFFFE0E7),
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        size: 20,
        color: const Color(0xFFD85574),
      ),
    );
  }

  // ==============================================================
  // RELATIONSHIP PROGRESS
  // ==============================================================

  Widget _buildRelationshipProgress() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'RELATIONSHIP PROGRESS',
                style: TextStyle(
                  color: Color(0xFF969090),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.3,
                ),
              ),
              const Spacer(),
              const Text(
                'LEVEL 5',
                style: TextStyle(
                  color: Color(0xFFD55372),
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),

          const SizedBox(height: 10),

          ClipRRect(
            borderRadius:
            BorderRadius.circular(10),
            child:
            const LinearProgressIndicator(
              value: 0.72,
              minHeight: 7,
              backgroundColor:
              Color(0xFFEFE7E9),
              valueColor:
              AlwaysStoppedAnimation(
                Color(0xFFE95075),
              ),
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              const Icon(
                Icons.check_circle_outline,
                size: 16,
                color: Color(0xFFE0B94D),
              ),
              const SizedBox(width: 5),
              const Text(
                'Milestone reached: ',
                style: TextStyle(
                  color: Color(0xFF999292),
                  fontSize: 12,
                ),
              ),
              const Text(
                'Premium Badge unlocked',
                style: TextStyle(
                  color: Color(0xFFC85470),
                  fontSize: 12,
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // ACTION TABS
  // ==============================================================

  Widget _buildActionTabs() {
    return Container(
      margin: const EdgeInsets.only(
        top: 14,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 8,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(
            color: Color(0xFFEDE9E7),
          ),
          bottom: BorderSide(
            color: Color(0xFFEDE9E7),
          ),
        ),
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            _actionTab(
              icon: Icons.card_giftcard,
              text: 'Gifts',
              count: '12',
              selected: true,
            ),

            _actionTab(
              icon: Icons.chat_bubble_outline,
              text: 'Compliments',
            ),

            _actionTab(
              icon: Icons.calendar_month_outlined,
              text: 'Date Invites',
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionTab({
    required IconData icon,
    required String text,
    String? count,
    bool selected = false,
  }) {
    return Container(
      margin: const EdgeInsets.only(
        right: 10,
      ),
      padding:
      const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 11,
      ),
      decoration: BoxDecoration(
        color: selected
            ? const Color(0xFFE95075)
            : Colors.white,
        borderRadius:
        BorderRadius.circular(25),
        border: Border.all(
          color: selected
              ? const Color(0xFFE95075)
              : const Color(0xFFE4E0DE),
        ),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: selected
                ? Colors.white
                : const Color(0xFF555555),
          ),
          const SizedBox(width: 6),
          Text(
            text,
            style: TextStyle(
              color: selected
                  ? Colors.white
                  : const Color(0xFF444444),
              fontSize: 14,
              fontWeight:
              FontWeight.w600,
            ),
          ),
          if (count != null) ...[
            const SizedBox(width: 5),
            Container(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 7,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: Colors.white
                    .withOpacity(
                  0.25,
                ),
                borderRadius:
                BorderRadius.circular(
                  10,
                ),
              ),
              child: Text(
                count,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight:
                  FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  // ==============================================================
  // PRIVACY CARD
  // ==============================================================

  Widget _buildPrivacyCard() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF9FB),
        borderRadius:
        BorderRadius.circular(18),
        border: Border.all(
          color: const Color(0xFFFFDCE5),
        ),
      ),
      child: const Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.shield_outlined,
            color: Color(0xFF8D9294),
            size: 19,
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              'Meet at the venue · your exact location stays private. Have a great date!',
              style: TextStyle(
                color: Color(0xFF777373),
                fontSize: 12,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // REACTION TEXT
  // ==============================================================

  Widget _buildReactionText() {
    return const Text(
      "You reacted to Aanya's About",
      style: TextStyle(
        color: Color(0xFF999494),
        fontSize: 12,
      ),
    );
  }

  // ==============================================================
  // MESSAGE
  // ==============================================================

  Widget _buildMessage(
      ChatMessage message,
      ) {
    return Align(
      alignment: message.isMe
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        constraints: const BoxConstraints(
          maxWidth: 310,
        ),
        margin: const EdgeInsets.only(
          top: 8,
        ),
        padding: const EdgeInsets.fromLTRB(
          17,
          15,
          14,
          11,
        ),
        decoration: BoxDecoration(
          color: message.isMe
              ? const Color(0xFFE95075)
              : Colors.white,
          borderRadius:
          BorderRadius.only(
            topLeft:
            const Radius.circular(21),
            topRight:
            const Radius.circular(21),
            bottomLeft:
            Radius.circular(
              message.isMe ? 21 : 5,
            ),
            bottomRight:
            Radius.circular(
              message.isMe ? 5 : 21,
            ),
          ),
        ),
        child: Column(
          crossAxisAlignment:
          CrossAxisAlignment.end,
          children: [
            Align(
              alignment:
              Alignment.centerLeft,
              child: Text(
                message.text,
                style: TextStyle(
                  color: message.isMe
                      ? Colors.white
                      : const Color(
                    0xFF333333,
                  ),
                  fontSize: 16,
                  height: 1.4,
                ),
              ),
            ),

            const SizedBox(height: 5),

            Text(
              '${message.time}  ✓✓',
              style: TextStyle(
                color: message.isMe
                    ? Colors.white70
                    : Colors.grey,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ==============================================================
  // ROSE CARD
  // ==============================================================

  Widget _buildRoseCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius:
        BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.05,
            ),
            blurRadius: 12,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          Container(
            width: 57,
            height: 57,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEFF3),
              borderRadius:
              BorderRadius.circular(17),
            ),
            alignment: Alignment.center,
            child: const Text(
              '🌹',
              style: TextStyle(
                fontSize: 27,
              ),
            ),
          ),

          const SizedBox(width: 12),

          const Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      'Rose',
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),
                    Spacer(),
                    Text(
                      'SENT',
                      style: TextStyle(
                        color:
                        Color(0xFFD87A91),
                        fontSize: 11,
                        fontWeight:
                        FontWeight.w800,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3),

                Text(
                  '🪙 10 coins',
                  style: TextStyle(
                    color: Color(0xFFC09A32),
                    fontSize: 13,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                SizedBox(height: 9),

                Text(
                  '“A little something to brighten your day 🌹”',
                  style: TextStyle(
                    color: Color(0xFF777777),
                    fontSize: 12,
                    fontStyle:
                    FontStyle.italic,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ==============================================================
  // MESSAGE INPUT
  // ==============================================================

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        12,
        10,
        12,
        12,
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF7F6F2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(
              0.06,
            ),
            blurRadius: 15,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          _inputCircle(
            Icons.add,
          ),

          const SizedBox(width: 8),

          _inputCircle(
            Icons.image_outlined,
          ),

          const SizedBox(width: 9),

          Expanded(
            child: Container(
              height: 52,
              padding:
              const EdgeInsets.symmetric(
                horizontal: 17,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                BorderRadius.circular(27),
                border: Border.all(
                  color: const Color(
                    0xFFE3DFDD,
                  ),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller:
                      messageController,
                      textInputAction:
                      TextInputAction.send,
                      onSubmitted: (_) {
                        _sendMessage();
                      },
                      decoration:
                      const InputDecoration(
                        hintText:
                        'Message Aanya...',
                        hintStyle: TextStyle(
                          color:
                          Color(0xFF999999),
                          fontSize: 15,
                        ),
                        border:
                        InputBorder.none,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.mic_none,
                    color: Color(0xFF999999),
                    size: 21,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(width: 8),

          GestureDetector(
            onTap: _sendMessage,
            child: Container(
              width: 53,
              height: 53,
              decoration: BoxDecoration(
                color:
                const Color(0xFFE95075),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color:
                    const Color(0xFFE95075)
                        .withOpacity(
                      0.25,
                    ),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: const Icon(
                Icons.send,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _inputCircle(IconData icon) {
    return Container(
      width: 48,
      height: 48,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Icon(
        icon,
        color: const Color(0xFF555555),
        size: 21,
      ),
    );
  }

  // ==============================================================
  // SEND MESSAGE
  // ==============================================================

  void _sendMessage() {
    final text =
    messageController.text.trim();

    if (text.isEmpty) return;

    setState(() {
      messages.add(
        ChatMessage(
          text: text,
          isMe: true,
          time: 'Now',
        ),
      );

      messageController.clear();
    });

    Future.delayed(
      const Duration(milliseconds: 100),
          () {
        if (scrollController.hasClients) {
          scrollController.animateTo(
            scrollController.position
                .maxScrollExtent,
            duration:
            const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      },
    );
  }
}

// ================================================================
// MESSAGE MODEL
// ================================================================

class ChatMessage {
  final String text;
  final bool isMe;
  final String time;

  ChatMessage({
    required this.text,
    required this.isMe,
    required this.time,
  });
}