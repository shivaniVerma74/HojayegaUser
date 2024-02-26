import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Helper/color.dart';

class ViewAll extends StatefulWidget {
  const ViewAll({Key? key}) : super(key: key);

  @override
  State<ViewAll> createState() => _ViewAllState();
}

class _ViewAllState extends State<ViewAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.appbarColor,
      appBar: AppBar(
        backgroundColor: colors.primary,
        elevation: 0,
        title: const Text("View All",
            style: TextStyle(
                fontWeight: FontWeight.w600, color: colors.whiteTemp)),
        centerTitle: true,
      ),
    );
  }
}
