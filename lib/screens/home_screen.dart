import 'package:flutter/material.dart';
import 'package:feedia/widgets/home_screen_card.dart';

import 'package:feedia/screens/main_chat_screen.dart';
import 'package:feedia/screens/therapy_chat_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _navigateToMainChatScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MainChatScreen(endpoint: 'chat-meal'),
      ),
    );
  }

  void _navigateToTherapyChatScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) => TherapyChatScreen()),
    );
  }

  void _navigateToWrapAroundChatScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (ctx) => MainChatScreen(endpoint: 'wraparound-help'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 12, 18, 1),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(3, 12, 18, 1),
        surfaceTintColor: Color.fromRGBO(3, 12, 18, 1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Hello! How can we help today?',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.orangeAccent,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(21, 30, 40, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Chat with our friendly AI assistant to find the nearest food pantry',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: _navigateToMainChatScreen,
                    child: HomeOptionCard(
                      icon: Icons.chat,
                      label: 'Chat here.',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(21, 30, 40, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Something on your mind?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: _navigateToTherapyChatScreen,
                    child: HomeOptionCard(
                      icon: Icons.people_rounded,
                      label: 'I\'m here to listen',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(21, 30, 40, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Other services - Housing, Healthcare, Financial assistance etc.',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: _navigateToWrapAroundChatScreen,
                    child: HomeOptionCard(
                      icon: Icons.health_and_safety,
                      label: 'Let\'s figute it out',
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(21, 30, 40, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Looking for recipes under a budget?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                  ),
                  SizedBox(height: 12),
                  HomeOptionCard(
                    icon: Icons.food_bank,
                    label: 'Let\'s get cooking 👨‍🍳',
                  ),
                ],
              ),
            ),
            SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Color.fromRGBO(21, 30, 40, 1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Are you eating enough to maintain your weight?',
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                  ),
                  SizedBox(height: 12),
                  HomeOptionCard(
                    icon: Icons.monitor_weight_rounded,
                    label: 'Calculate your calories 🧮',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
