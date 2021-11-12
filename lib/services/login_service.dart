import 'dart:convert';
import 'package:http/http.dart';
import 'package:topicos_p2/models/user.dart';

class LoginService {

  final String _api = 'http://localhost:3003/api/v1';

  Future<User> login(User user) async {
    final res = await post(Uri.parse('$_api/login'), body: user.toMap());
    if (res.statusCode == 200) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to login');
    }
  }

  Future<User> register(User user) async {
    final res = await post(Uri.parse('$_api/login/register'), body: user.toMap());
    if (res.statusCode == 201) {
      return User.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Failed to register');
    }
  }
}