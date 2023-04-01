import 'package:cloud_firestore/cloud_firestore.dart';

class PostModel {
  String? id;
  String? title;
  String? description;
  String? postBy;
  Timestamp? date;
  bool isPrivate;
  PostModel({
    this.id,
    this.title,
    this.description,
    this.postBy,
    this.date,
    this.isPrivate = false,
  });

  factory PostModel.fromJson(DocumentSnapshot snap) {
    return PostModel(
      id: snap.id,
      title: snap['title'],
      description: snap['description'],
      postBy: snap['postBy'],
      date: snap['date'],
      isPrivate: snap['isPrivate'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'postBy': postBy,
      'title': title,
      'description': description,
      'date': Timestamp.now(),
      'id': id,
      'isPrivate': isPrivate,
    };
  }
}
