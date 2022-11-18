
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/repository/login_service.dart';
import 'package:siapprint/screen/navigation/single_navigation.dart';
import 'package:siapprint/screen/regsiter_page.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginPage extends StatefulWidget {

  static String tag = 'login-page';

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _LoginPage();

}

class _LoginPage extends State<LoginPage> {

  final bool _isLoading = false;

  final LoginService _service = LoginService();
  final TextEditingController _controllerLogin = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  @override
  void initState() {
    _controllerLogin.text = 'dimasdimas';
    _controllerPassword.text = 'dimas123456';
    // _controllerLogin.text = 'test2';
    // _controllerPassword.text = 'dimas123456';


    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 60.0,
        child: Image.asset('assets/logo.png'),
      ),
    );

    final email = TextFormField(
      controller: _controllerLogin,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
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

          setState((){
            _service.is_loading = true;
          });

          final response = await _service.login(_controllerLogin.text, _controllerPassword.text).then((value) {

            setState((){
              _service.is_loading = false;
            });

            final data = jsonDecode(value);
            final snackBar = SnackBar(content: Text(data['message']));

            if (data['status'] as int == 0) {
              Navigator.of(context).pushNamedAndRemoveUntil(SingleNavigationPage.tag, (route) => false);
            } else {

              String msg = data['message'];
              if (data['message'].toString().contains('Akun pengguna ini belum diaktifkan.')){
                msg = 'Akun pengguna ini belum diaktifkan, silahkan aktifasi melalu link yang kamu berikan melalui email.';
              }

              Dialogs.materialDialog(
                  context: context,
                  actions: [
                    Container(
                      child: Column(
                        children: [
                          const Text('Error'),
                          const SizedBox(height: 8.0),
                          Text(msg),
                          TextButton(
                            child: const Text(
                              'Kirim ulang pesan aktifasi sekali lagi',
                              style: const TextStyle(color: Colors.black54),
                            ),
                            onPressed: () {

                              Navigator.pop(context);

                              showProgress(true);

                              _service.resendactivation(_controllerLogin.text).then((value) {

                                Navigator.pop(context);

                                Dialogs.materialDialog(
                                    context: context,
                                    actions: [
                                      Container(
                                        child: Column(
                                          children: [
                                            const Text('Pesan'),
                                            const SizedBox(height: 8.0),
                                            Text('$value'),
                                            TextButton(
                                              child: const Text(
                                                'Tutup',
                                                style: TextStyle(color: Colors.black54),
                                              ),
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          ],
                                        ),
                                      )
                                    ]
                                );


                              }).onError((error, stackTrace) {
                                Navigator.pop(context);
                              });
                            },
                          ),

                        ],
                      ),
                    )
                  ]
              );

              // ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }

          }).onError((error, stackTrace){

            final snackBar = SnackBar(content: Text(error.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);

            setState((){
              _service.is_loading = false;
            });

          });


        },
        child: const Text('Masuk'),
        // child: _isLoading ? const CircularProgressIndicator() : const Text('Log In'),
      ),
    );

    final forgotLabel = TextButton(
      child: const Text(
        'Lupa password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        _launchURLForgot();
      },
    );

    final createAccountLabel = TextButton(
      child: const Text(
        'Butuh akun?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {
        Navigator.of(context).pushNamed(RegisterPage.tag);
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body:  Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            const SizedBox(height: 48.0),
            email,
            const SizedBox(height: 8.0),
            password,
            const SizedBox(height: 20.0),
            loginButton,
            createAccountLabel,
            forgotLabel,

            // showProgress(_service.is_loading)
          ],
        ),
      )
    );

  }

  _launchURLForgot() async {
    if (!await launchUrl(Uri.parse(Constant.web_forgot), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${Constant.web_forgot}';
    }
  }

  _launchURLAktifasi(String username) async {
    if (!await launchUrl(Uri.parse('${Constant.web_aktifasi}$username'), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${Constant.web_aktifasi}';
    }
  }

  showProgress(bool loading) {
    if (loading){
      return Dialogs.materialDialog(
          context: context,
          barrierDismissible: false,
          actions: [
            Container(
              child: Column(
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 10,),
                  Text('Mohon tunggu'),
                ],
              ),
            )
          ]
      );
    } else {
      return Container();
    }
  }

}