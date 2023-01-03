import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DashBord extends StatefulWidget {
  const DashBord({Key? key}) : super(key: key);

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  int index = 0;
  List<Widget> Screens=[
    Center(child: Text("My home page")),
    Center(child: Text("My home pa")),
  Center(child: Text("My home page")),
 Center(child: Text("My home page")),
 Center(child: Text("My home page"))];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Screens[index],
      drawer: Drawer(
        child: ListView(
          padding: const EdgeInsets.all(0),
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ), //BoxDecoration
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.black),
                accountName: Text(
                  "Harsh vaddoriya",
                  style: TextStyle(fontSize: 18),
                ),
                accountEmail: Text("Harshvaddoriya2550@gmail.com"),
                currentAccountPictureSize: Size.square(50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Color.fromARGB(255, 255, 251, 251),
                  child: Text(
                    "H",
                    style: TextStyle(fontSize: 30.0, color: Colors.black),
                  ), //Text
                ), //circleAvatar
              ), //UserAccountDrawerHeader
            ), //DrawerHeader
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text(' My Profile '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text(' Payment method'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.workspace_premium),
              title: const Text(' Address '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_label),
              title: const Text(' Password '),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit),
              title: const Text(' Household'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('LogOut'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Dashboard',
          ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (val) {

          setState(() {
            index=val;
          });
        },


        selectedItemColor: Colors.black,
       unselectedItemColor: Colors.grey,
       // backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Vendor'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'List'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.category_outlined),
              label: 'Catagory'
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.more),
              label: 'Menu'
          ),
        ],
      ),
    );
  }
}
