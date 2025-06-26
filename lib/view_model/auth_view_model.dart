import 'package:flutter/material.dart';
import 'package:medical_app/models/medication_entry.dart';
import '../view/screens/today_screen.dart';

class AuthViewModel extends ChangeNotifier {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final usernameController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  final List<MedicationEntry> _medications = [];

  List<MedicationEntry> get medications => _medications;

  void login(BuildContext context) {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TodayScreen(entries: _medications),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter email and password")),
      );
    }
  }

  void signup() {
    debugPrint('Username: ${usernameController.text}');
    debugPrint('Email: ${emailController.text}');
    debugPrint('Password: ${passwordController.text}');
  }

  void resetPassword() {
    debugPrint('Reset link sent to: ${emailController.text}');
  }

  void addMedication(MedicationEntry entry) {
    _medications.add(entry);
    notifyListeners();
  }

  void clearControllers() {
    emailController.clear();
    passwordController.clear();
    usernameController.clear();
    confirmPasswordController.clear();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    usernameController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }
}