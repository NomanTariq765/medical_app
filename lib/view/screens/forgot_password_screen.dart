import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../view_model/auth_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/assets/VoiceMed.Logo.png", height: 150),
              const SizedBox(height: 20),
              CustomTextField(hint: "Enter your Email", controller: vm.emailController),
              const SizedBox(height: 20),
              CustomButton(title: "Reset Password", onPressed: vm.resetPassword),
            ],
          ),
        ),
      ),
    );
  }
}
