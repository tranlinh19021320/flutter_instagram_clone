import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_instagram_clone/utils/global_variables.dart';

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
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
      
    });
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: homeScreenItems,
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
            icon: Icon(
              Icons.favorite,
              color: _page == 3 ? whiteColor : greyColor,
            ),
            label: '',
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
