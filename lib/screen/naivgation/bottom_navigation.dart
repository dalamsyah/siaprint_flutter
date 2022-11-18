import 'package:flutter/material.dart';
import 'package:siapprint/screen/naivgation/app_navigation.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation(
      {super.key, required this.currentTab, required this.onSelectTab});

  final TabWidgetItem currentTab;
  final ValueChanged<TabWidgetItem> onSelectTab;


  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.upload),
          label: 'Upload',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.checklist),
          label: 'Keranjang',
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
      icon: const Icon(
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
