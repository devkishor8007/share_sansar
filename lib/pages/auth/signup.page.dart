import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';

import '../../widgets/custom.textfield.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
    _name = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
    _name.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final auth = ref.watch(authServiceProvider);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'We are happy that you are a part of our small world...!!',
              style: GoogleFonts.lato(
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            CustomTextField(
              controller: _name,
              hintText: 'Enter your name..',
              // obscureText: true,
            ),
            CustomTextField(
              controller: _email,
              hintText: 'Enter your email..',
            ),
            CustomTextField(
              controller: _password,
              hintText: 'Enter your password..',
              obscureText: true,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            ElevatedButton(
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
              onPressed: () async {
                final data = await auth.createAccount(
                  email: _email.text.trim(),
                  password: _password.text.trim(),
                );

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$data'),
                  ),
                );
              },
              child: const Text(
                'Signup',
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            const Text('If you have an account'),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
