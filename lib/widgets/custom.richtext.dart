import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../utils/color.dart';

class CustomRichText extends ConsumerWidget {
  final String routeName;
  final String questionText;
  final String nameTextButton;
  const CustomRichText({super.key, required this.routeName, required this.questionText, required this.nameTextButton});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RichText(
      text: TextSpan(
          text: questionText,
          style: GoogleFonts.lato(
            color: AppColor.blackColor,
            fontWeight: FontWeight.w700,
            fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
          ),
          children: [
            TextSpan(
              text: nameTextButton,
              style: GoogleFonts.lato(
                color: AppColor.indigoColor,
                fontWeight: FontWeight.w700,
                fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => context.go(routeName),
            )
          ]),
    );
  }
}
