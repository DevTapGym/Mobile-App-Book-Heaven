import 'package:flutter/material.dart';
import 'package:heaven_book_app/screens/Auth/forgot_screen.dart';
import 'package:heaven_book_app/screens/Auth/login_screen.dart';
import 'package:heaven_book_app/screens/Auth/register_screen.dart';
import 'package:heaven_book_app/screens/Auth/reset_screen.dart';
import 'screens/Auth/onboarding_wrapper.dart';
import 'screens/Auth/active_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Heaven App',
      home: const OnboardingWrapper(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/onboarding': (context) => const OnboardingWrapper(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/forgot-password': (context) => const ForgotScreen(),
        '/reset-password': (context) => const ResetScreen(),
        '/active-screen': (context) => const ActiveScreen(),
      },
    );
  }
}
