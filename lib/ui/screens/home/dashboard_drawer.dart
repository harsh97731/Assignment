

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/ui/dialogs/alert_dialog_box.dart';
import 'package:loginsin/ui/screens/authentication/login/LoginPage.dart';

import '../resources/color_manager.dart';
import '../ui/screens/authentication/changedpassword/ChangedPassword.dart';

class DashBoardDrawer extends StatefulWidget {
  const DashBoardDrawer({Key? key}) : super(key: key);

  @override
  State<DashBoardDrawer> createState() => _DashBoardDrawerState();
}

class _DashBoardDrawerState extends State<DashBoardDrawer> {
  final String? _username = FirebaseAuth.instance.currentUser?.displayName;
  final String? userEmail = FirebaseAuth.instance.currentUser?.email;
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.all(0),
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: ColorManager.primaryUi,
            ), //BoxDecoration
            child: UserAccountsDrawerHeader(
              decoration: BoxDecoration(color: ColorManager.primaryUi),
              accountName: Text(
                "Username: $_username,",
                style: const TextStyle(fontSize: 15),
              ),
              accountEmail: Text('Email: $userEmail'),
              currentAccountPictureSize: const Size.square(50),
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
                    builder: (context) => const ChangedPassword(),
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
              showDialog(context: context, builder: (context) {
                return AlertDialog(
                  title: Text('do you want to log out ?'),
                  actions: [
                    ElevatedButton(onPressed: (){
                      Navigator.pop(context);
                    }, child: Text('no')),
                    
                    ElevatedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                    }, child: Text('log out')),
                  ],
                );
              },
              );
            })],
      ),
    );
  }
}
