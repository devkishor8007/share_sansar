import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:post_wall/widgets/custom.textfield.dart';
import 'package:uuid/uuid.dart';
// import 'package:go_router/go_router.dart';

import '../riverpod/auth_riverpod.dart';
import '../riverpod/post_riverpod.dart';
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
    // _postBy.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authServiceProvider);
    final post = ref.watch(postRiverpod);
    final postList = ref.watch(postStreamRiverpod);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Post'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //   showDialog(
          //       context: context,
          //       builder: (BuildContext context) {
          //         return AlertDialog(
          //           title: const Text('Share your thoughts...'),
          //           actions: [
          //             CustomTextField(controller: _title, hintText: 'title....'),
          //             CustomTextField(
          //                 controller: _description, hintText: 'description....'),
          //             CustomButton(
          //               hintText: 'Submit',
          //               onPressed: () async {
          //                 const uuid = Uuid();
          //                 final id = uuid.v4();
          //                 await post
          //                     .createPost(
          //                       id: id,
          //                       title: _title.text,
          //                       postBy: auth.user!.uid,
          //                       description: _description.text,
          //                     )
          //                     .then((value) => {
          //                           _title.clear(),
          //                           _description.clear(),
          //                           Navigator.of(context).pop()
          //                         });
          //               },
          //             ),
          //           ],
          //         );
          //       });

          showModalBottomSheet(
              context: context,
              builder: (c) {
                return SizedBox(
                  height: size.height / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        'Share your thoughts...',
                        style: GoogleFonts.lato(
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.009,
                      ),
                      CustomTextField(
                          controller: _title, hintText: 'title....'),
                      CustomTextField(
                          controller: _description,
                          hintText: 'description....'),
                      CustomButton(
                        hintText: 'Submit',
                        onPressed: () async {
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
                        },
                      ),
                    ],
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
            return const Center(child: Text("what's your thoughts"));
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
                          Text(
                            data.docs[index]['title'],
                            style: GoogleFonts.lato(
                                fontWeight: FontWeight.w800,
                                fontSize: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .fontSize),
                          ),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              'author'.toUpperCase(),
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.015,
                          ),
                          Text(
                            data.docs[index]['description'].toString(),
                            style: GoogleFonts.lato(),
                          ),
                          const Spacer(),
                          Text(
                            formattedDate,
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w600,
                            ),
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
