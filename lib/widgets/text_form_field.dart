import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatefulWidget {

  TextEditingController textController;
  Text? labelText;
  Icon? iconField;
  FormFieldValidator? validator;


  TextFormFieldWidget({Key? key,
    required this.textController,
    required this.iconField,
    required this.labelText,
    required this.validator,

  })
      : super(key: key);

  @override
  State<TextFormFieldWidget> createState() => _TextFormFieldWidgetState();
}

class _TextFormFieldWidgetState extends State<TextFormFieldWidget> {
  var value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        controller: widget.textController,
        decoration: InputDecoration(
            label: widget.labelText,
            icon: widget.iconField,
            errorBorder: getErrorBorder(),
            focusedErrorBorder: getErrorBorder(),
            enabledBorder: getErrorBorder(),
            focusedBorder: getErrorBorder()),
        validator:widget.validator,

      ),
    );
  }

  getErrorBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black26));
  }
  GetValidatorForEmail(value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email address';
    }
    // Check if the entered email has the right format
    if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    // Return null if the entered email is valid
    return null;
  }
  GetValidatorForPassword(value) {
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
     else {
      return null;
    }
  }
}

// class TextForm extends StatelessWidget {
//
//    TextForm({
//     Key? key,
//     required TextEditingController emailControler,
//     required labelText,
//     required iconField,
//   })  : _emailControler = emailControler,
//         super(key: key);
//
//
//   final TextEditingController _emailControler;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: TextFormField(
//         autovalidateMode: AutovalidateMode.onUserInteraction,
//         controller: _emailControler,
//         decoration: const InputDecoration(
//             // label: Text(),
//             // icon: Icon(),
//             errorBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.black26)),
//             focusedErrorBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.black26)),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.black26)),
//             focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.black26))),
//         validator: (value) {
//           if (value == null || value.trim().isEmpty) {
//             return 'Please enter your email address';
//           }
//           // Check if the entered email has the right format
//           if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
//             return 'Please enter a valid email address';
//           }
//           // Return null if the entered email is valid
//           return null;
//         },
//       ),
//     );
//   }
// }
