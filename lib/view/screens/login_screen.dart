import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/theme/app_colors.dart';
import '../../view_model/auth_view_model.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_textfield.dart';
import 'forgot_password_screen.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<AuthViewModel>(context);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.asset("lib/assets/VoiceMed.Logo.png", height: 150),
              const SizedBox(height: 20),
              CustomTextField(hint: "Email", controller: vm.emailController),
              const SizedBox(height: 16),
              CustomTextField(
                hint: "Password",
                controller: vm.passwordController,
                obscure: true,
              ),
              const SizedBox(height: 10),

              const SizedBox(height: 10),
              // CustomButton(title: "Login", onPressed: vm.login),
              CustomButton(
                title: "Login",
                onPressed: () => vm.login(context),
              ),
              const SizedBox(height: 20),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => const ForgetPasswordScreen()),
                    );
                  },
                  child: const Text(
                    "Forget Password?",
                    style: TextStyle(color: AppColors.primary),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?",
                      style: TextStyle(color: AppColors.white)),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SignupScreen()),
                      );
                    },
                    child: const Text(
                      "Signup",
                      style: TextStyle(color: AppColors.primary),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
