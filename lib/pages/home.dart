import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/widgets/custom.text.dart';
import 'package:post_wall/widgets/custom.textfield.dart';
import 'package:uuid/uuid.dart';

import '../riverpod/auth_riverpod.dart';
import '../riverpod/post_riverpod.dart';
import '../widgets/custom.appbar.dart';
import '../widgets/custom.button.dart';
import '../widgets/custom.drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  late final TextEditingController _title;
  late final TextEditingController _description;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _description = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _title.dispose();
    _description.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authServiceProvider);
    final post = ref.watch(postRiverpod);
    final postList = ref.watch(postStreamRiverpod(auth.user!.uid));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: const CustomAppBar(
        appBarText: 'Your Post',
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SizedBox(
                  height: size.height / 2,
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        CustomText(
                          text: 'What you make feel better...!!',
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.w800,
                        ),
                        SizedBox(
                          height: size.height * 0.009,
                        ),
                        CustomTextField(
                          controller: _title,
                          hintText: 'title....',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter title';
                            }
                            return null;
                          },
                        ),
                        CustomTextField(
                          controller: _description,
                          hintText: 'description....',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter description';
                            }
                            return null;
                          },
                        ),
                        CustomButton(
                          hintText: 'Submit',
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              const uuid = Uuid();
                              final id = uuid.v4();
                              await post
                                  .createPost(
                                    id: id,
                                    title: _title.text,
                                    postBy: auth.user!.uid,
                                    description: _description.text,
                                  )
                                  .then((value) => {
                                        _title.clear(),
                                        _description.clear(),
                                        Navigator.of(context).pop()
                                      });
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      drawer: const CustomDrawer(),
      body: postList.when(
        data: (data) {
          if (data.docs.isEmpty) {
            return Center(
                child: CustomText(
              text: 'Share your thoughts...!!',
              fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
              fontWeight: FontWeight.w800,
            ));
          }
          return ListView.builder(
            itemCount: data.docs.length,
            itemBuilder: (context, index) {
              final date = data.docs[index]['date']!.toDate();
              final formattedDate = '${date.year}-${date.month}-${date.day}';
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  elevation: 4,
                  child: SizedBox(
                    height: data.docs[index]['description']!.length >= 120
                        ? size.height * 0.35
                        : size.height * 0.17,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                            text: data.docs[index]['title'],
                            fontWeight: FontWeight.w800,
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .fontSize,
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: CustomText(
                              text: 'author'.toUpperCase(),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          CustomText(
                            text: data.docs[index]['description'].toString(),
                          ),
                          const Spacer(),
                          CustomText(
                            text: formattedDate,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
        error: (error, stac) => Text(" $error $stac"),
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }
}
