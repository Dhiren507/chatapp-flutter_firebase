import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class ProfileInfoSection extends StatelessWidget {
  final String sectionTitle;
  final String sectionValue;

  const ProfileInfoSection({super.key, required this.sectionTitle, required this.sectionValue});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: .start,
      spacing: 5,
      children: [
        Text(sectionTitle, style: AppTextStyles.body()),
        Text(sectionValue, style: AppTextStyles.heading(fontSize: 18, fontFamily: '')),
      ],
    );
  }
}
