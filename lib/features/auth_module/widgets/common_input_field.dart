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
  final ValueChanged<String>? onChanged;

  const CommonInputField({
    super.key,
    this.labelText,
    this.controller,
    this.hintText,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.isPasswordField,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return FormField<String>(
      initialValue: controller?.text ?? '',
      validator: validator,
      builder: (FormFieldState<String> formState) {
        final hasError = formState.hasError;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  Text(
                    labelText ?? '',
                    style: AppTextStyles.body(
                      color: hasError ? AppColors.errorText : AppColors.green,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 5),
            TextFormField(
              obscureText: isPasswordField ?? false,
              controller: controller,
              onChanged: (value) {
                formState.didChange(value);
                onChanged?.call(value);
              },
              validator: validator,
              style: AppTextStyles.body(
                fontWeight: FontWeight.w400,
                fontSize: 18,
                color: AppColors.black,
              ),
              inputFormatters: inputFormatters,
              keyboardType: keyboardType ?? TextInputType.text,
              decoration: InputDecoration(
                filled: true,
                fillColor: AppColors.white,
                hintText: hintText,
                hintStyle: AppTextStyles.body(),

                errorStyle: const TextStyle(fontSize: 0, height: 0),

                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.dividerColor,
                    width: 1,
                  ),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: AppColors.dividerColor,
                    width: 2,
                  ),
                ),
                errorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.errorText, width: 1),
                ),
                focusedErrorBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.errorText, width: 2),
                ),
              ),
            ),

            if (hasError) ...[
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  formState.errorText ?? '',
                  style: AppTextStyles.body(color: AppColors.errorText)
                      .copyWith(fontSize: 12),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
