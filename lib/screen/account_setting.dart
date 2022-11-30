import 'dart:convert';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
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

  String appName = '';
  String packageName = '';
  String version = '';
  String buildNumber = '';

  @override
  void initState() {
    super.initState();
    getUser();

    PackageInfo.fromPlatform().then((packageInfo) {

      print(packageInfo);

      setState((){
        print(packageInfo);
        appName = packageInfo.appName;
        packageName = packageInfo.packageName;
        version = packageInfo.version;
        buildNumber = packageInfo.buildNumber;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Expanded(child: SingleChildScrollView(
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

                        /*InkWell(
                          child: const ListTile(
                            leading: Icon(Icons.terminal_sharp),
                            title: Text("Testing"),
                          ),
                          onTap: () async {
                            try {
                              int.parse("asd");
                            }
                            on Exception catch(e, s){
                              await FirebaseCrashlytics.instance.recordError(
                                  e,
                                  s,
                                  reason: 'a non-fatal error'
                              );
                            }
                          },
                        ),

                        const Divider(),*/

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
              )),
              Container(
                padding: EdgeInsets.all(10),
                child: Text('SIAPrint v$version-$buildNumber'),
              )
            ],
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