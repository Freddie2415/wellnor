import 'package:meta/meta.dart';
import 'dart:convert' as convert;
import 'package:wellnor/constants.dart';
import 'package:http/http.dart' as http;
import 'package:wellnor/keystore.dart';
import 'package:wellnor/models/models.dart';

class UserRepository {
  JwtTokenStore jwtTokenStore = JwtTokenStore();

  Future<String> authenticate({
    @required String username,
    @required String password,
  }) async {
    var response = await http
        .post(kApiAuthUrl, body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      Map body = convert.jsonDecode(response.body);
      return body['access'];
    } else {
      return throw 'Проверьте логин и пароль!';
    }
  }

  Future<void> deleteToken() async {
    return jwtTokenStore.deleteToken();
  }

  Future<void> persistToken(String token) async {
    jwtTokenStore.setToken(token);
  }

  Future<bool> hasToken() async {
    return jwtTokenStore.hasToken;
  }

  Future<User> getUser() async {
    const url = "${kApiUrl}/auth/users/me/";
    Map<String, String> headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer ${jwtTokenStore.getToken()}'
    };

    var response = await http.get(url, headers: headers);
    final Map userData = convert.jsonDecode(response.body) as Map;
    print(userData);
    final User user = User(
        id: userData['id'],
        name: userData['username'],
        email: userData['email']);
    print(user);
    return user;
  }
}
