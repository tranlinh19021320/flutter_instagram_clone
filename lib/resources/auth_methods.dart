import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_instagram_clone/resources/storage_methods.dart';
import 'package:flutter_instagram_clone/models/user.dart' as model;
class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<model.User> getUserDetails() async {
    User currentUser = _auth.currentUser!;

    DocumentSnapshot snap = await _firestore.collection('users').doc(currentUser.uid).get();

    return model.User.fromSnap(snap);
  }
  // sign up user
  Future<String> signUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String res = "Some error occurred";
    try {
      if(email.isNotEmpty || password.isNotEmpty || username.isNotEmpty || bio.isNotEmpty) {
        //register user
        UserCredential cred = await _auth.createUserWithEmailAndPassword(email: email, password: password);
        
        print(cred.user!.uid);

        String photoURL = await StorageMethods().uploadImageToStorage("profilePic", file, false);

        model.User user = model.User(
          email: email, 
          uid: cred.user!.uid, 
          photoURL: photoURL, 
          username: username, 
          bio: bio, 
          followers: [], 
          following: [],
          );
        //add user to our database
        await _firestore.collection('users').doc(cred.user!.uid).set(user.toJson(),);

       
        // await _firestore.collection('users').add({
        //   'username': username,
        //   'uid' : cred.user!.uid,
        //   'email' : email,
        //   'bio' : bio,
        //   'followers' : [],
        //   'following' : [],

        // });
        

        //
        res = 'success';



      }
    } on FirebaseAuthException catch(e) {
      if (e.code == 'invalid-email') {
        res = 'The email is badly formatted';
      } else if (e.code == 'weak-password') {
        res = 'Password should be at least 6 characters';
      }
    }
    
    catch (err) {
      res = err.toString();
    }

    return res;
  }

  //login in user
  Future<String> loginUser({
    required String email,
    required String password,
  }) async {
    String res = "Some error occurred";

    try {
      if(email.isNotEmpty || password.isNotEmpty) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        res = "success";
      } else {
        res = "Please enter all the field";
      }
    } 
    catch (err) {
      res = err.toString();

    }
    return res;

  }

  Future<void> signOut() async{
    await _auth.signOut();  
  }
}
