import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/resources/string_manager.dart';
import 'package:loginsin/ui/screens/home/dash_board.dart';
import 'package:loginsin/widgets/text_form_field.dart';

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
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const DashBord(),
          ));
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        backgroundColor: Colors.black26,
        content: Text(StringManager.yourpasswordhasbeenchanged),
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
                return const AlertDialog();
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
                'Change your Password',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),

             TextFormFieldWidget(textController: newPasswordController, iconField: const Icon(Icons.email_outlined), labelText: const Text(StringManager.email), validator: (value) {
               return null;


             },),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 1,
              ),
              Container(
                margin: const EdgeInsets.all(0),
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.black),
                    ),
                    child: const Text(
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
