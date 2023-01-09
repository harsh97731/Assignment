import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:loginsin/resources/color_manager.dart';
import 'package:loginsin/ui/screens/authentication/changedpassword/ChangedPassword.dart';
import 'package:loginsin/ui/screens/authentication/login/LoginPage.dart';

class DashBord extends StatefulWidget {
  const DashBord({Key? key}) : super(key: key);

  @override
  State<DashBord> createState() => _DashBordState();
}

class _DashBordState extends State<DashBord> {
  int index = 0;
  String? UserEmail = FirebaseAuth.instance.currentUser?.email;
  final CarouselController carouselController = CarouselController();
  int currentIndex = 0;

  List<Widget> Screens = [
    Center(child: Text("My home page")),
    Center(child: Text("My home pa")),
    Center(child: Text("My home page")),
    Center(child: Text("My home page")),
    Center(child: Text("My home page"))
  ];
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                  title: Text('Alert'),
                  content: Text('Do you want to exit app?'),
                  actions: [
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white),
                        child: Text('NO')),
                    ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white),
                        child: Text('Exit')),
                  ]);
            });
        if (value != null) {
          return Future.value(value);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
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
                  accountEmail: Text("h"),
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
                leading: const Icon(Icons.password_sharp),
                title: const Text(' Change Password '),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ChangedPassword(),
                      ));
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
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        child: AlertDialog(
                          backgroundColor: Colors.white,
                          title: Text("Are you sure ?"),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => LoginPage(),
                                      ),
                                      (route) => false);
                                },
                                child: Text("yes")),
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text("no"))
                          ],
                        ),
                      );
                    },
                  );
                  ;
                },
              ),
            ],
          ),
        ),

        appBar: AppBar(
          backgroundColor: ColorManager.primaryUi,

          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(onPressed: (){}, icon: Icon(
                  Icons.location_on_outlined
                )),
              ],
            )
          ],
        ),



        bottomNavigationBar: GNav(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          onTabChange: (val) {
            currentIndex:
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
        ),
      ),
    );
  }
}
