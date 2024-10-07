// import 'package:recipe_app/services/http_service.dart';

// class AuthService {
//   static final AuthService _singleton = AuthService._internal();

//   final _httpService = HTTPService();

//   factory AuthService() {
//     return _singleton;
//   }

//   AuthService._internal();

//   Future<bool> login(String username, String password) async {
//     try {
//       var response = await _httpService
//           .post("auth/login", {"username": username, "password": password});
//       print(response?.statusCode);
//     } catch (e) {
//       print(e);
//     }
//     throw {};
//   }
// }

import 'dart:convert'; // For jsonEncode and jsonDecode
import 'package:http/http.dart' as http;
import 'package:recipe_app/models/users.dart';
import 'package:recipe_app/services/consts.dart';

class AuthService {
  User? user;

  Future<bool> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$API_BASE_URL/auth/login"),
        headers: <String, String>{
          'Content-Type': 'application/json',
        },
        body: jsonEncode(<String, dynamic>{
          'username': username,
          'password': password,
          'expiresInMins': 30, // Optional parameter
        }),
      );

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        user = User.fromJson(jsonResponse);
        String? accessToken = jsonResponse['accessToken'];
        print(user);
        // Handle the login response, e.g., store token, check user info, etc.
        print(jsonResponse);

        return true; // Return true if login is successful
      } else {
        // Handle errors like wrong username/password
        print('Login failed with status code: ${response.statusCode}');
        return false;
      }
    } catch (e) {
      print('An error occurred: $e');
      return false;
    }
  }
}
