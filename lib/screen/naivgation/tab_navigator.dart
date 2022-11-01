import 'package:flutter/material.dart';
import 'package:siapprint/model/basket_model.dart';
import 'package:siapprint/screen/account_setting.dart';
import 'package:siapprint/screen/basket2_page.dart';
import 'package:siapprint/screen/checkout_page.dart';
import 'package:siapprint/screen/form_print_page.dart';
import 'package:siapprint/screen/naivgation/app_navigation.dart';
import 'package:siapprint/screen/upload_page.dart';

class TabNavigatorRoutes {
  static const String root = '/';
  static const String detail = '/detail';
  static const String upload = '/upload';
  static const String form_print = '/form_print';
  static const String checkout = '/checkout';
}

class TabNavigator extends StatelessWidget {
  const TabNavigator(
      {super.key, required this.navigatorKey, required this.tabItem});

  final GlobalKey<NavigatorState>? navigatorKey;
  final TabWidgetItem tabItem;

  void _push(BuildContext context, {int materialIndex = 500}) {
    var routeBuilders = _routeBuilders(context, null, materialIndex: materialIndex);

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            routeBuilders[TabNavigatorRoutes.detail]!(context),
      ),
    );
  }

  Map<String, WidgetBuilder> _routeBuilders(BuildContext buildContext, Object? arguments,
      {int materialIndex = 500}) {

    return {
      'rooo': (context) => ColorsListPage(
            color: Colors.red,
            title: tabItem.name,
            child: const UploadPage(),
            onPush: (materialIndex) =>
                _push(context, materialIndex: materialIndex),
          ),
      TabNavigatorRoutes.root: (context) => tabItem.widget,
      TabNavigatorRoutes.detail: (context) => const AccountSettingPage(),
      TabNavigatorRoutes.upload: (context) => const UploadPage(),
      TabNavigatorRoutes.form_print: (context) => FormPrintPage(),
      TabNavigatorRoutes.checkout: (context) => CheckoutPage(
          listBasketModel: arguments as List<BasketModel>
      ),
    };
  }

  @override
  Widget build(BuildContext context) {
    // final routeBuilders = _routeBuilders(context);
    return Navigator(
      key: navigatorKey,
      initialRoute: TabNavigatorRoutes.root,
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(
          // builder: (context) => _routeBuilders[routeSettings.name!]!(context),
          builder: (context) => _routeBuilders(context, routeSettings.arguments, materialIndex: 500)[routeSettings.name!]!(context),
        );
      },
    );
  }
}


class ColorsListPage extends StatelessWidget {
  ColorsListPage(
      {super.key, required this.color, required this.title, required this.child, this.onPush});
  final MaterialColor color;
  final String title;
  final Widget child;
  final ValueChanged<int>? onPush;

  @override
  Widget build(BuildContext context) {

    // return child;

    return Scaffold(
        appBar: AppBar(
          title: Text(
            title,
          ),
          backgroundColor: Colors.red,
        ),
        body: Container(
          color: Colors.white,
          child: _buildList(),
        ));
  }

  final List<int> materialIndices = [
    900,
    800,
    700,
    600,
    500,
    400,
    300,
    200,
    100,
    50
  ];

  Widget _buildList() {
    return ListView.builder(
        itemCount: materialIndices.length,
        itemBuilder: (BuildContext content, int index) {
          int materialIndex = materialIndices[index];
          return Container(
            color: color[materialIndex],
            child: ListTile(
              title: Text('$materialIndex',
                  style: const TextStyle(fontSize: 24.0)),
              trailing: const Icon(Icons.chevron_right),
              onTap: () => onPush?.call(materialIndex),
            ),
          );
        });
  }
}

class ColorDetailPage extends StatelessWidget {
  const ColorDetailPage(
      {super.key,
        required this.color,
        required this.title,
        this.materialIndex = 500});
  final MaterialColor color;
  final String title;
  final int materialIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: color,
        title: Text(
          '$title[$materialIndex]',
        ),
      ),
      body: Container(
        color: color[materialIndex],
      ),
    );
  }
}
