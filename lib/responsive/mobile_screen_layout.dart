import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/notification_sceen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';
import '../utils/utils.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
  int _page = 0;
  late PageController pageController = PageController();
  int _notif = 0;

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {});
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

 void getNotif(String uid) async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('notifications')
          .where('uid', isEqualTo: uid)
          .get();
      print(snapshot.docs.length);
      _notif = snapshot.docs.length;
      
    } catch (e) {
      showSnackBar(e.toString(), context);
    }
    
  }

  @override
  Widget build(BuildContext context) {
    final User user = Provider.of<UserProvider>(context).getUser;

    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          const FeedScreen(),
          const SearchScreen(),
          const AddPostScreen(),
          const NotificationScreen(),
          ProfileScreen(
            uid: user.uid,
          ),
        ],
      ),
      bottomNavigationBar: CupertinoTabBar(
        backgroundColor: black0Color,
        items: [
          BottomNavigationBarItem(
              icon: Icon(
                Icons.home,
                color: _page == 0 ? whiteColor : greyColor,
              ),
              label: '',
              backgroundColor: whiteColor),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: _page == 1 ? whiteColor : greyColor,
            ),
            label: '',
            backgroundColor: whiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: _page == 2 ? whiteColor : greyColor,
            ),
            label: '',
            backgroundColor: whiteColor,
          ),
          BottomNavigationBarItem(
            label: '',
            icon: Icon(
              Icons.notification_add,
              color: _page == 3 ? whiteColor : greyColor,
            ),

            
            
            backgroundColor: whiteColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: _page == 4 ? whiteColor : greyColor,
            ),
            label: '',
            backgroundColor: whiteColor,
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
