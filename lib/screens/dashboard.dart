import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafly/screens/admin_nav_bar.dart';
import 'package:leafly/services/style.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  String numberOfDiseases = "";
  String numberOfUsers = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 50,
              child: Card(
                shape: const BeveledRectangleBorder(),
                child: GestureDetector(
                  onTap: () async {
                    QuerySnapshot _myDoc = await FirebaseFirestore.instance
                        .collection("diseases")
                        .get();
                    List<DocumentSnapshot> myDocCount = _myDoc.docs;
                    numberOfDiseases = myDocCount.length.toString();
                  },
                  child: Text(
                      "Number of diseases detected" " " + numberOfDiseases),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              width: 200,
              child: Card(
                shape: const BeveledRectangleBorder(),
                child: GestureDetector(
                  onTap: () async {
                    QuerySnapshot _myDoc = await FirebaseFirestore.instance
                        .collection("users")
                        .get();
                    List<DocumentSnapshot> myDocCount = _myDoc.docs;
                    numberOfUsers = myDocCount.length.toString();
                  },
                  child: Text("Number of users " + numberOfUsers),
                ),
              ),
            ),
          ],
        ),
      ),
      drawer: const AdminNavDrawer(),
    );
  }
}
