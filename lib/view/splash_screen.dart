import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_library/providers/story_library.dart';
import 'package:music_library/view/strories.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String id = "SplashScreen";
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<StoryProvider>().getList();
    Timer(const Duration(milliseconds: 500), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Strories(),
          ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 20,
            ),
            Text(
              "TAGH",
              style: TextStyle(
                  fontSize: 50,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 40,
            )
          ],
        ),
      ),
    );
  }
}
