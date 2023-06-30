import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationUser {
  final String notificationId;
  final String uid;
  final String name;
  final String photoURL;
  final String postId;
  final datePublished;
  final String commentId;
  bool isLike;

  NotificationUser({
    required this.notificationId,
    required this.name,
    required this.photoURL,
    required this.uid,
    required this.postId,
    required this.commentId,
    required this.datePublished,
    this.isLike = false,
  });

  Map<String, dynamic> toJson() => {
    "notificationId" : notificationId,
    "name" : name,
    "photoURL" : photoURL,
    "uid" : uid,
    "postId" : postId,
    "datePublished" : datePublished,
    "commentId" : commentId,
    "isLike" : isLike,
  }; 


  static NotificationUser fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String,dynamic>;

    return NotificationUser(
      notificationId: snapshot['notificationId'],
      name: snapshot['name'],
      photoURL: snapshot['photoURL'],
      uid: snapshot['uid'],
      postId : snapshot['postId'],
      datePublished : snapshot['datePublished'],
      commentId : snapshot['commentId'],
      isLike: snapshot['isLike'],

    );
  }
}