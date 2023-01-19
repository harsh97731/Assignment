

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class DashBottomNavigator extends StatefulWidget {
  const DashBottomNavigator({Key? key}) : super(key: key);

  @override
  State<DashBottomNavigator> createState() => _DashBottomNavigatorState();
}

class _DashBottomNavigatorState extends State<DashBottomNavigator> {
  int index = 0;
  @override
  Widget build(BuildContext context) {
    return GNav(
      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
      onTabChange: (val) {
        index;

        setState(() {
          index = val;
        });
      },
      gap: 2,
      tabs: const [
        GButton(
          icon: Icons.home,
          text: 'Home',
          textColor: Colors.green,
          iconColor: Colors.green,
        ),
        GButton(
          icon: Icons.people,
          text: 'Vendors',
          textColor: Colors.green,
          iconColor: Colors.green,
        ),
        GButton(
          icon: Icons.list,
          text: 'List',
          textColor: Colors.green,
          iconColor: Colors.green,
        ),
        GButton(
          icon: Icons.category,
          text: 'Category',
          textColor: Colors.green,
          iconColor: Colors.green,
        ),
        GButton(
          icon: Icons.menu_open,
          text: 'Menu',
          textColor: Colors.green,
          iconColor: Colors.green,
        ),
      ],
    );
  }
}
