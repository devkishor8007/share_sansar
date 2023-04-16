import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_sansar/data/services/post_service.dart';
import 'package:share_sansar/data/services/auth_service.dart';
import 'package:share_sansar/utils/color.dart';
import 'package:share_sansar/widgets/custom.text.dart';
import 'package:share_sansar/widgets/custom.textfield.dart';
import 'package:share_plus/share_plus.dart';
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
          showModelWidget(context, size, post, auth);
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
                        : size.height * 0.2,
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              CustomText(
                                text: formattedDate,
                                fontWeight: FontWeight.w600,
                              ),
                              IconButton(
                                onPressed: () async {
                                  final isDelete = await post.deletePost(
                                      id: data.docs[index]['id']);

                                  if (!mounted) return;
                                  if (isDelete) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        duration: const Duration(seconds: 2),
                                        backgroundColor: AppColor.redColor,
                                        content: Text(
                                            'deleted ${data.docs[index]['title']}'),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(
                                  Icons.delete,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  Share.share(
                                    "${data.docs[index]['title']}\n${data.docs[index]['description']}\n- ${auth.user!.displayName}",
                                  );
                                },
                                icon: const Icon(
                                  Icons.share,
                                ),
                              ),
                            ],
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
        error: (error, stackTrace) => Text(" $error"),
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }

  Future<dynamic> showModelWidget(
      BuildContext context, Size size, PostService post, AuthService auth) {
    return showModalBottomSheet(
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
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
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
                      } else if (value.length >= 20) {
                        return 'Please title must be less than 20 words';
                      }
                      return null;
                    },
                  ),
                  CustomTextField(
                    controller: _description,
                    hintText: 'description....',
                    maxLines: 6,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter description';
                      } else if (value.length >= 500) {
                        return 'Please description must be less than 500 words';
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
  }
}
