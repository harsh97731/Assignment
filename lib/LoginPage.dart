import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/DashBoard.dart';
import 'package:loginsin/sigup.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

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
            Text('Login',
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
            SizedBox(height: 20,),
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
      Container(
        margin: EdgeInsets.all(0),
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.black),
          ),
          child: Text('LogIn', style: TextStyle(fontSize: 20.0),),
          
         
          onPressed: () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBord(),));
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp(),));
                  },
                  child: Text('signup'),
                )
              ],

            ),

          ],
        ),
    );
  }
}
