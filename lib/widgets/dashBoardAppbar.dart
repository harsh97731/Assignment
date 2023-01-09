import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../resources/color_manager.dart';

class DashboardAppBar extends StatefulWidget {
  const DashboardAppBar({Key? key}) : super(key: key);

  @override
  State<DashboardAppBar> createState() => _DashboardAppBarState();
}

class _DashboardAppBarState extends State<DashboardAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorManager.primaryUi,

      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(onPressed: (){}, icon: Icon(
                Icons.location_on_outlined
            )),
          ],
        )
      ],
    );
  }
}
