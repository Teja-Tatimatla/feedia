import 'package:flutter/material.dart';
import 'package:feedia/widgets/home_screen_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
        builder:
            (ctx) => MainChatScreen(
              endpoint: 'chat-meal',
              localeCode: Localizations.localeOf(context).languageCode,
            ),
      ),
    );
  }

  void _navigateToTherapyChatScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => TherapyChatScreen(
              localeCode: Localizations.localeOf(context).languageCode,
            ),
      ),
    );
  }

  void _navigateToWrapAroundChatScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (ctx) => MainChatScreen(
              endpoint: 'wraparound-help',
              localeCode: Localizations.localeOf(context).languageCode,
            ),
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
            Text(
              AppLocalizations.of(context)!.greeting,
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
                    AppLocalizations.of(context)!.chatPrompt,
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
                      label: AppLocalizations.of(context)!.chatHere,
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
                    AppLocalizations.of(context)!.somethingOnMind,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: _navigateToTherapyChatScreen,
                    child: HomeOptionCard(
                      icon: Icons.people_rounded,
                      label: AppLocalizations.of(context)!.hereToListen,
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
                    AppLocalizations.of(context)!.otherServices,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: 12),
                  InkWell(
                    onTap: _navigateToWrapAroundChatScreen,
                    child: HomeOptionCard(
                      icon: Icons.health_and_safety,
                      label: AppLocalizations.of(context)!.letsFigureItOut,
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
                    AppLocalizations.of(context)!.budgetRecipes,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: 12),
                  HomeOptionCard(
                    icon: Icons.food_bank,
                    label: AppLocalizations.of(context)!.letsCook,
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
                    AppLocalizations.of(context)!.maintainWeight,
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                    softWrap: true,
                    overflow: TextOverflow.visible,
                  ),
                  SizedBox(height: 12),
                  HomeOptionCard(
                    icon: Icons.monitor_weight_rounded,
                    label: AppLocalizations.of(context)!.calculateCalories,
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
