import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/storage_methods.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:uuid/uuid.dart';

import '../models/notification.dart';
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

  Future<void> likePost(String postId, String uid, List likes) async {
    try {
      if (likes.contains(uid)) {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid]),
        });
      } else {
        await _firestore.collection('posts').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid]),
        });
      }
    } catch (e) {
      print(
        e.toString(),
      );
    }
  }

  Future<void> postComment(String postId, String text, String uid, String name,
      String profilePic) async {
    try {
      if (text.isNotEmpty) {
        String commentId = const Uuid().v1();
        await _firestore
            .collection('posts')
            .doc(postId)
            .collection('comments')
            .doc(commentId)
            .set({
          'profilePic': profilePic,
          'name': name,
          'uid': uid,
          'text': text,
          'commentId': commentId,
          'datePublished': DateTime.now(),
        });

        postNotification(uid, postId, commentId);
      } else {
        print('Text is empty');
      }
    } catch (e) {
      print(e.toString());
    }
  }

  //delete post

  Future<void> deletePost(String postId) async {
    try {
      await _firestore.collection('posts').doc(postId).delete();

    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> followUser(String uid, String followId) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('users').doc(uid).get();
      List following = (snapshot.data()! as dynamic)['following'];

      if (following.contains(followId)) {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId]),
        });
      } else {
        await _firestore.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid]),
        });
        await _firestore.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId]),
        });
      }
    } catch (e) {
      print(e.toString());
    }
  }

  // notifications
  Future<void> postNotification(
      String uid, String postId, String commentId) async {
    String res = "Some error occurred";
    try {
      DocumentSnapshot snapshotPost =
            await _firestore.collection('posts').doc(postId).get();

      String postUserId = snapshotPost['uid'];

      if (uid != postUserId) {
        List likes = (snapshotPost.data()! as dynamic)['likes'];

        String notificationId = const Uuid().v1();
        print(likes.toString());
        NotificationUser notification = NotificationUser(
          notificationId: notificationId,
          uid: postUserId,
          postId: postId,
          commentId: commentId,
          datePublished: DateTime.now(),
          isLike: likes.contains(uid),
        );

        _firestore
            .collection('notifications')
            .doc(notificationId)
            .set(notification.toJson());
        res = 'success';
      } else {
        print('is my post');
      }
    } catch (e) {
      res = e.toString();
    }

    print(res + uid);
  }

  //delete notification
  Future<void> deleteNotification(String notificationId) async {
    try {
      await _firestore.collection('notifications').doc(notificationId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
