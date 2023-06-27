import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_instagram_clone/responsive/mobile_screen_layout.dart';
import 'package:flutter_instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:flutter_instagram_clone/responsive/web_screen_layout.dart';
import 'package:flutter_instagram_clone/screens/login_screen.dart';
import 'package:flutter_instagram_clone/utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'AIzaSyAbO8j8UcRwmtFUrTiceE03eYq4qzQCQ0k',
        appId: "1:6347460354:web:493cbe0c5a49e8c1c6bc1b", 
        messagingSenderId: "6347460354", 
        projectId: "instagram-clone-e097f",
        storageBucket: "instagram-clone-e097f.appspot.com",
      ),
    );
  } else {
  await Firebase.initializeApp();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Instagram Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: whiteColor,
      ),
      /*home: ResponsiveLayout(
        webScreenLayout: WebScreenLayout(),
        mobileScreenLayout: MobileScreenLayout(),
      ), */
      home: LoginScreen(),
    );
  }
}

