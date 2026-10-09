import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/utils/validators.dart';
import 'package:chatapp_firebase/core/widgets/common_back_button.dart';
import 'package:chatapp_firebase/core/widgets/common_button.dart';
import 'package:chatapp_firebase/features/auth_module/signup/bloc/signup_bloc.dart';
import 'package:chatapp_firebase/features/auth_module/widgets/common_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        surfaceTintColor: AppColors.white,
        leading: CommonBackButton(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              const SizedBox(height: 50),

              Text(
                AppStrings.signUpWithEmailText,
                style: AppTextStyles.heading(fontSize: 18, fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 15),

              Text(AppStrings.signupSubheadingText, style: AppTextStyles.body(), textAlign: .center),

              const SizedBox(height: 35),

              Form(
                key: _formKey,
                autovalidateMode: .onUserInteractionIfError,
                child: Column(
                  children: [
                    CommonInputField(
                      labelText: AppStrings.yourNameText,
                      controller: _nameController,
                      validator: Validators.nameValidation,
                      inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))],
                      onChanged: (value) {
                        context.read<SignupBloc>().add(
                          SignupInputFieldChanged(
                            name: value,
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPass: _confirmPassController.text,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    CommonInputField(
                      labelText: AppStrings.yourEmailLabelText,
                      controller: _emailController,
                      validator: Validators.validateEmail,
                      onChanged: (value) {
                        context.read<SignupBloc>().add(
                          SignupInputFieldChanged(
                            name: _nameController.text,
                            email: value,
                            password: _passwordController.text,
                            confirmPass: _confirmPassController.text,
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
                        context.read<SignupBloc>().add(
                          SignupInputFieldChanged(
                            name: _nameController.text,
                            email: _emailController.text,
                            password: value,
                            confirmPass: _confirmPassController.text,
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 15),

                    CommonInputField(
                      labelText: AppStrings.confirmPasswordText,
                      controller: _confirmPassController,
                      validator: (value) =>
                          Validators.validateConfirmPassword(value, _passwordController.text.trim()),
                      onChanged: (value) {
                        context.read<SignupBloc>().add(
                          SignupInputFieldChanged(
                            name: _emailController.text,
                            email: _emailController.text,
                            password: _passwordController.text,
                            confirmPass: value,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              SizedBox(height: MediaQuery.of(context).size.height * 0.15),

              BlocConsumer<SignupBloc, SignupState>(
                listener: (context, state) {
                  if (state.status == SignupStatus.success) {
                    Navigator.pushNamed(context, AppRoutes.loginScreen);
                  }

                  if (state.status == SignupStatus.error) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errorMsg), backgroundColor: AppColors.bgError),
                    );
                  }
                },
                builder: (context, state) {
                  bool isButtonEnabled = state.buttonStatus == ButtonStatus.enabled;
                  bool isLoading = state.status == SignupStatus.loading;

                  return CommonButton(
                    label: AppStrings.createAnAccountText,
                    isLoading: isLoading,
                    onPressed: isButtonEnabled
                        ? () {
                            bool? isFormValid = _formKey.currentState?.validate();
                            if (isFormValid!) {
                              context.read<SignupBloc>().add(
                                SignupRequested(
                                  name: _nameController.text.trim(),
                                  email: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                ),
                              );
                            }
                          }
                        : null,
                    backgroundColor: AppColors.green,
                    textColor: isButtonEnabled ? AppColors.white : AppColors.textSecondary,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
