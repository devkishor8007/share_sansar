import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? title;
  String? description;
  String? postby;
  Timestamp? date;
  String? uid;
  PostModel({
    this.id,
    this.title,
    this.description,
    this.postby,
    this.date,
    this.uid,
  });

  factory PostModel.fromJson(DocumentSnapshot snap) {
    return PostModel(
      id: snap.id,
      title: snap['title'],
      description: snap['description'],
      postby: snap['postby'],
      date: snap['date'],
      uid: snap['uid'],
    );
  }
}
