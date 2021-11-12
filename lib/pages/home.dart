import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:topicos_p2/pages/login.dart';

const USER_STORAGE_KEY = 'user';

class HomePage extends StatelessWidget {

  _logout(context) async {
    final prefs = await SharedPreferences.getInstance();

    prefs.remove(USER_STORAGE_KEY);

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home page')),
      body: Center(
        child: Column(children: [
          Text(
            'Logged in',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              color: Colors.blue
            ),
          ),
          GestureDetector(
            child: Container(
              margin: EdgeInsets.all(24),
              child: Text('Logout'),
            ),
            onTap: () => _logout(context),
          ),
        ]),
      ),
    );
  }
}
