import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';
import '../../widgets/custom.textfield.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    super.initState();
    _email = TextEditingController();
    _password = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _email.dispose();
    _password.dispose();
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
              'Make a shine with us...!!',
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
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
                final data = await auth.loginAccount(
                    email: _email.text.trim(), password: _password.text.trim());

                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('$data'),
                  ),
                );
              },
              child: const Text(
                'Login',
              ),
            ),
            SizedBox(
              height: size.height * 0.06,
            ),
            const Text('If you don\'t have an account'),
            SizedBox(
              height: size.height * 0.23,
            ),
          ],
        ),
      ),
    );
  }
}
