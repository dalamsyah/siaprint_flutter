
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/model/user_model.dart';
import 'package:siapprint/repository/login_service.dart';
import 'package:siapprint/screen/home_page.dart';
import 'package:siapprint/screen/naivgation/app_navigation.dart';
import 'package:siapprint/screen/naivgation/bottom_bar.dart';

class LoginPage extends StatefulWidget {

  static String tag = 'login-page';

  @override
  State<StatefulWidget> createState() => _LoginPage();

}

class _LoginPage extends State<LoginPage> {

  bool _isLoading = false;

  final LoginService _service = LoginService();
  TextEditingController _controllerLogin = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    // _controllerLogin.text = 'raimunsuandi';
    // _controllerPassword.text = 'nowomennocry1234';
    _controllerLogin.text = 'test2';
    _controllerPassword.text = 'dimas123456';


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      controller: _controllerLogin,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _controllerPassword,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child:
      ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.transparent)
                )
            )
        ),
        onPressed: () async {

          setState((){
            _isLoading = true;
          });

          var response = await _service.login(_controllerLogin.text, _controllerPassword.text);

          var data = jsonDecode(response.body);
          final snackBar = SnackBar(
            content: Text(data['message']),
          );

          if (response.statusCode == 200) {
            SharedPreferences localStorage = await SharedPreferences.getInstance();

            if (!mounted) return;

            if (data['status'] as int == 0) {
              localStorage.setString('user', jsonEncode(data['result']['user']));

              Navigator.of(context).pushNamedAndRemoveUntil(AppNavigation.tag, (route) => false);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          } else {

            if (!mounted) return;

            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }

          setState((){
            _isLoading = false;
          });

          // Navigator.of(context).pushNamed(BottomPage2.tag);
        },
        child: const Text('Log In'),
        // child: _isLoading ? const CircularProgressIndicator() : const Text('Log In'),
      ),
    );

    final forgotLabel = TextButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),
            email,
            SizedBox(height: 8.0),
            password,
            SizedBox(height: 24.0),
            loginButton,
            forgotLabel
          ],
        ),
      ),
    );

  }

}