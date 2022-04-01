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
    DateTime now = DateTime.now();
    String date = now.toString().substring(0, 10);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text("Dashboard"),
      ),
      body: Center(
        child: Column(
          children: [
            const Text("Leafly admin dashboard",
                style: TextStyle(
                    color: darkGreen,
                    fontSize: 35.0,
                    fontFamily: "WorkSansBold")),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: <Widget>[
                const Text("Today's date ",
                    style: TextStyle(
                        color: black,
                        fontSize: 20.0,
                        fontFamily: "WorkSansBold")),
                Text(date.toString(),
                    style: const TextStyle(
                        color: darkGreen,
                        fontSize: 40.0,
                        fontFamily: "WorkSansBold")),
              ],
            ),
            Row(
              children: <Widget>[
                const Text("Number of Users ",
                    style: TextStyle(
                        color: black,
                        fontSize: 20.0,
                        fontFamily: "WorkSansBold")),
                Text(
                  numberOfUsers,
                  style: const TextStyle(
                      color: darkGreen,
                      fontSize: 40.0,
                      fontFamily: "WorkSansBold"),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                const Text("Number of Diseases Detected ",
                    style: TextStyle(
                        color: black,
                        fontSize: 20.0,
                        fontFamily: "WorkSansBold")),
                Text(
                  numberOfDiseases,
                  style: const TextStyle(
                      color: darkGreen,
                      fontSize: 40.0,
                      fontFamily: "WorkSansBold"),
                ),
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
          label: const Text('Refresh'),
          icon: const Icon(Icons.wifi_protected_setup),
          onPressed: () async {
            QuerySnapshot _myDoc =
                await FirebaseFirestore.instance.collection("users").get();
            List<DocumentSnapshot> myDocCount = _myDoc.docs;
            numberOfUsers = myDocCount.length.toString();
            QuerySnapshot myDoc =
                await FirebaseFirestore.instance.collection("diseases").get();
            List<DocumentSnapshot> _myDocCount = myDoc.docs;
            numberOfDiseases = _myDocCount.length.toString();
          }),
      drawer: const AdminNavDrawer(),
    );
  }
}
