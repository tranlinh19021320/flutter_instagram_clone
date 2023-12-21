import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/user_provider.dart';
import '../screens/add_post_screen.dart';
import '../screens/feed_screen.dart';
import '../screens/notification_sceen.dart';
import '../screens/profile_screen.dart';
import '../screens/search_screen.dart';

class WebScreenLayout extends StatefulWidget {
  const WebScreenLayout({super.key});

  @override
  State<WebScreenLayout> createState() => _WebScreenLayoutState();
}

class _WebScreenLayoutState extends State<WebScreenLayout> {
   int _page = 0;
  late PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
    setState(() {
      _page = page;
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final User user = Provider.of<UserProvider>(context).getUser;

    return  Scaffold(
      appBar: AppBar(
         backgroundColor: black18Color,
        centerTitle: false,
        title: SvgPicture.asset(
          'assets/ic_instagram.svg',
          color: whiteColor,
          height: 32,
        ),
        actions: [
          IconButton(
            onPressed: () => navigationTapped(0),
            icon: Icon(
              Icons.home,
              color: _page == 0 ? whiteColor : greyColor,
            ),
          ),

          IconButton(
            onPressed: () => navigationTapped(1),
            icon: Icon(
              Icons.search,
              color: _page == 1 ? whiteColor : greyColor,
            ),
          ),

          IconButton(
            onPressed: () => navigationTapped(2),
            icon: Icon(
              Icons.add_a_photo,
              color: _page == 2 ? whiteColor : greyColor,
            ),
          ),

          IconButton(
            onPressed: () => navigationTapped(3),
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? whiteColor : greyColor,
            ),
          ),

          IconButton(
            onPressed: () => navigationTapped(4),
            icon: Icon(
              Icons.person,
              color: _page == 4 ? whiteColor : greyColor,
            ),
          ),
        ],
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children:  [
          const FeedScreen(),
          const SearchScreen(),
          const AddPostScreen(),
          const NotificationScreen(),
          ProfileScreen(
            uid: user.uid,
          ),
        ],
      )
    );
  }
}