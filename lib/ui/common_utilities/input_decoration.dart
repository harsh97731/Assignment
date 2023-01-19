import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InputDecor extends StatefulWidget {
  const InputDecor({Key? key}) : super(key: key);

  @override
  State<InputDecor> createState() => _InputDecorState();
}

class _InputDecorState extends State<InputDecor> {
  @override
  Widget build(BuildContext context) {
    return InputDecoration(
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 2, color: ColorManager.primaryUi)),
        errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 2, color: ColorManager.primaryUi)),
        focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 2, color: ColorManager.primaryUi)),
        focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide(
                width: 2, color: ColorManager.primaryUi)),
        hintText: "Add list name",
        prefixIcon: Padding(
          padding:  EdgeInsets.all(1.5.h),
          child: Container(
              decoration: BoxDecoration(
                color: ColorManager.primaryUi,
                borderRadius: BorderRadius.circular(30),
              ),
              child: InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    addData();
                  }
                  _listName.clear();
                },
                child: Icon(
                  Icons.add,
                  color: ColorManager.white,
                ),
              )),
        ));
  }
}
