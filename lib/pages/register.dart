import 'package:flutter/material.dart';
import 'package:topicos_p2/models/user.dart';
import 'package:topicos_p2/services/login_service.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var username = new TextEditingController();
  var password = new TextEditingController();

  var _activeRequest = false;

  _toggleActiveRequest(bool newState) {
    setState(() {
      _activeRequest = newState;
    });
  }

  register() async {
    _toggleActiveRequest(true);
    try {
      await LoginService()
          .register(new User(null, username.text, password.text));
      _toggleActiveRequest(false);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Successfully signed up')));
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Error trying to sign up')));
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
                      'Sign Up',
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
                          _activeRequest ? null : () async => await register(),
                      child: const Text('Sign Up'),
                    ),
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.all(16),
                        child: Text(
                          'Login instead',
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    ),
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
