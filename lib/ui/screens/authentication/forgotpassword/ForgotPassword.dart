import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/resources/color_manager.dart';
import 'package:loginsin/widgets/text_form_field.dart';

import '../../../../resources/string_manager.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  GlobalKey<FormState> formkey = GlobalKey<FormState>();

  // text controller
  final _emailControler = TextEditingController();
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
            return const AlertDialog(
              content: Text(StringManager.passwordrestelink),
            );
          },
        );
      } on FirebaseAuthException catch (e) {
        if (kDebugMode) {
          print(e);
        }
        showDialog(
          context: context,
          builder: (context) {
            return const AlertDialog(
              content: Text(StringManager.notregistered),
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
              Center(
                  child: Icon(
                Icons.login_outlined,
                color: ColorManager.primaryUi,
                size: 70,
              )),
              const SizedBox(
                height: 20,
              ),
              Text(
                StringManager.forgotpassward,
                style: TextStyle(
                  color: ColorManager.primaryUi,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextFormFieldWidget(textController: _emailControler, iconField: const Icon(Icons.email_outlined), labelText: const Text(StringManager.email), validator: (value) {
                  
                },)
              ),
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
                    backgroundColor: MaterialStateProperty.all(ColorManager.primaryUi),
                  ),
                  onPressed: passwardReset,
                  child: const Text(
                    StringManager.reset,
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
