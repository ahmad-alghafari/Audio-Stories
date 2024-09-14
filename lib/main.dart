import 'package:flutter/material.dart';
import 'package:music_library/providers/story_library.dart';
import 'package:music_library/view/book_show.dart';
import 'package:music_library/view/strories.dart';
import 'package:music_library/view/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => StoryProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
        routes: {
          SplashScreen.id: (context) => const SplashScreen(),
          BookShow.id: (context) => const BookShow(),
          Strories.id: (context) => const Strories(),
        },
      ),
    );
  }
}
