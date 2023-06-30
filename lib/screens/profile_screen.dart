import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/resources/auth_methods.dart';
import 'package:flutter_instagram_clone/resources/firestore_methods.dart';
import 'package:flutter_instagram_clone/screens/login_screen.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/utils.dart';
import 'package:flutter_instagram_clone/widgets/follow_button.dart';

class ProfileScreen extends StatefulWidget {
  final String uid;

  const ProfileScreen({Key? key, required this.uid}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  int postLen = 0;
  String myid = FirebaseAuth.instance.currentUser!.uid;

  Future<void> init() async {
    try {
      var postSnap = await FirebaseFirestore.instance
          .collection('posts')
          .where('uid', isEqualTo: widget.uid)
          .get();
      postLen = postSnap.docs.length;

      setState(() {});
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
  }

  bool isFollowing(DocumentSnapshot dataSnapshot) {
    return (dataSnapshot)['followers'].contains(myid);
  }

  @override
  void initState() {
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .doc(widget.uid)
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return Scaffold(
            appBar: AppBar(
              backgroundColor: black0Color,
              title: Text((snapshot.data! as dynamic)['username']),
              centerTitle: false,
              actions: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.message,
                          color: blueColor,
                        ),
                      ),
                      if (myid == widget.uid)
                        IconButton(
                          onPressed: () async {
                            await AuthMethods().signOut();

                            if (context.mounted) {
                            
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => const LoginScreen(),
                              ));
                            }
                            ;
                          },
                          icon: const Icon(
                            Icons.logout,
                            color: blueColor,
                          ),
                        ),
                    ],
                  ),
                )
              ],
            ),
            body: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            backgroundColor: greyColor,
                            backgroundImage: NetworkImage(
                                (snapshot.data! as dynamic)['photoURL']),
                            radius: 40,
                          ),
                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    buildStatColumn(postLen, 'posts'),
                                    buildStatColumn(
                                        (snapshot.data! as dynamic)['followers']
                                            .length,
                                        'followers'),
                                    buildStatColumn(
                                        (snapshot.data! as dynamic)['following']
                                            .length,
                                        'following'),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    myid == widget.uid
                                        ? FollowButton(
                                            text: 'Edit Profile',
                                            backgroundColor: black0Color,
                                            textColor: whiteColor,
                                            borderColor: greyColor,
                                            function: () {},
                                          )
                                        : isFollowing(snapshot.data! as dynamic)
                                            ? FollowButton(
                                                text: 'Unfollow',
                                                backgroundColor: whiteColor,
                                                textColor: black0Color,
                                                borderColor: greyColor,
                                                function: () async {
                                                  await FirestoreMethods()
                                                      .followUser(
                                                          myid, widget.uid);
                                                  setState(() {});
                                                },
                                              )
                                            : FollowButton(
                                                text: 'Follow',
                                                backgroundColor: blueColor,
                                                textColor: whiteColor,
                                                borderColor: blueColor,
                                                function: () async {
                                                  await FirestoreMethods()
                                                      .followUser(
                                                          myid, widget.uid);
                                                  setState(() {});
                                                },
                                              )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          (snapshot.data! as dynamic)['username'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.only(top: 1),
                        child: Text(
                          (snapshot.data! as dynamic)['bio'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: greyColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection('posts')
                      .where('uid', isEqualTo: widget.uid)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return GridView.builder(
                      shrinkWrap: true,
                      itemCount: (snapshot.data! as dynamic).docs.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        crossAxisSpacing: 5,
                        mainAxisSpacing: 1.5,
                        childAspectRatio: 1,
                      ),
                      itemBuilder: (context, index) {
                        DocumentSnapshot snap =
                            (snapshot.data! as dynamic).docs[index];

                        return Container(
                          child: Image(
                            image: NetworkImage(snap['postURL']),
                            fit: BoxFit.cover,
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        });
  }

  Column buildStatColumn(int num, String lablel) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          num.toString(),
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 4,
          ),
          child: Text(
            lablel,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w400,
              color: greyColor,
            ),
          ),
        )
      ],
    );
  }
}
