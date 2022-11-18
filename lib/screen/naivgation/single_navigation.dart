
import 'package:flutter/material.dart';
import 'package:siapprint/screen/account_setting.dart';
import 'package:siapprint/screen/basket3_page.dart';
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
              padding: const EdgeInsets.all(10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  // Expanded(child: Container(
                  //   padding: EdgeInsets.all(10),
                  //   child: Text('SIAPrint', style: TextStyle(color: Colors.blueAccent.withOpacity(0.9), fontSize: 18, fontWeight: FontWeight.w500),),
                  // )),

                  Expanded(child: Container(
                    child: CircleAvatar(
                      backgroundColor: Colors.transparent,
                      radius: 20.0,
                      child: Image.asset('assets/logo_text.png'),
                    ),
                  )),

                  Expanded(child: Container()),

                  Row(
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