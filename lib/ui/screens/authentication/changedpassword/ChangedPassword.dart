import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/ui/screens/home/DashBoard.dart';
import 'package:loginsin/ui/screens/authentication/login/LoginPage.dart';

class ChangedPassword extends StatefulWidget {
  const ChangedPassword({Key? key}) : super(key: key);

  @override
  State<ChangedPassword> createState() => _ChangedPasswordState();
}

class _ChangedPasswordState extends State<ChangedPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final newPasswordController = TextEditingController();
  @override
  void dispose() {
    newPasswordController.dispose();
    super.dispose();
  }
  final currentUser = FirebaseAuth.instance.currentUser;



 Future<void> changePassword(String newPassword) async {
    try {
      await currentUser!.updatePassword(newPassword);
     await FirebaseAuth.instance.signOut();
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => DashBord(),
          ));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text('your password has been changed.. Login again'),
      )
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: Colors.black26,
        content: Text(error.toString()),
      )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: WillPopScope(
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
          backgroundColor: Colors.white,
          body: Column(
            children: <Widget>[
              SizedBox(
                width: 70,
                height: 70,
              ),
              Center(
                  child: Icon(
                Icons.login_outlined,
                size: 70,
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Change your Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  controller: newPasswordController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: InputDecoration(
                      label: Text('Enter new password'),
                      icon: Icon(Icons.mail_lock_outlined),
                      errorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      focusedErrorBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.black26))),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Required";
                    }
                    if (value.length < 6) {
                      return "Password must be atleast 6 characters long";
                    }
                    if (value.length > 20) {
                      return "Password must be less than 20 characters";
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Password must contain a number";
                    }
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              SizedBox(
                height: 1,
              ),
              Container(
                margin: EdgeInsets.all(0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: Text(
                      'Submit',
                      style: TextStyle(fontSize: 20.0),
                    ),
                    onPressed:()=> changePassword(newPasswordController.text.trim()),
              ),
              )],
          ),
        ),
      ),
    );
  }
}
