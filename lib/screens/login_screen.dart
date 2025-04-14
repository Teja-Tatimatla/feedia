import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'package:feedia/screens/home_screen.dart';

const List<String> supportedLanguages = [
  'English',
  'Spanish',
  'French',
  'Telugu',
  'Japanese',
];

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key, required this.setLocale});

  void Function(Locale) setLocale;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  void _navigateToPersonalDetalsScreen() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (ctx) => const HomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Color.fromRGBO(3, 12, 18, 1),
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Language Selector
              Align(
                alignment: Alignment.topLeft,
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromRGBO(11, 19, 23, 1),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  dropdownColor: Color.fromRGBO(11, 19, 23, 1),
                  value: 'English',
                  items:
                      supportedLanguages
                          .map(
                            (lang) => DropdownMenuItem(
                              value: lang,
                              child: Text(
                                lang,
                                style: const TextStyle(
                                  color: Color.fromRGBO(231, 214, 194, 1),
                                ),
                              ),
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    switch (value) {
                      case 'English':
                        widget.setLocale(Locale('en'));
                        break;
                      case 'Spanish':
                        widget.setLocale(Locale('es'));
                        break;
                      case 'French':
                        widget.setLocale(Locale('fr'));
                        break;
                      case 'Telugu':
                        widget.setLocale(Locale('te'));
                        break;
                      case 'Japanese':
                        widget.setLocale(Locale('ja'));
                        break;
                    }
                  },
                ),
              ),
              // App Welcome Text
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      AppLocalizations.of(context)!.welcomeTitle,
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.orangeAccent,
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: [
                  SignInButton(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                    Buttons.GoogleDark,
                    text: AppLocalizations.of(context)!.continueWithGoogle,
                    onPressed: () {
                      // TODO: Implement Google Sign-In
                      _navigateToPersonalDetalsScreen();
                    },
                  ),
                  const SizedBox(height: 16),
                  SignInButton(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    Buttons.AppleDark,
                    text: AppLocalizations.of(context)!.continueWithApple,
                    onPressed: () {
                      // TODO: Implement Apple Sign-In
                      _navigateToPersonalDetalsScreen();
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    AppLocalizations.of(context)!.feediaBottomText,
                    style: TextStyle(
                      fontSize: 12,
                      color: Color.fromRGBO(231, 214, 194, 1),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
