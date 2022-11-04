import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/main.dart';
import 'package:siapprint/screen/login_page.dart';
import 'package:siapprint/screen/naivgation/app_navigation.dart';
import 'package:siapprint/screen/naivgation/tab_navigator.dart';

typedef StringValue2 = Function();

class AccountSettingPage extends StatefulWidget {

  const AccountSettingPage({ Key? key, this.callback }) : super(key: key);

  static String tag = 'account-setting-page';
  final StringValue2? callback;

  @override
  State<StatefulWidget> createState() => _AccountSettingPage();

}

class _AccountSettingPage extends State<AccountSettingPage> {

  TextStyle headingStyle = const TextStyle(
      fontSize: 16, fontWeight: FontWeight.w600, color: Colors.red);

  bool lockAppSwitchVal = true;
  bool fingerprintSwitchVal = false;
  bool changePassSwitchVal = true;

  TextStyle headingStyleIOS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: CupertinoColors.inactiveGray,
  );
  TextStyle descStyleIOS = const TextStyle(color: CupertinoColors.inactiveGray);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 50),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Account",
                        style: headingStyleIOS,
                      ),
                    ],
                  ),
                  const ListTile(
                    leading: Icon(Icons.language),
                    title: Text("Language"),
                    subtitle: Text("English"),
                  ),
                  const Divider(),
                  InkWell(
                    child: const ListTile(
                      leading: Icon(Icons.account_circle),
                      title: Text("Logout"),
                    ),
                    onTap: () async {
                      SharedPreferences localStorage = await SharedPreferences.getInstance();
                      localStorage.remove('user');

                      if (!mounted) return;
                      // Navigator.of(context).pushNamed(LoginPage.tag);

                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => const LoginPage(),
                        ),
                            (route) => false,
                      );

                      // widget.callback;

                      // Navigator.pushReplacementNamed(context, 'login-page');
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      //         builder: (BuildContext context) => LoginPage(),
                      //       ), (route) => false);


                      // runApp( MyApp(home: LoginPage()) );

                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     'login-page', (Route<dynamic> route) => false);

                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (_) => LoginPage(),
                      //   ),
                      // );

                      // Navigator.of(context).pushNamedAndRemoveUntil(TabNavigatorRoutes.root, (route) => false);
                      // Navigator.of(context).pushNamedAndRemoveUntil('/login', (Route<dynamic> route) => false);

                    },
                  ),

                ],
              )
          ),
        )
    );

  }

}