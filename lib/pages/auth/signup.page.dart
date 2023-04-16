import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:share_sansar/riverpod/auth_riverpod.dart';
import '../../widgets/index.dart';
import '../../riverpod/user_riverpod.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupPageState();
}

class _SignupPageState extends ConsumerState<SignupPage> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  late final TextEditingController _name;

  final _formKey = GlobalKey<FormState>();

  bool isVisible = true;

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
        body: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomText(
                text:
                    'We are delighted that you are a member of our close-knit community!!',
                fontSize: Theme.of(context).textTheme.headlineSmall!.fontSize,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              CustomTextField(
                controller: _name,
                hintText: 'Enter your name..',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
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
                obscureText: isVisible,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              CustomButton(
                hintText: 'Signup',
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    final data = await auth.createAccount(
                      email: _email.text.trim(),
                      password: _password.text.trim(),
                      username: _name.text.trim(),
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
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              const CustomRichText(
                  routeName: '/login',
                  questionText: 'If you have an account',
                  nameTextButton: '   Login'),
              // RichText(
              //   text: TextSpan(
              //       text: 'If you have an account',
              //       style: GoogleFonts.lato(
              //         color: AppColor.blackColor,
              //         fontWeight: FontWeight.w700,
              //         fontSize:
              //             Theme.of(context).textTheme.titleMedium!.fontSize,
              //       ),
              //       children: [
              //         TextSpan(
              //           text: '   Login',
              //           style: GoogleFonts.lato(
              //             color: AppColor.indigoColor,
              //             fontWeight: FontWeight.w700,
              //             fontSize:
              //                 Theme.of(context).textTheme.titleMedium!.fontSize,
              //           ),
              //           recognizer: TapGestureRecognizer()
              //             ..onTap = () => context.go('/login'),
              //         )
              //       ]),
              // ),

              SizedBox(
                height: size.height * 0.001,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
