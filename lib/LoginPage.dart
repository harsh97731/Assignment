import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/DashBoard.dart';
import 'package:loginsin/ForgotPassword.dart';
import 'package:loginsin/sigup.dart';

class LoginPage extends StatefulWidget {

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //const LoginPage({Key? key}) : super(key: key);
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // text controller
    final _emailControler =TextEditingController();

    final _passwordController = TextEditingController();


  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formkey,
      child: WillPopScope(
        onWillPop: () async{
        final value = await showDialog<bool>(context: context, builder: (context) {
            return AlertDialog(
              title: Text('Alert'),
              content:  Text('Do you want to exit app?'),
              actions: [
                ElevatedButton(onPressed: ()=>Navigator.of(context).pop(false),style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white), child: Text('NO')),
                ElevatedButton(onPressed: ()=>Navigator.of(context).pop(true), style: ElevatedButton.styleFrom(backgroundColor: Colors.black, foregroundColor: Colors.white), child: Text('Exit')),
            ]);
          });
        if(value!= null){
          return Future.value(value);
        }else{
          return Future.value(false);
        }
        },
        child: Scaffold(
          backgroundColor: Colors.white,
            body: Column(
              children: <Widget>[
                SizedBox(width: 70,height: 70,),
                Center(
                    child: Icon(Icons.login_outlined,size: 70,)
                ),
                SizedBox(height: 20,),
                Text('Login',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,fontSize: 20,
                ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),

                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailControler,

                    decoration: InputDecoration(
                      label: Text('Email'),
                      icon: Icon(Icons.mail_lock_outlined),
                        enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                        focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26))


                    ),
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
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    obscureText: _isObscure,
                    controller: _passwordController,
                    decoration: InputDecoration(
                      label: Text('Password',),
                      icon: Icon(Icons.password_outlined,),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                      suffixIcon: IconButton(
                        icon: Icon(_isObscure ? Icons.visibility :Icons.visibility_off),
                        onPressed: () {

                          setState(() { //refresh UI
                            if(_isObscure){ //if passenable == true, make it false
                              _isObscure = false;
                            }else{
                              _isObscure = true; //if passenable == false, make it true
                            }
                          });
                      },
                      )



                    ),
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
                  height: 1,
                ),
          Container(
            margin: EdgeInsets.all(0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Text('LogIn', style: TextStyle(fontSize: 20.0),),


              onPressed: () async{
                if (formkey.currentState!.validate()) {
                  try
                  {
                    UserCredential userCredential = await FirebaseAuth
                        .instance
                        .signInWithEmailAndPassword(
                        email: _emailControler.text.trim(),
                        password: _passwordController.text.trim());
                    if (userCredential.user != null) {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashBord()));
                    }

                  }
                  on FirebaseAuthException catch(e){
                    if(e.code=='user-not-found'){
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('user not found')));
                    }

                  }

                }
              },
            ),
          ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('you dont have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SignUp(),));
                      },
                      child: Text('signup'),
                    ),

                  ],

                ),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ForgotPassword(),));
                  },
                  child: Text('Forgot password?'),
                )

              ],
            ),
        ),
      ),
    );
  }
}
