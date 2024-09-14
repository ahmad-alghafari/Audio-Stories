import 'package:flutter/material.dart';
import 'package:music_library/providers/story_library.dart';
import 'package:music_library/view/book_show.dart';
import 'package:provider/provider.dart';

class Strories extends StatefulWidget {
  static String id = '1';
  const Strories({super.key});

  @override
  State<Strories> createState() => _StroriesState();
}

class _StroriesState extends State<Strories> {
  void changePage(int id) {
    context.read<StoryProvider>().setCurrentIndex(id);
    Navigator.pushNamed(context, id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(0, 4, 49, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 4, 49, 1),
        foregroundColor: Colors.white,
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 10),
            child: const Icon(
              Icons.search,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
        title: const Text(
          "Stories List",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      bottomNavigationBar: Consumer(
        builder: (context, StoryProvider value, child) {
          return BottomNavigationBar(
            onTap: (int indexOfItem) {
              changePage(indexOfItem);
            },
            backgroundColor: Colors.black45,
            currentIndex: context.read<StoryProvider>().getCurrentIndex(),
            fixedColor: Colors.orange,
            iconSize: 40,
            unselectedIconTheme: const IconThemeData(
              color: Colors.white30,
            ),
            unselectedItemColor: Colors.white30,
            items: const [
              BottomNavigationBarItem(
                label: "Play",
                icon: Icon(
                  Icons.play_arrow,
                ),
              ),
              BottomNavigationBarItem(
                label: "Library",
                icon: Icon(
                  Icons.library_music,
                ),
              ),
            ],
          );
        },
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          child: Consumer(
            builder: (context, StoryProvider value, child) {
              return Column(
                children: [
                  const SizedBox(
                    height: 30,
                  ),
                  if (!context.read<StoryProvider>().isLoading())
                    Expanded(
                      child: ListView.separated(
                        shrinkWrap: true,
                        itemCount: context.read<StoryProvider>().list.length,
                        itemBuilder: (context, index) {
                          return MaterialButton(
                            onPressed: () {
                              context.read<StoryProvider>().setPage(index);
                              Navigator.pushNamed(context, BookShow.id);
                            },
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 15),
                              height: 60,
                              child: Row(
                                children: [
                                  Text(
                                    (index + 1).toString(),
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    width: 50,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        context
                                            .read<StoryProvider>()
                                            .titleOfAllStory(index),
                                        style: const TextStyle(
                                            color: Colors.orange, fontSize: 20),
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            context
                                                .read<StoryProvider>()
                                                .list[index]
                                                .writer,
                                            style: const TextStyle(
                                                color: Colors.white70,
                                                fontSize: 15),
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          const Icon(
                                            Icons.radio_button_checked_rounded,
                                            color: Colors.white,
                                            size: 10,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const Spacer(),
                                  const Icon(
                                    Icons.favorite,
                                    color: Colors.cyan,
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return const Divider(
                            color: Colors.white30,
                          );
                        },
                      ),
                    ),
                  if (context.read<StoryProvider>().isLoading())
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 1.5,
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: Colors.white,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
