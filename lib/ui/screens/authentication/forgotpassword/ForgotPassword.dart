import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/resources/color_manager.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // text controller
  final _emailControler = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    _emailControler.dispose();
    super.dispose();
  }

  Future<void> passwardReset() async {
    if (formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: _emailControler.text.trim());
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('Password reset link send! check your email'),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        print(e);
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text('not registerd'),
            );
          },
        );
      }
    }
  }

  //bool _isObscure = true;
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
                color: ColorManager.primaryUi,
                size: 70,
              )),
              SizedBox(
                height: 20,
              ),
              Text(
                'Forgot Password',
                style: TextStyle(
                  color: ColorManager.primaryUi,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailControler,
                  decoration: InputDecoration(
                      label: Text('Reset email'),
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
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter your email address';
                    }
                    // Check if the entered email has the right format
                    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    // Return null if the entered email is valid
                    return null;
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
                    backgroundColor: MaterialStateProperty.all(ColorManager.primaryUi),
                  ),
                  child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: passwardReset,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
