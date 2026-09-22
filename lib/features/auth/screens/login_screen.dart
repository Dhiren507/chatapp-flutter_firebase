import 'package:chatapp_firebase/core/utils/validators.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_button.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/common_input_field.dart';
import 'package:chatapp_firebase/features/auth/widgets/auth_options_row.dart';
import 'package:chatapp_firebase/features/auth/widgets/or_divider.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        leading: CommonBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 50),

              Text(
                AppStrings.loginToChatBoxText,
                style: AppTextStyles.heading(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 15),

              Text(
                AppStrings.loginSubheadingText,
                style: AppTextStyles.body(),
                textAlign: .center,
              ),

              const SizedBox(height: 35),

              const AuthOptionsRow(),

              const SizedBox(height: 25),

              const OrDivider(textColor: AppColors.textSecondary),

              const SizedBox(height: 25),

              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CommonInputField(
                      labelText: AppStrings.yourEmailLabelText,
                      controller: _emailController,
                      validator: Validators.validateEmail,
                    ),

                    const SizedBox(height: 15),

                    CommonInputField(
                      labelText: AppStrings.passwordText,
                      controller: _passwordController,
                      validator: Validators.validatePassword,
                    ),
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.19),

              CommonButton(
                label: AppStrings.logInText,
                onPressed: () {
                  _formKey.currentState?.validate();
                },
                backgroundColor: AppColors.green,
                textColor: AppColors.white,
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  AppStrings.forgotPasswordText,
                  style: AppTextStyles.body(color: AppColors.green),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
