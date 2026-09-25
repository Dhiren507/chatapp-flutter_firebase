import 'dart:io';

import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/utils/validators.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_button.dart';
import 'package:chatapp_firebase/features/auth_module/login/bloc/login_bloc.dart';
import 'package:chatapp_firebase/features/auth_module/widgets/common_input_field.dart';
import 'package:chatapp_firebase/features/auth_module/widgets/or_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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

              Row(
                mainAxisAlignment: .center,
                spacing: 20,
                children: [
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderGrey, width: 1),
                    ),
                    child: SvgPicture.asset(
                      AppAssets.facebookIcon,
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.borderGrey, width: 1),
                    ),
                    child: SvgPicture.asset(
                      AppAssets.googleIcon,
                      height: 24,
                      width: 24,
                      fit: BoxFit.scaleDown,
                    ),
                  ),
                  if (Platform.isIOS)
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: AppColors.borderGrey,
                          width: 1,
                        ),
                      ),
                      child: SvgPicture.asset(
                        AppAssets.appleIcon,
                        height: 24,
                        width: 24,
                        fit: BoxFit.scaleDown,
                      ),
                    ),
                ],
              ),

              const SizedBox(height: 25),

              const OrDivider(textColor: AppColors.textSecondary),

              const SizedBox(height: 25),

              Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteractionIfError,
                child: Column(
                  children: [
                    CommonInputField(
                      labelText: AppStrings.yourEmailLabelText,
                      controller: _emailController,
                      validator: Validators.validateEmail,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                          LoginInputFieldChanged(
                            email: value,
                            password: _passwordController.text,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    CommonInputField(
                      labelText: AppStrings.passwordText,
                      controller: _passwordController,
                      validator: Validators.validatePassword,
                      onChanged: (value) {
                        context.read<LoginBloc>().add(
                          LoginInputFieldChanged(
                            email: _emailController.text,
                            password: value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.19),

              BlocBuilder<LoginBloc, LoginState>(
                builder: (context, state) {
                  return CommonButton(
                    label: AppStrings.logInText,
                    onPressed: state is ButtonEnabled
                        ? () {
                            _formKey.currentState?.validate();
                          }
                        : null,
                    backgroundColor: AppColors.green,
                    textColor: state is ButtonEnabled
                        ? AppColors.white
                        : AppColors.textSecondary,
                  );
                },
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
