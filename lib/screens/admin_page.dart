import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leafly/services/style.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: primary,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: black,
              ),
              onPressed: () => Navigator.of(context).pop(),
            )),
        body: const Center(
            child: Text(
          "Users",
          style: TextStyle(
              color: black, fontSize: 40.0, fontFamily: "WorkSansBold"),
        )));
  }
}
