import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomText extends ConsumerWidget {
  final String text;
  final double? fontSize;
  const CustomText({super.key, required this.text, this.fontSize});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Text(
      text,
      style: GoogleFonts.lato(
        fontSize: fontSize,
      ),
    );
  }
}
