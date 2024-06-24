import 'package:flutter/material.dart';
import 'package:finals_app/login_page.dart' as Login;
import 'package:finals_app/register_page.dart' as Register;
import 'package:finals_app/main_screen.dart';
import 'package:finals_app/home_page.dart';
import 'package:finals_app/calendar_page.dart';
import 'package:finals_app/sleep_calculator_page.dart';
import 'package:finals_app/database_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DatabaseHelper().database; // Ensure the database is initialized
  runApp(MorningStarterApp());
}

class MorningStarterApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Morning Starter',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login.LoginPage(),
        '/register': (context) => Register.RegisterPage(),
        '/main': (context) => MainScreen(email: ''), // Placeholder for email
        '/home': (context) => HomePage(),
        '/calendar': (context) => CalendarPage(),
        '/sleep_calculator': (context) => SleepCalculatorPage(),
      },
    );
  }
}
