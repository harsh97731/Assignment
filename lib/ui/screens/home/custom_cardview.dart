import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginsin/resources/color_manager.dart';

class ItemCards extends StatelessWidget {
  const ItemCards({
    this.listtext
    Key? key
  }) : super(key: key);


Text listtext ;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 40,
        width: 50,
        color: ColorManager.primaryUi,
        child: Row(
            Text(snapshot.data?.docs[index]['name'] ?? '',style: TextStyle(color: ColorManager.primaryUi),);
        ),
      ),
    );
  }
}
