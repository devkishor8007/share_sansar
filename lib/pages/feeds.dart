import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/data/models/post.model.dart';
import 'package:post_wall/riverpod/auth_riverpod.dart';
import 'package:post_wall/widgets/custom.appbar.dart';
import 'package:post_wall/widgets/custom.text.dart';

import '../riverpod/post_riverpod.dart';
import '../widgets/custom.drawer.dart';

class FeedsScreen extends ConsumerStatefulWidget {
  const FeedsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedsScreenState();
}

class _FeedsScreenState extends ConsumerState<FeedsScreen> {
  @override
  Widget build(BuildContext context) {
    final feeds = ref.watch(feedsPostStreamRiverpod);
    final auth = ref.watch(authServiceProvider);
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: const CustomAppBar(
          appBarText: 'Feeds',
        ),
        drawer: const CustomDrawer(),
        body: feeds.when(
          data: (feedData) {
            return ListView.builder(
              itemCount: feedData.length,
              itemBuilder: (BuildContext context, int index) {
                final PostModel post = feedData[index];
                final date = post.date!.toDate();
                final formattedDate = '${date.year}-${date.month}-${date.day}';
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    elevation: 4,
                    child: SizedBox(
                      height: post.description!.length >= 120
                          ? size.height * 0.35
                          : size.height * 0.17,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: post.title.toString(),
                              fontWeight: FontWeight.w800,
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .fontSize,
                            ),
                            auth.user!.uid == post.postBy
                                ? Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomText(
                                      text: 'author'.toUpperCase(),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                : Align(
                                    alignment: Alignment.centerRight,
                                    child: CustomText(
                                      text: 'contributor'.toUpperCase(),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                            SizedBox(
                              height: size.height * 0.015,
                            ),
                            CustomText(
                              text: post.description.toString(),
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
          error: (error, stac) => Text("$error"),
          loading: () => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
