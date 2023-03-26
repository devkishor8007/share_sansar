import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextField extends ConsumerWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.obscureText = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 1.0,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
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
