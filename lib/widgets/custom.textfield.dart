import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_sansar/utils/color.dart';

class CustomTextField extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final int? maxLines;
  final String? Function(String?)? validator;
  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.obscureText = false,
    this.suffixIcon,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        maxLines: maxLines,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: AppColor.greyColor,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.greenColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.greenColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.redColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColor.greenColor,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
        ),
      ),
    );
  }
}
