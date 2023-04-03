import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'custom.text.dart';

class CustomAppBar extends ConsumerWidget implements PreferredSizeWidget {
  final String appBarText;
  const CustomAppBar({super.key, required this.appBarText});
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      title: CustomText(text: appBarText),
    );
  }
}
