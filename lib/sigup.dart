import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/LoginPage.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
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
            ),
          ),

          Container(
            margin: EdgeInsets.all(0),
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black),
              ),
              child: Text('Sign up', style: TextStyle(fontSize: 20.0),),


              onPressed: () {},
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
    );
  }
}
