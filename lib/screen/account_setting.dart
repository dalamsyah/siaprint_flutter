import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/screen/login_page.dart';
import 'package:url_launcher/url_launcher.dart';

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
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Account",
                            style: headingStyleIOS,
                          ),
                        ],
                      ),
                    ),

                    InkWell(
                      child: const ListTile(
                        leading: Icon(Icons.account_circle),
                        title: Text("Edit profile"),
                      ),
                      onTap: () {
                        _launchURLEditProfile();
                      },
                    ),

                    const Divider(),

                    InkWell(
                      child: const ListTile(
                        leading: Icon(Icons.logout),
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
          ),
        )
    );

  }

  _launchURLEditProfile() async {
    if (!await launchUrl(Uri.parse(Constant.web_editprofile), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${Constant.web_editprofile}';
    }
  }

}