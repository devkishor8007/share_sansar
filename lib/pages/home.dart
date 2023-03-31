import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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
  // late final TextEditingController _postBy;

  @override
  void initState() {
    super.initState();
    _title = TextEditingController();
    _description = TextEditingController();
    // _postBy = TextEditingController();/
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('welcome'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: const Text('Share your thoughts...'),
                  actions: [
                    CustomTextField(controller: _title, hintText: 'title....'),
                    CustomTextField(
                        controller: _description, hintText: 'description....'),
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
                            .then((value) => Navigator.of(context).pop());
                        _title.clear();
                        _description.clear();
                      },
                    ),
                  ],
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
            return const Center(child: Text("no"));
          }
          return ListView.builder(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(data.docs[index]['title']),
                subtitle: Text(data.docs[index]['description']),
              );
            },
            itemCount: data.docs.length,
          );
        },
        error: (error, stac) => Text(" $error $stac"),
        loading: () => const LinearProgressIndicator(),
      ),
    );
  }
}
