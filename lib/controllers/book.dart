import 'dart:convert';

import 'package:http/http.dart' as http;

class BookController {
  int timeOut = 60;
  BookController();

  String urlPath = "https://loutf.net/training/stories/get_stories.php";

  Future get() async {
    try {
      var response = await http
          .get(Uri.parse(urlPath))
          .timeout(Duration(seconds: timeOut));
      if (response.statusCode == 200 || response.statusCode == 201) {
        return jsonDecode(response.body);
      }
    } catch (e) {
      return e.toString();
    }
  }
}
