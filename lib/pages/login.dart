import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topicos_p2/models/user.dart';
import 'package:topicos_p2/pages/home.dart';
import 'package:topicos_p2/pages/register.dart';
import 'package:topicos_p2/services/login_service.dart';

const USER_STORAGE_KEY = 'user';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var username = new TextEditingController();
  var password = new TextEditingController();

  var _activeRequest = false;

  _LoginPageState() {
    _checkIfAlreadyLoggedIn();
  }

  _checkIfAlreadyLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    String userPref = prefs.getString(USER_STORAGE_KEY) ?? '{}';
    Map<String, dynamic> user = jsonDecode(userPref);

    if (user.keys.isNotEmpty) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
      );
    }
  }

  _toggleActiveRequest(bool newState) {
    setState(() {
      _activeRequest = newState;
    });
  }

  login() async {
    _toggleActiveRequest(true);

    try {
      final user = await LoginService().login(new User(null, username.text, password.text));
      _toggleActiveRequest(false);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString(
        USER_STORAGE_KEY,
        jsonEncode(user.toMap()),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (BuildContext context) => HomePage()),
      );
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error trying to login')));
      _toggleActiveRequest(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          margin: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              TextField(
                controller: username,
                decoration: InputDecoration(
                  labelText: 'Username',
                  border: UnderlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                ),
              ),
              TextField(
                controller: password,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  border: UnderlineInputBorder(),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                ),
              ),
              Container(
                margin: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed:
                          _activeRequest ? null : () async => await login(),
                      child: const Text('Login'),
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                      ),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(16),
                        child: Text(
                          'Sign up instead',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()),
                        );
                      },
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
