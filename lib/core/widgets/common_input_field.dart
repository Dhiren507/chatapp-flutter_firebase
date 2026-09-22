import 'package:chatapp_firebase/core/constants/app_colors.dart';
import 'package:chatapp_firebase/core/constants/app_text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CommonInputField extends StatelessWidget {
  final String? labelText;
  final TextEditingController? controller;
  final String? hintText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final bool? isPasswordField;

  final ValueNotifier<String?> _errorNotifier = ValueNotifier<String?>(null);

  CommonInputField({
    super.key,
    this.labelText,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.isPasswordField,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Padding(
          padding: EdgeInsets.zero,
          child: ValueListenableBuilder<String?>(
            valueListenable: _errorNotifier,
            builder: (context, errorText, child) {
              final hasError = errorText != null;
              return Row(
                children: [
                  Text(
                    labelText ?? '',
                    style: AppTextStyles.body(
                      color: hasError ? AppColors.errorText : AppColors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              );
            },
          ),
        ),

        const SizedBox(height: 5),
        TextFormField(
          obscureText: isPasswordField ?? false,
          controller: controller,
          validator: (value) {
            final error = validator?.call(value);
            _errorNotifier.value = error;

            return error;
          },
          style: AppTextStyles.body(fontWeight: FontWeight.w400, fontSize: 18, color: AppColors.black),
          inputFormatters: inputFormatters,
          keyboardType: keyboardType ?? TextInputType.text,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppColors.white,
            hintText: hintText,
            hintStyle: AppTextStyles.body(),

            errorStyle: const TextStyle(fontSize: 0, height: 0),

            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.dividerColor, width: 1),
            ),
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.dividerColor, width: 2),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorText, width: 1),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.errorText, width: 2),
            ),
          ),
        ),

        ValueListenableBuilder(
          valueListenable: _errorNotifier,
          builder: (context, errorText, child) {
            final hasError = errorText != null;
            if (!hasError) {
              return SizedBox.shrink();
            }

            return Align(
              alignment: .centerRight,
              child: Text(
                errorText,
                style: AppTextStyles.body(color: AppColors.errorText),
              ),
            );
          },
        ),
      ],
    );
  }
}
