import 'dart:io';

import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/routes/app_routes.dart';
import 'package:chatapp_firebase/core/widgets/common_button.dart';
import 'package:chatapp_firebase/features/auth_module/onboarding/bloc/onboarding_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../widgets/or_divider.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 25,
        title: Row(
          mainAxisAlignment: .center,
          children: [
            SvgPicture.asset(
              AppAssets.cLogo,
              height: 20,
              width: 16,
              fit: BoxFit.scaleDown,
              colorFilter: ColorFilter.mode(AppColors.white, BlendMode.srcIn),
            ),
            const SizedBox(width: 5),
            Text(
              AppStrings.chatboxText,
              style: AppTextStyles.body(fontWeight: FontWeight.w500, color: AppColors.white),
            ),
          ],
        ),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: SafeArea(
          child: Column(
            children: [
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: AppStrings.connectFriendsText,
                      style: AppTextStyles.heading(
                        color: AppColors.white,
                        fontSize: 68,
                        fontWeight: FontWeight.w400,
                        height: 1.25,
                      ),
                    ),
                    TextSpan(
                      text: AppStrings.easilyText,
                      style: AppTextStyles.heading(
                        color: AppColors.white,
                        fontSize: 68,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    TextSpan(
                      text: AppStrings.andIconText,
                      style: AppTextStyles.heading(
                        fontFamily: '',
                        color: AppColors.white,
                        fontSize: 68,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                    TextSpan(
                      text: AppStrings.quicklyText,
                      style: AppTextStyles.heading(
                        color: AppColors.white,
                        fontSize: 68,
                        fontWeight: FontWeight.w600,
                        height: 1.25,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              Text(
                AppStrings.authHomeScreenSubHeading,
                style: AppTextStyles.body(
                  color: AppColors.lightGray,
                  fontWeight: FontWeight(450),
                  fontSize: 16,
                ),
              ),

              SizedBox(height: 35),

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
                  GestureDetector(
                    onTap: () {
                      context.read<OnboardingBloc>().add(GoogleAuthRequested());
                    },
                    child: Container(
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
                  ),
                  if (Platform.isIOS)
                    Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.borderGrey, width: 1),
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

              const OrDivider(),

              SizedBox(height: MediaQuery.of(context).size.height * .05),

              BlocConsumer<OnboardingBloc, OnboardingState>(
                builder: (context, state) {
                  bool isLoading = state is OnboardingLoading;

                  return CommonButton(
                    label: AppStrings.signUpWithEmailText,
                    isLoading: isLoading,
                    onPressed: isLoading
                        ? null
                        : () {
                            Navigator.pushNamed(context, AppRoutes.signUpScreen);
                          },
                  );
                },
                listener: (context, state) {
                  if (state is OnboardingSuccess) {
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.mainScreen, (route) => false);
                  }
                  if (state is OnboardingError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }
                },
              ),

              Row(
                mainAxisAlignment: .center,
                children: [
                  Text(AppStrings.existingAccountTxt, style: AppTextStyles.body(fontWeight: FontWeight(450))),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(context, AppRoutes.loginScreen);
                    },
                    child: Text(AppStrings.logInText, style: AppTextStyles.body(color: AppColors.white)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
