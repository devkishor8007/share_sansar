import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';
import 'package:post_wall/widgets/custom.text.dart';
import '../../widgets/custom.button.dart';
import '../../widgets/custom.textfield.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  final _formKey = GlobalKey<FormState>();

  bool isVisible = true;

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
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomText(
                text: 'Make a shine with us...!!',
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              CustomTextField(
                controller: _email,
                hintText: 'Enter your email..',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: _password,
                hintText: 'Enter your password..',
                obscureText: isVisible,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  child:
                      Icon(isVisible ? Icons.visibility : Icons.visibility_off),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              CustomButton(
                hintText: 'Login',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final data = await auth.loginAccount(
                        email: _email.text.trim(),
                        password: _password.text.trim());

                    if (!mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('$data'),
                      ),
                    );
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              RichText(
                text: TextSpan(
                    text: 'If you don\'t have an account',
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize:
                          Theme.of(context).textTheme.titleMedium!.fontSize,
                    ),
                    children: [
                      TextSpan(
                        text: '   Signup',
                        style: GoogleFonts.lato(
                          color: Colors.indigo,
                          fontWeight: FontWeight.w700,
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () => context.go('/signup'),
                      )
                    ]),
              ),
              SizedBox(
                height: size.height * 0.23,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
