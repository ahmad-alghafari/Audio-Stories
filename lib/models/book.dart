import 'package:flutter/cupertino.dart';

class Book {
  int id;
  String writer;
  String title;
  String teller;
  String length;
  String size;
  String path;

  Book({
    required this.id,
    required this.writer,
    required this.title,
    required this.teller,
    required this.length,
    required this.size,
    required this.path,
  });

  factory Book.toJon(Map<String, dynamic> json) {
    return Book(
      id: json['id'] ?? -1,
      size: json['size'] ?? "",
      length: json['length'] ?? "",
      path: json['mp3'] ?? "no path",
      teller: json['teller'] ?? "",
      title: json['title'] ?? "",
      writer: json['writer'] ?? "",
    );
  }
}
