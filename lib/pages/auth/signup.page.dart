import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';

import '../../riverpod/user_riverpod.dart';
import '../../widgets/custom.button.dart';
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
    final user = ref.watch(userRiverpod);
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              'We are happy that you are a part of our small world...!!',
              style: GoogleFonts.lato(
                fontSize: 18,
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
            CustomButton(
              hintText: 'Signup',
              onPressed: () async {
                final data = await auth.createAccount(
                  email: _email.text.trim(),
                  password: _password.text.trim(),
                );

                final uid = auth.user!.uid;

                await user
                    .createUser(
                        uid: uid,
                        email: _email.text.trim(),
                        name: _name.text.trim())
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('$data'),
                    ),
                  );
                  context.go('/check-auth');
                });
                _email.clear();
                _password.clear();
              },
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            RichText(
              text: TextSpan(
                  text: 'If you have an account',
                  style: GoogleFonts.lato(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  ),
                  children: [
                    TextSpan(
                      text: '   Login',
                      style: GoogleFonts.lato(
                        color: Colors.indigo,
                        fontWeight: FontWeight.w700,
                        fontSize:
                            Theme.of(context).textTheme.titleMedium!.fontSize,
                      ),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => context.go('/login'),
                    )
                  ]),
            ),
            SizedBox(
              height: size.height * 0.1,
            ),
          ],
        ),
      ),
    );
  }
}
