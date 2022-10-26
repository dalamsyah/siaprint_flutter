import 'package:flutter/material.dart';
import 'package:siapprint/screen/account_setting.dart';
import 'package:siapprint/screen/basket2_page.dart';
import 'package:siapprint/screen/form_print_page.dart';
import 'package:siapprint/screen/naivgation/app_navigation.dart';
import 'package:siapprint/screen/upload_page.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});

  final TabWidgetItem currentTab;
  final ValueChanged<TabWidgetItem> onSelectTab;


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.upload),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: 'Status',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          label: 'Account',
        ),
      ],
      onTap: (index) => onSelectTab(
        TabWidgetItem.values[index],
      ),
      currentIndex: currentTab.index,
      selectedItemColor: Colors.green,
    );
  }

  BottomNavigationBarItem _buildItem(TabWidgetItem tabItem) {
    return BottomNavigationBarItem(
      icon: Icon(
        Icons.layers,
        color: Colors.redAccent,
      ),
      label: tabItem.name,
    );
  }

  Color _colorTabMatching(TabItem item) {
    return currentTab == item ? item.color : Colors.grey;
  }
}
