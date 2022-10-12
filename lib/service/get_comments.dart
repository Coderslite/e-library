import 'dart:convert';

import 'package:e_library/model/comment_model.dart';
import 'package:http/http.dart' as http;

Future<List<CommentModel>> getComments(String id) async {
  var response = await http.post(Uri.parse("https://activeglobalfx.com/e-library/fetch_comment.php"),
  body: {
    "bookId":id,
  });
  var userData = jsonDecode(response.body);
  if (userData['status'] == true) {
    List commentList = userData['data'];
    return commentList.map((e) => CommentModel.fromJson(e)).toList();
  } else {
    throw Exception(response.reasonPhrase);
  }
}
