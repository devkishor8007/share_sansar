import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomButton extends ConsumerWidget {
  final void Function()? onPressed;
  final String hintText;
  const CustomButton(
      {super.key, required this.onPressed, required this.hintText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.indigo,
        minimumSize: Size(
          size.width * 0.3,
          size.height * 0.06,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(4),
          ),
        ),
      ),
      onPressed: onPressed,
      child: Text(
        hintText,
        style: GoogleFonts.lato(),
      ),
    );
  }
}
