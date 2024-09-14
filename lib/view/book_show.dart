import 'package:flutter/material.dart';
import 'package:music_library/providers/story_library.dart';
import 'package:provider/provider.dart';

class BookShow extends StatefulWidget {
  static String id = "0";
  const BookShow({super.key});

  @override
  State<BookShow> createState() => _BookShowState();
}

class _BookShowState extends State<BookShow> {
  void changePage(int id) {
    context.read<StoryProvider>().setCurrentIndex(id);
    Navigator.pushNamed(context, id.toString());
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color.fromRGBO(253, 104, 32, 1),
        title: const Text(
          "Now Playing",
          style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          MaterialButton(
            onPressed: () {},
            child: const Icon(
              Icons.queue_music,
              color: Colors.white,
              size: 30,
            ),
          )
        ],
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
      backgroundColor: const Color.fromRGBO(0, 4, 49, 1),
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: 180,
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(253, 104, 32, 1),
                    border: Border(
                      bottom: BorderSide(
                        width: 15,
                        color: Color.fromRGBO(103, 53, 67, 100),
                      ),
                    ),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: const CircleAvatar(
                    radius: 180,
                    backgroundImage: AssetImage("images/test.png"),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Consumer(
                  builder: (context, StoryProvider value, child) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  context
                                      .read<StoryProvider>()
                                      .titleOfOneStory(),
                                  style: const TextStyle(
                                    fontSize: 40,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  context.read<StoryProvider>().book.teller,
                                  style: const TextStyle(
                                      fontSize: 20, color: Colors.white30),
                                ),
                              ],
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {},
                              child: const Icon(
                                Icons.more_horiz,
                                color: Colors.white30,
                                size: 40,
                              ),
                            )
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              // context.read<StoryProvider>().calcTimer(
                              //     context.read<StoryProvider>().sliderValue),
                              context.read<StoryProvider>().formatDuration(
                                  context.read<StoryProvider>().position),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                            Expanded(
                              child: Slider(
                                min: 0.0,
                                max: context
                                    .read<StoryProvider>()
                                    .duration
                                    .inSeconds
                                    .toDouble(),

                                value: context
                                    .read<StoryProvider>()
                                    .position
                                    .inSeconds
                                    .toDouble(),

                                onChanged: (value) {
                                  context
                                      .read<StoryProvider>()
                                      .handleSeek(value);
                                },

                                activeColor: Colors.white,
                                inactiveColor: Colors.white30,
                                // max: context.read<StoryProvider>().maxLength(
                                //     context.read<StoryProvider>().book.length),
                              ),
                            ),
                            Text(
                              // context.read<StoryProvider>().calcTimer(context
                              //     .read<StoryProvider>()
                              //     .maxLength(context
                              //         .read<StoryProvider>()
                              //         .book
                              //         .length)),

                              context.read<StoryProvider>().formatDuration(
                                  context.read<StoryProvider>().duration),
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 15),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.favorite,
                                  color: Color.fromRGBO(32, 255, 253, 1),
                                  size: 40,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<StoryProvider>().prevStory();
                                },
                                child: const Icon(
                                  Icons.skip_previous,
                                  size: 55,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            InkWell(
                              onTap: () {
                                context.read<StoryProvider>().play();
                              },
                              child: CircleAvatar(
                                radius: 40,
                                backgroundColor:
                                    const Color.fromRGBO(253, 104, 32, 1),
                                child: Icon(
                                  context.read<StoryProvider>().player.playing
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  size: 60,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<StoryProvider>().nextStory();
                                },
                                child: const Icon(
                                  Icons.skip_next,
                                  size: 55,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const Spacer(),
                            Expanded(
                              child: InkWell(
                                onTap: () {
                                  context.read<StoryProvider>().setIsLoobing();
                                },
                                child: Icon(
                                  Icons.autorenew,
                                  size: 35,
                                  color: context
                                          .read<StoryProvider>()
                                          .getIsLoobing()
                                      ? Colors.white
                                      : Colors.white30,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
