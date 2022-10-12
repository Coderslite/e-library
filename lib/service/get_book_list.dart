import 'dart:convert';

import 'package:e_library/constant/base_url.dart';
import 'package:e_library/model/book_list_model.dart';
import 'package:http/http.dart' as http;

Future<List<BookListModel>> getBookList() async {
  var response =
      await http.get(Uri.parse("$baseUrl/book_list.php"));
  var userData = jsonDecode(response.body);
  List books = userData['data'];
  if (userData['status'] == true) {
    return books.map((e) => BookListModel.fromJson(e)).toList();
  }
  else{
   throw Exception(response.statusCode);
  }
}
