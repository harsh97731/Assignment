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
  bool isShowPass = false;
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
              SizedBox(width: 70,height: 70,),
              Center(
                  child: Icon(Icons.login_outlined,size: 70,)
              ),
              SizedBox(height: 20,),
              Text('Sign Up',
                style: TextStyle(
                  fontWeight: FontWeight.bold,fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(

                  decoration: InputDecoration(
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
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.password_outlined,),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26))


                  ),
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


                  }
                ),
              ),
              SizedBox(
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.password_outlined,),
                      enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
                      focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black26))


                  ),
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
    if(value!=_pass.text){
      return 'no match';
    }else{
      return null;
    }
                  }
                ),
              ),

              Container(
                margin: EdgeInsets.all(0),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black),
                  ),
                  child: Text('LogIn', style: TextStyle(fontSize: 20.0),),


                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashBord()
                          )
                      );
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text('you already have an account?',
                    style: TextStyle(
                      color: Colors.black54,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
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
