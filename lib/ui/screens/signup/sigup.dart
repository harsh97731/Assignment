
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/model/customer.dart';
import 'package:loginsin/resources/color_manager.dart';
import 'package:loginsin/resources/string_manager.dart';
import 'package:loginsin/ui/screens/authentication/login/LoginPage.dart';
import 'package:loginsin/ui/screens/home/dash_board.dart';
import 'package:loginsin/user_preferences/user_preferences.dart';
import 'package:loginsin/widgets/text_form_field.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _username = TextEditingController();
  String? user_email = FirebaseAuth.instance.currentUser?.email;

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return
      WillPopScope(
        key: formkey,
        onWillPop: () async {
          {
            final value = await showDialog<bool>(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      title: const Text('Alert'),
                      content: const Text('Do you want to exit app?'),
                      actions: [
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.primaryUi,
                                foregroundColor: Colors.white),
                            child: const Text('NO')),
                        ElevatedButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            style: ElevatedButton.styleFrom(
                                backgroundColor: ColorManager.primaryUi,
                                foregroundColor: Colors.white),
                            child: const Text('Exit')),
                      ]);
                });
            if (value != null) {
              return Future.value(value);
            } else {
              return Future.value(false);
            }
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
                  StringManager.signup,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                TextFormFieldWidget(
                    textController: _username,
                    iconField: const Icon(Icons.person),
                    labelText: const Text("User name"),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Required";
                      }
                      return null;
                    }),

                TextFormFieldWidget(
                  textController: _emailController,
                  iconField: const Icon(Icons.email_outlined),
                  labelText: const Text(StringManager.email),
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

                TextFormFieldWidget(
                    textController: _password,
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
                      if (value != _password.text) {
                        return 'no match';
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 1,
                ),
                TextFormFieldWidget(
                    textController: _confirmPass,
                    iconField: const Icon(Icons.password),
                    labelText: const Text('confirm'),
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
                      if (value != _password.text) {
                        return 'no match';
                      } else {
                        return null;
                      }
                    }),
                Container(
                  margin: const EdgeInsets.all(0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(ColorManager.primaryUi),
                    ),
                    onPressed: () async {
                      // await UserSimplePreferences.setUserEmail(name);

                      if (formkey.currentState!.validate()) {
                        setState(() {});
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: _emailController.text.trim(),
                                  password: _password.text.trim());




                          User? user = userCredential.user;
                          await user?.updateDisplayName(_username.text);

                          await FirebaseFirestore.instance.collection('users').doc().set(
                              {'username': _username.text,
                                'email' : user!.email,
                                'uid' : user.uid});

                          // String? userId = FirebaseAuth.instance.currentUser?.uid;
                          await UserPreferences.saveLoginUserInfo(ModelCustomer(
                              id: userCredential.user!.uid,
                              email: _emailController.text));

                          if (kDebugMode) {
                            print("email: ${await UserPreferences.getUserEmail()}");
                          }

                          if (userCredential.user != null) {
                            // ignore: use_build_context_synchronously

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
                        StringManager.signup,
                        style: TextStyle(fontSize: 20.0),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text(
                      StringManager.youAlreadyHaveAnAccount,
                      style: TextStyle(
                        color: Colors.black54,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginPage(),
                            ));
                      },
                      child: const Text(StringManager.login),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  }
}
