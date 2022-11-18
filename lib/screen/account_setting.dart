import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/config/constant.dart';
import 'package:siapprint/model/user_model.dart';
import 'package:siapprint/screen/login_page.dart';
import 'package:siapprint/screen/navigation/toolbar_widget.dart';
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

  late SharedPreferences localStorage;
  late UserModel userModel;
  String login = '';

  @override
  void initState() {
    super.initState();
    getUser();
  }

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

                    ToolbarWidget.addToolbar(context, 'Akun'),

                    Container(
                      padding: const EdgeInsets.only(left: 20, right: 20),
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
                      child: ListTile(
                        leading: Icon(Icons.logout),
                        title: Text("Logout"),
                        subtitle: Text(login),
                      ),
                      onTap: () async {
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

                      },
                    ),



                  ],
                )
            ),
          ),
        )
    );

  }

  getUser() async {
    localStorage  = await SharedPreferences.getInstance();
    userModel = UserModel.fromJson(jsonDecode(localStorage.getString('user')!));

    setState((){
      login = userModel.username!;
    });
  }

  _launchURLEditProfile() async {
    if (!await launchUrl(Uri.parse(Constant.web_editprofile), mode: LaunchMode.externalApplication)) {
      throw 'Could not launch ${Constant.web_editprofile}';
    }
  }

}