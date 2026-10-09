import 'package:chatapp_firebase/core/constants/app_assets.dart';
import 'package:chatapp_firebase/core/constants/app_strings.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:chatapp_firebase/core/widgets/pressable_option_tile.dart';
import 'package:flutter/material.dart';

class CommonBottomSheet extends StatelessWidget {
  final bool isStatusScreen;
  final bool isGroupScreen;
  final VoidCallback? onCameraPressed;
  final VoidCallback? onMediaPressed;

  const CommonBottomSheet({
    super.key,
    this.isGroupScreen = false,
    this.isStatusScreen = false,
    this.onCameraPressed,
    this.onMediaPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: true,
      child: Column(
        mainAxisSize: .min,
        children: [
          SizedBox(height: 15),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              crossAxisAlignment: .center,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(Icons.close),
                ),
                Expanded(
                  child: Align(
                    alignment: .topCenter,
                    child: Text(AppStrings.shareContentTitle, style: AppTextStyles.heading()),
                  ),
                ),
              ],
            ),
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              children: [
                if (isStatusScreen) ...[
                  PressableOptionTile(
                    iconPath: AppAssets.cameraOpenIcon,
                    optionTitle: AppStrings.attachmentCameraText,
                    onPressed: onCameraPressed ?? () {},
                  ),
                  const Divider(indent: 50, height: 20),
                  PressableOptionTile(
                    iconPath: AppAssets.mediaImageIcon,
                    optionTitle: AppStrings.attachmentMediaText,
                    optionDescription: AppStrings.attachmentMediaSubtitle,
                    onPressed: onMediaPressed ?? () {},
                  ),
                  const Divider(indent: 50, height: 20),
                ] else ...[
                  PressableOptionTile(
                    iconPath: AppAssets.cameraOpenIcon,
                    optionTitle: AppStrings.attachmentCameraText,
                    onPressed: () {},
                  ),
                  const Divider(indent: 50, height: 20),
                  PressableOptionTile(
                    iconPath: AppAssets.mediaImageIcon,
                    optionTitle: AppStrings.attachmentMediaText,
                    optionDescription: AppStrings.attachmentMediaSubtitle,
                    onPressed: onMediaPressed ?? () {},
                  ),
                  const Divider(indent: 50, height: 20),
                  PressableOptionTile(
                    iconPath: AppAssets.documentIcon,
                    optionTitle: AppStrings.attachmentDocumentText,
                    optionDescription: AppStrings.attachmentDocumentSubtitle,
                    onPressed: () {},
                  ),
                  const Divider(indent: 50, height: 20),
                  if (isGroupScreen) ...[
                    PressableOptionTile(
                      iconPath: AppAssets.networkIcon,
                      optionTitle: AppStrings.attachmentPollText,
                      optionDescription: AppStrings.attachmentPollSubtitle,
                      onPressed: () {},
                    ),
                    const Divider(indent: 50, height: 20),
                  ],
                  PressableOptionTile(
                    iconPath: AppAssets.contactIcon,
                    optionTitle: AppStrings.attachmentContactText,
                    optionDescription: AppStrings.attachmentContactSubtitle,
                    onPressed: () {},
                  ),
                  const Divider(indent: 50, height: 20),
                  PressableOptionTile(
                    iconPath: AppAssets.locationMarkIcon,
                    optionTitle: AppStrings.attachmentLocationText,
                    optionDescription: AppStrings.attachmentLocationSubtitle,
                    onPressed: () {},
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
