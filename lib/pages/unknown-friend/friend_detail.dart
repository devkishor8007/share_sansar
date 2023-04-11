import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:post_wall/widgets/custom.appbar.dart';
import 'package:post_wall/widgets/custom.border.dart';

import '../../riverpod/post_riverpod.dart';
import '../../riverpod/user_riverpod.dart';
import '../../widgets/custom.text.dart';

class UnknownFriendDetail extends ConsumerStatefulWidget {
  final String userId;
  const UnknownFriendDetail({super.key, required this.userId});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UnknownFriendDetailState();
}

class _UnknownFriendDetailState extends ConsumerState<UnknownFriendDetail> {
  @override
  Widget build(BuildContext context) {
    final dataIsProfile = ref.watch(futureProvider(widget.userId));
    final postList = ref.watch(postStreamRiverpod(widget.userId));
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: CustomAppBar(appBarText: widget.userId.toString()),
      body: dataIsProfile.when(
          data: (abc) {
            Map<String, dynamic> data = abc.data() as Map<String, dynamic>;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomWidgetPage(data: data),
                Align(
                  alignment: Alignment.center,
                  child: CustomText(
                    text: 'POST',
                    fontWeight: FontWeight.w900,
                    fontSize: Theme.of(context).textTheme.titleMedium!.fontSize,
                  ),
                ),
                Expanded(
                  child: postList.when(
                    data: (postData) {
                      if (postData.docs.isEmpty) {
                        return Center(
                            child: CustomText(
                          text: '${data['name']} has 0 Post...!!',
                          fontSize:
                              Theme.of(context).textTheme.titleMedium!.fontSize,
                          fontWeight: FontWeight.w800,
                        ));
                      }
                      return SizedBox(
                        height: size.height * 0.8,
                        child: ListView.builder(
                          shrinkWrap: false,
                          itemCount: postData.docs.length,
                          itemBuilder: (context, index) {
                            final date = postData.docs[index]['date']!.toDate();
                            final formattedDate =
                                '${date.year}-${date.month}-${date.day}';
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: SizedBox(
                                  height: postData.docs[index]['description']!
                                              .length >=
                                          120
                                      ? size.height * 0.35
                                      : size.height * 0.17,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CustomText(
                                          text: postData.docs[index]['title'],
                                          fontWeight: FontWeight.w800,
                                          fontSize: Theme.of(context)
                                              .textTheme
                                              .titleMedium!
                                              .fontSize,
                                        ),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: CustomText(
                                            text: 'CONTRIBUTOR'.toUpperCase(),
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        SizedBox(
                                          height: size.height * 0.015,
                                        ),
                                        CustomText(
                                          text: postData.docs[index]
                                                  ['description']
                                              .toString(),
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
                        ),
                      );
                    },
                    error: (error, stac) => Text(" $error $stac"),
                    loading: () => const LinearProgressIndicator(),
                  ),
                ),
              ],
            );
          },
          error: (error, stac) => Text(" $error $stac"),
          loading: () => const LinearProgressIndicator()),
    );
  }
}
