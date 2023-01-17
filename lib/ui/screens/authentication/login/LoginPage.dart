import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loginsin/model/customer.dart';
import 'package:loginsin/resources/color_manager.dart';
import 'package:loginsin/resources/string_manager.dart';
import 'package:loginsin/ui/screens/home/dash_board.dart';
import 'package:loginsin/ui/screens/authentication/forgotpassword/ForgotPassword.dart';
import 'package:loginsin/ui/screens/signup/sigup.dart';
import 'package:loginsin/user_preferences/user_preferences.dart';

import 'package:loginsin/widgets/text_form_field.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //const LoginPage({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // text controller
  final _emailControler = TextEditingController();

  final _passwordController = TextEditingController();
  String name ='';
  bool isLoading = false;
      @override
      void initState(){
        super.initState();
      // name = UserSimplePreferences.getUserEmail(name) ?? '';
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
                              backgroundColor: ColorManager.primaryUi,
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
          body: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SizedBox(
                  width: 70,
                  height: 70,
                ),
                const Center(
                    child: Icon(
                  Icons.login_outlined,
                  size: 70,
                )),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  StringManager.login,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextFormFieldWidget(
                  textController: _emailControler,
                  iconField: const Icon(Icons.email_outlined),
                  labelText: const Text(StringManager.login),
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
                const SizedBox(
                  height: 20,
                ),
                TextFormFieldWidget(
                    textController: _passwordController,
                    iconField: const Icon(Icons.password_sharp),
                    labelText: const Text(StringManager.password),
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
                      if (value != _passwordController.text) {
                        return 'no match';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 1,
                ),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(ColorManager.primaryUi),
                  ),
                  onPressed: () async {
                    // await UserSimplePreferences.setUserEmail(name);

                    if (formkey.currentState!.validate()) {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        UserCredential userCredential = await FirebaseAuth
                            .instance
                            .signInWithEmailAndPassword(
                                email: _emailControler.text.trim(),
                                password: _passwordController.text.trim());
                        await UserPreferences.saveLoginUserInfo( ModelCustomer(email: _emailControler.text,id: userCredential.user!.uid));
                        print("email: ${await UserPreferences.getUserEmail()}");
                        if (userCredential.user != null) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DashBord()));
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('user not found')));
                        }
                      }
                    }
                  },
                  child: Container(
                    margin: const EdgeInsets.all(0),
                    child: const Text(
                      StringManager.login,
                      style: TextStyle(fontSize: 20.0),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const <Widget>[
                      Text(
                        'you dont have an account?',
                        style: TextStyle(
                          color: Colors.black54,
                        ),
                      ),


                  ],
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUp(),
                        ));
                  },
                  child: const Text("${StringManager.signup}?"),
                ),
                const SizedBox(
                  height: 20,
                ),
                isLoading
                    ? const SpinKitCircle(
                        color: Colors.black,
                        size: 30,
                      )
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


