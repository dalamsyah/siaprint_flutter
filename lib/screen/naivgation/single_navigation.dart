import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/model/user_model.dart';
import 'package:siapprint/repository/login_service.dart';
import 'package:siapprint/screen/account_setting.dart';
import 'package:siapprint/screen/basket3_page.dart';
import 'package:siapprint/screen/home_page.dart';
import 'package:siapprint/screen/naivgation/app_navigation.dart';
import 'package:siapprint/screen/naivgation/bottom_bar.dart';
import 'package:siapprint/screen/status_page.dart';
import 'package:siapprint/screen/upload_page.dart';

class SingleNavigationPage extends StatefulWidget {

  static String tag = 'single-page';

  const SingleNavigationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SingleNavigationPage();

}

class _SingleNavigationPage extends State<SingleNavigationPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(StatusPage.tag);
                      },
                      color: Colors.blueAccent.withOpacity(0.9),
                      icon: const Icon(Icons.checklist)
                  ),
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(Basket3Page.tag);
                      },
                      color: Colors.blueAccent.withOpacity(0.9),
                      icon: const Icon(Icons.shopping_cart)
                  ),
                  IconButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(AccountSettingPage.tag);
                      },
                      color: Colors.blueAccent.withOpacity(0.9),
                      icon: const Icon(Icons.account_circle)
                  )
                ],
              ),
            ),
            const Expanded(child: UploadPage())
          ],
        ),
      ),
    );
  }


}