
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/repository/login_service.dart';
import 'package:siapprint/screen/navigation/toolbar_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class RegisterPage extends StatefulWidget {

  static String tag = 'register-page';

  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _RegisterPage();

}

class _RegisterPage extends State<RegisterPage> {

  final bool _isLoading = false;

  final LoginService _service = LoginService();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();
  final TextEditingController _controllerRePassword = TextEditingController();

  @override
  void initState() {
    _controllerEmail.text = '';
    _controllerPassword.text = '';
    _controllerUsername.text = '';
    _controllerRePassword.text = '';

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final email = TextFormField(
      controller: _controllerEmail,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final username = TextFormField(
      controller: _controllerUsername,
      keyboardType: TextInputType.text,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Username',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      controller: _controllerPassword,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final rePassword = TextFormField(
      controller: _controllerRePassword,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Ulangi password',
        contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final loginButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: _service.is_loading ? const Center(
        child: CircularProgressIndicator(),
      ) :
      ElevatedButton(
        style: ButtonStyle(
            padding: MaterialStateProperty.all<EdgeInsets>(const EdgeInsets.all(15)),
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: const BorderSide(color: Colors.transparent)
                )
            )
        ),
        onPressed: () async {

          String msg = '';
          if (_controllerEmail.text.isEmpty) {
            msg = 'Email wajib diisi';
          } else if (_controllerUsername.text.isEmpty) {
            msg = 'Username wajib diisi';
          } else if (_controllerPassword.text.isEmpty) {
            msg = 'Password wajib diisi';
          } else if (_controllerRePassword.text.isEmpty) {
            msg = 'Ulangi password wajib diisi';
          }

          if (msg.isEmpty) {

            setState((){
              _service.is_loading = true;
            });

            final response = await _service.register(_controllerUsername.text, _controllerEmail.text, _controllerPassword.text, _controllerRePassword.text).then((value) {

              setState((){
                _service.is_loading = false;
              });

              final data = jsonDecode(value);
              if (data['status'] as int == 0) {

                Dialogs.materialDialog(
                    context: context,
                    barrierDismissible: false,
                    actions: [
                      Container(
                        child: Column(
                          children: [
                            const Text('Akun berhasil dibuat, silahkan login ulang.'),
                            TextButton(
                              child: const Text(
                                'Masuk',
                                style: TextStyle(color: Colors.black54),
                              ),
                              onPressed: () {
                                Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                              },
                            )
                          ],
                        ),
                      )
                    ]
                );

              } else {
                _controllerUsername.text = '';
                _controllerRePassword.text = '';
              }

            }).onError((error, stackTrace){

              _controllerUsername.text = '';
              _controllerRePassword.text = '';

              final snackBar = SnackBar(content: Text(error.toString()));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);

              setState((){
                _service.is_loading = false;
              });

            });
          } else {

            final snackBar = SnackBar(content: Text(msg));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

          }

        },
        child: const Text('Register'),
        // child: _isLoading ? const CircularProgressIndicator() : const Text('Log In'),
      ),
    );

    final signLabel = TextButton(
      child: const Text(
        'Sudah terdaftar? Sign In',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
            child: Column(
              children: [

                ToolbarWidget.addToolbar(context, 'Register'),

                Expanded(child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.only(left: 23, right: 24, top: 10),
                  children: <Widget>[

                    email,
                    const SizedBox(height: 8.0),

                    username,
                    const SizedBox(height: 8.0),

                    password,
                    const SizedBox(height: 8.0),

                    rePassword,
                    const SizedBox(height: 10.0),

                    loginButton,
                    signLabel,
                  ],
                ))
              ],
            ),
          ),
        )
    );

  }

  _launchURLForgot() async {
    if (!await launchUrl(Uri.parse(Constant.web_forgot), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${Constant.web_forgot}';
    }
  }

}