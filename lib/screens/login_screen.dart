import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

import 'package:feedia/screens/home_screen.dart';

const List<String> supportedLanguages = ['English', 'Spanish'];

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

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
                    //Set localization language here
                  },
                ),
              ),
              // App Welcome Text
              Align(
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Text(
                      'Welcome to Feedia!',
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
                    text: "Continue with Google",
                    onPressed: () {
                      // TODO: Implement Google Sign-In
                      _navigateToPersonalDetalsScreen();
                    },
                  ),
                  const SizedBox(height: 16),
                  SignInButton(
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    Buttons.AppleDark,
                    text: "Continue with Apple",
                    onPressed: () {
                      // TODO: Implement Apple Sign-In
                      _navigateToPersonalDetalsScreen();
                    },
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Feedia with Capital Area Food Bank helps you find food and help you navigate tough times.',
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
