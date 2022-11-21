import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:siapprint/model/transaction_model.dart';
import 'package:siapprint/screen/account_setting.dart';
import 'package:siapprint/screen/basket3_page.dart';
import 'package:siapprint/screen/checkout_page.dart';
import 'package:siapprint/screen/home_page.dart';
import 'package:siapprint/screen/login_page.dart';
import 'package:siapprint/screen/navigation/app_navigation.dart';
import 'package:siapprint/screen/navigation/bottom_bar.dart';
import 'package:siapprint/screen/navigation/single_navigation.dart';
import 'package:siapprint/screen/regsiter_page.dart';
import 'package:siapprint/screen/status_page.dart';
import 'package:siapprint/screen/waiting_payment_page.dart';


// void main() {
//   runApp(MyApp());
// }

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var status = prefs.getString('user') != null;

  runApp(MyApp(home: status == true ? const SingleNavigationPage() : const LoginPage()));
}

// void main() => runApp(AppWidget());
//
// class AppWidget extends StatelessWidget {
//   AppWidget({Key? key}) : super(key: key);
//
//   final _appRouter = AppRouter();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       debugShowCheckedModeBanner: false,
//       title: 'Bottom Nav Bar with Nested Routing',
//       routerDelegate: _appRouter.delegate(),
//       routeInformationParser: _appRouter.defaultRouteParser(),
//     );
//   }
// }

class MyApp extends StatelessWidget {
  MyApp({Key? key, required this.home}) : super(key: key);

  final Widget home;

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context) => const LoginPage(),
    Basket3Page.tag: (context) => const Basket3Page(),
    AccountSettingPage.tag: (context) => const AccountSettingPage(),
    CheckoutPage.tag: (context) => const CheckoutPage(),
    StatusPage.tag: (context) => const StatusPage(),
    SingleNavigationPage.tag: (context) => const SingleNavigationPage(),

    AppNavigation.tag: (context) => const AppNavigation(),
    HomePage.tag: (context) => HomePage(),
    BottomBar.tag: (context) => BottomBar(),
    BottomPage2.tag: (context) => const BottomPage2(),
  };

  Map<String, WidgetBuilder> _routeBuilders(BuildContext buildContext, Object? arguments) {
    return {
      LoginPage.tag: (context) => const LoginPage(),
      RegisterPage.tag: (context) => const RegisterPage(),
      Basket3Page.tag: (context) => const Basket3Page(),
      AccountSettingPage.tag: (context) => const AccountSettingPage(),
      CheckoutPage.tag: (context) => CheckoutPage(
          transactionModel: arguments as TransactionModel
      ),
      StatusPage.tag: (context) => const StatusPage(),
      WaitingPaymentPage.tag: (context) => WaitingPaymentPage(
        data: arguments as String,
      ),
      SingleNavigationPage.tag: (context) => const SingleNavigationPage(),
    };
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Siapprint',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: home,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          // builder: (context) => _routeBuilders[routeSettings.name!]!(context),
          builder: (context) => _routeBuilders(context, routeSettings.arguments)[routeSettings.name]!(context),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
