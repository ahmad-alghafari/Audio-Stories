import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../controllers/book.dart';
import '../models/book.dart';

import 'dart:async';

import 'package:just_audio/just_audio.dart';

class StoryProvider extends ChangeNotifier {
  // ----var---
  int currentIndex = 1;
  double sliderValue = 00.0;
  double? intLength;
  bool is_loading = true;
  List<Book> list = [];
  int lastBook = 0;
  bool isLoobing = false;
  Book book = Book(
    id: -1,
    writer: "Unknown",
    title: "Unknown",
    teller: "Unknown",
    length: "Unknown",
    size: "Unknown",
    path: "Unknown",
  );
  final player = AudioPlayer();
  Duration position = Duration.zero;
  Duration duration = Duration.zero;

  // ----methods-----
  void playering() {
    print(
        "playing ------------------------------------path:${book.path}------id:${book.id}");
    player.setUrl(book.path);
    player.positionStream.listen((p) {
      position = p;
      notifyListeners();
    });

    player.durationStream.listen((d) {
      duration = d!;
      notifyListeners();
    });

    player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        if (getIsLoobing()) {
          print('-----------------next ');
          nextStory();
        } else {
          print('-----------------stop ');
          position = Duration.zero;
          player.pause();
          player.seek(position);
          notifyListeners();
        }
      }
    });
  }

  void nextStory() {
    player.pause();
    if (lastBook + 1 == list.length) {
      lastBook = 0;
    } else {
      lastBook++;
    }
    book = list[lastBook];
    setBook(lastBook + 1);

    duration = Duration.zero;
    position = Duration.zero;

    playering();
    player.play();
    notifyListeners();
  }

  void prevStory() {
    player.pause();
    if (lastBook == 0) {
      lastBook = list.length - 1;
    } else {
      lastBook--;
    }
    book = list[lastBook];
    setBook(lastBook + 1);

    duration = Duration.zero;
    position = Duration.zero;

    playering();
    player.play();
    notifyListeners();
  }

  String formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return "${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}";
  }

  void handleSeek(double value) {
    player.seek(Duration(seconds: value.toInt()));
    notifyListeners();
  }

  Future<void> getList() async {
    SharedPreferences loob = await SharedPreferences.getInstance();
    isLoobing = loob.getBool("loobBool") ?? true;

    var bookController = BookController();
    var response = await bookController.get();
    response.forEach((json) {
      list.add(Book.toJon(json));
      print(json);
    });

    SharedPreferences file = await SharedPreferences.getInstance();
    lastBook = file.getInt("bookId") ?? 1;
    lastBook--; // first index in list is 0 not 1
    book = list[lastBook];

    print(book.path.toString());
    playering();

    setIsLoading(false);
    notifyListeners();
  }

  void play() {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
    notifyListeners();
  }

  bool isLoading() {
    return is_loading;
  }

  void setIsLoading(bool loading) {
    is_loading = loading;
  }

  void setPage(int index) {
    lastBook = index;
    book = list[index];
    setCurrentIndex(0);
    setBook(lastBook + 1);

    playering();
    player.play();
    notifyListeners();
  }

  String titleOfAllStory(index) {
    int alpha = 19;
    if (list[index].title.length > alpha) {
      var name = list[index].title.substring(0, alpha);
      return "$name..";
    } else {
      return list[index].title;
    }
  }

  Future<void> setBook(int id) async {
    SharedPreferences file = await SharedPreferences.getInstance();
    file.setInt("bookId", id);
  }

  String titleOfOneStory() {
    int alpha = 13;
    if (book.title.length > alpha) {
      var name = book.title.substring(0, alpha);
      return "$name..";
    } else {
      return book.title;
    }
  }

  String calcTimer(double value) {
    double time = value;
    String left =
        time.toInt() < 10 ? "0${time.toInt()}" : (time.toInt()).toString();
    int temp = (((time - time.toInt()) * 60).toInt());
    String right = temp < 10 ? "0$temp" : temp.toString();
    return "$left:$right";
  }

  double maxLength(String maxLength) {
    String hours = maxLength.substring(0, 2);
    String minute = maxLength.substring(3, 5);

    String seconds = maxLength.substring(6, 8);

    double minuets = (double.parse(hours) * 60) +
        double.parse(minute) +
        (double.parse(seconds) / 60);
    return minuets;
  }

  int getCurrentIndex() {
    return currentIndex;
  }

  void setCurrentIndex(int index) {
    currentIndex = index;
  }

  void setSliderValue(double value) {
    sliderValue = value;
    player.seek(Duration(seconds: value.toInt()));
    notifyListeners();
  }

  void setIsLoobing() {
    isLoobing = getIsLoobing() ? false : true;
    setLoobing();
    notifyListeners();
  }

  Future<void> setLoobing() async {
    SharedPreferences loob = await SharedPreferences.getInstance();
    loob.setBool("loobBool", isLoobing);
  }

  bool getIsLoobing() {
    return isLoobing;
  }
}
