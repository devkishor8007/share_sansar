import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom.text.dart';

class CustomWidgetPage extends ConsumerWidget {
  final data;
  const CustomWidgetPage({super.key, required this.data});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            17,
          ),
        ),
        child: SizedBox(
          width: size.width,
          height: size.height * 0.2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text: data['name'],
              ),
              CustomText(
                text: data['email'],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
