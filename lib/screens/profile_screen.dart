import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: black0Color,
        title: Text('username'),
        centerTitle: false,
      ),

      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: greyColor,
                      backgroundImage: NetworkImage('https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1-744x744.jpg'),
                      radius: 40,
                    ),


                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}