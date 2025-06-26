import 'package:flutter/material.dart';
import 'package:medical_app/view/screens/forgot_password_screen.dart';
import 'package:medical_app/view/screens/signup_screen.dart';
import 'package:medical_app/view/screens/today_screen.dart';
import 'package:provider/provider.dart';
import 'view/screens/login_screen.dart';
import 'view_model/auth_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MVVM Auth App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: const LoginScreen(),

    );
  }
}
