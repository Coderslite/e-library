import 'dart:convert';

import 'package:e_library/constant/base_url.dart';
import 'package:e_library/model/user_profile_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

Future<UserProfileModel> getUserProfile() async {
  var prefs = await SharedPreferences.getInstance();
  var email = prefs.getString("email");
  var response =
      await http.post(Uri.parse("$baseUrl/fetch_user_profile.php"), body: {
    "email": email,
  });
  var userData = jsonDecode(response.body);
  var userInfo = userData['data'];

  if (userData['status'] == true) {
    return UserProfileModel.fromJson(userInfo);
  } else {
    throw Exception(response.statusCode);
  }
}
