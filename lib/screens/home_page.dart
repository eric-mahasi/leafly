import 'package:flutter/material.dart';
import 'package:leafly/services/style.dart';
import 'package:leafly/widgets/nav_drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: const [
              Text(
                "Welcome",
                style: TextStyle(
                    color: black, fontSize: 40.0, fontFamily: "WorkSansBold"),
              ),
              Text(
                "Your next diagnosis is a few clicks away",
                style: TextStyle(
                    color: darkGreen,
                    fontSize: 20.0,
                    fontFamily: "WorkSansBold"),
              ),
              Text(
                "Use the drawer on the left for more",
                style: TextStyle(
                    color: darkGreen,
                    fontSize: 20.0,
                    fontFamily: "WorkSansBold"),
              ),
            ],
          ),
        ),
        drawer: const NavDrawer());
    // bottomNavigationBar: const BottomNavBarWidget());
  }
}
