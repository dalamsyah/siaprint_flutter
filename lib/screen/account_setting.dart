import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/screen/login_page.dart';

class AccountSettingPage extends StatefulWidget {

  const AccountSettingPage({ Key? key }) : super(key: key);

  static String tag = 'account-setting-page';
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
                        "Common",
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
                  GestureDetector(
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
                          builder: (BuildContext context) => LoginPage(),
                        ),
                            (route) => false,
                      );

                    },
                  ),

                ],
              )
          ),
        )
    );

  }

}