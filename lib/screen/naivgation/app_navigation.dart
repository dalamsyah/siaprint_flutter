import 'package:flutter/material.dart';
import 'package:siapprint/screen/account_setting.dart';
import 'package:siapprint/screen/basket2_page.dart';
import 'package:siapprint/screen/form_print_page.dart';
import 'package:siapprint/screen/naivgation/bottom_navigation.dart';
import 'package:siapprint/screen/naivgation/tab_navigator.dart';
import 'package:siapprint/screen/upload_page.dart';

enum TabItem {

  red(Colors.red),
  green(Colors.green),
  blue(Colors.blue),
  upload(Colors.yellow);

  const TabItem(this.color);
  final MaterialColor color;
}

enum TabWidgetItem {

  upload( UploadPage() ),
  formPrint( Basket2Page(onSubmit: null,) ),
  setting( AccountSettingPage() ),;

  const TabWidgetItem(this.widget);
  final Widget widget;
}

class AppNavigation extends StatefulWidget {

  const AppNavigation({Key? key}) : super(key: key);

  static String tag = 'app-navigation-page';

  @override
  State<StatefulWidget> createState() => _AppNavigation();

}

class _AppNavigation extends State<AppNavigation> {

  var _currentTab = TabWidgetItem.upload;
  final _navigatorKeys = {
    TabWidgetItem.upload: GlobalKey<NavigatorState>(),
    TabWidgetItem.formPrint: GlobalKey<NavigatorState>(),
    TabWidgetItem.setting: GlobalKey<NavigatorState>(),
  };

  void _selectTab(TabWidgetItem tabItem) {
    if (tabItem == _currentTab) {
      // pop to first route
      _navigatorKeys[tabItem]!.currentState!.popUntil((route) => route.isFirst);
    } else {
      setState(() => _currentTab = tabItem);
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentTab]!.currentState!.maybePop();
        if (isFirstRouteInCurrentTab) {
          // if not on the 'main' tab
          if (_currentTab != TabWidgetItem.upload) {
            // select 'main' tab
            _selectTab(TabWidgetItem.upload);
            // back button handled by app
            return false;
          }
        }
        // let system handle back button if we're on the first route
        return isFirstRouteInCurrentTab;
      },
      child: Scaffold(
        body: Stack(children: <Widget>[
          _buildOffstageNavigator(TabWidgetItem.upload),
          _buildOffstageNavigator(TabWidgetItem.formPrint),
          _buildOffstageNavigator(TabWidgetItem.setting),
        ]),
        bottomNavigationBar: BottomNavigation(
          currentTab: _currentTab,
          onSelectTab: _selectTab,
        ),
      ),
    );
  }

  Widget _buildOffstageNavigator(TabWidgetItem tabItem) {
    return Offstage(
      offstage: _currentTab != tabItem,
      child: TabNavigator(
        navigatorKey: _navigatorKeys[tabItem],
        tabItem: tabItem,
      ),
    );
  }

}
