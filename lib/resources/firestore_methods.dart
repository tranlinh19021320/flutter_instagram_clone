import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/resources/storage_methods.dart';
import 'package:uuid/uuid.dart';

import '../models/post.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //upload post
  Future<String> uploadPost(
    String desciption,
    Uint8List file,
    String uid,
    String username,
    String profImage,
  ) async {
    String res = "Some error occurred";
    try {
      String photoURL =
          await StorageMethods().uploadImageToStorage('posts', file, true);

      String postId = const Uuid().v1();
      Post post = Post(
        desciption: desciption,
        uid: uid,
        username: username,
        postId: postId,
        datePublished: DateTime.now(),
        postURL: photoURL,
        profImage: profImage,
        likes: [],
      );

      _firestore.collection('posts').doc(postId).set(
            post.toJson(),
          );
      res = 'success';
    } catch (e) {
      res = e.toString();
    }

    return res;
  }
}
