import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //body: Text('Login Screen'),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // svg image
              SvgPicture.asset(
                'assets/icon_instagram.svg',
                height: 64,
                 ),
              // text field
              const SizedBox(height: 64,), 

            ],
          ),
        ),
      ),
    );
  }
}