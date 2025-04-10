import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:feedia/screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Feedia',
      theme: ThemeData(
        colorScheme: ColorScheme.dark(
          primary: Colors.orangeAccent,
          secondary: Colors.deepOrange,
          surface: Color(0xFF1E1E1E),
        ),
        useMaterial3: true,
      ),
      home: LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
