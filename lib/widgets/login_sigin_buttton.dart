import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../ui/screens/signup/sigup.dart';

class LogSignButton extends StatelessWidget {
  const LogSignButton({
    Key? key,
    required Text child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LogSignButton(

      child: Text('signup'),
    );
  }
}
