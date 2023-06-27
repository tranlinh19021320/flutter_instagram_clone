import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  final String desciption;
  final String uid;
  final String username;
  final String postId;
  final datePublished;
  final String postURL;
  final String profImage;
  final likes;

  const Post({
    required this.desciption,
    required this.uid,
    required this.username,
    required this.postId,
    required this.datePublished,
    required this.postURL,
    required this.profImage,
    required this.likes,
  });

  Map<String, dynamic> toJson() => {
    "description" : desciption,
    "uid" : uid,
    "username" : username,
    "postId" : postId,
    "datePublished" : datePublished,
    "postURL" : postURL,
    "profImage" : profImage,
    "likes" : likes,
  }; 


  static Post fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String,dynamic>;

    return Post(
      username: snapshot['username'],
      uid: snapshot['uid'],
      desciption: snapshot['description'],
      postId : snapshot['postId'],
      datePublished : snapshot['datePublished'],
      postURL : snapshot['postURL'],
      profImage : snapshot['profImage'],
      likes : snapshot['likes'],
    );
  }
}