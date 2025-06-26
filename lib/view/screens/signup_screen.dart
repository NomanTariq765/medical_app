import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../view_model/auth_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("lib/assets/VoiceMed.Logo.png", height: 150),
              const SizedBox(height: 20),
              CustomTextField(
                  hint: "Username", controller: vm.usernameController),
              const SizedBox(height: 16),
              CustomTextField(hint: "Email", controller: vm.emailController),
              const SizedBox(height: 16),
              CustomTextField(
                hint: "Password",
                controller: vm.passwordController,
                obscure: true,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                hint: "Confirm Password",
                controller: vm.confirmPasswordController,
                obscure: true,
              ),
              const SizedBox(height: 20),
              CustomButton(title: "Signup", onPressed: vm.signup),
            ],
          ),
        ),
      ),
    );
  }
}
