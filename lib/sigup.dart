import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/DashBoard.dart';
import 'package:loginsin/LoginPage.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController _pass = TextEditingController();
  final TextEditingController _confirmPass = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  bool _isObscure = true;
  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
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
                'Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: _emailController,
                  decoration: InputDecoration(
                      label: Text('Email'),
                      icon: Icon(Icons.mail_lock_outlined),
                      errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                      focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
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
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: _isObscure,
                    decoration: InputDecoration(
                        label: Text('Password'),
                        icon: Icon(
                          Icons.password_outlined,
                        ),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26)),
                        suffixIcon: IconButton(
                            icon: Icon(_isObscure
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () {
                              setState(() {
                                //refresh UI
                                if (_isObscure) {
                                  //if passenable == true, make it false
                                  _isObscure = false;
                                } else {
                                  _isObscure =
                                      true; //if passenable == false, make it true
                                }
                              });
                            })),
                    controller: _pass,
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
                    }),
              ),
              SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        label: Text('Confirm Password'),
                        icon: Icon(
                          Icons.password_outlined,
                        ),
                        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                        focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                        enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.black26))),
                    controller: _confirmPass,
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
                      if (value != _pass.text) {
                        return 'no match';
                      } else {
                        return null;
                      }
                    }),
              ),
              Container(
                margin: EdgeInsets.all(0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: Text(
                    'Sign Up',
                    style: TextStyle(fontSize: 20.0),
                  ),
                  onPressed: () async {
                    if (formkey.currentState!.validate()) {
                      UserCredential userCredential = await FirebaseAuth
                          .instance
                          .createUserWithEmailAndPassword(
                              email: _emailController.text.trim(),
                              password: _pass.text.trim());
                      if (userCredential.user != null) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginPage()));
                      }
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'you already have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginPage(),
                          ));
                    },
                    child: Text('Login'),
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
