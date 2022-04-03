import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:leafly/screens/admin_nav_bar.dart';
import 'package:leafly/services/style.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

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
          children: <Widget>[
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
            const MaterialButton(
                color: darkGreen,
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    "Create report",
                    style: TextStyle(
                        color: white,
                        fontSize: 15.0,
                        fontFamily: "WorkSansBold"),
                  ),
                ),
                onPressed: _createPDF),
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

Future<void> _createPDF() async {
  final QuerySnapshot snap =
      await FirebaseFirestore.instance.collection("diseases").get();
  final List diseaseNames = [];
  final Map diseaseCountMap = {};
  for (int i = 0; i < snap.docs.length; i++) {
    var a = snap.docs[i];
    diseaseNames.add(a["disease name"]);
  }
  for (var element in diseaseNames) {
    if (!diseaseCountMap.containsKey(element)) {
      diseaseCountMap[element] = 1;
    } else {
      diseaseCountMap[element] += 1;
    }
  }
  final List diseaseCountList = [];
  diseaseCountList.addAll(diseaseCountMap.values);
  diseaseCountList.sort();
  var mostFrequentDiseaseCount = diseaseCountList.last;
  var mostFrequentDiseaseName = diseaseCountMap.keys.firstWhere(
      (k) => diseaseCountMap[k] == mostFrequentDiseaseCount,
      orElse: () => null);
  PdfDocument pdfdocument = PdfDocument();
  final page = pdfdocument.pages.add();
  page.graphics.drawString(
      'Top Diseases Report', PdfStandardFont(PdfFontFamily.helvetica, 30));

  PdfGrid grid = PdfGrid();
  grid.style = PdfGridStyle(
      font: PdfStandardFont(PdfFontFamily.helvetica, 20),
      cellPadding: PdfPaddings(left: 5, right: 2, top: 2, bottom: 2));

  grid.columns.add(count: 2);
  grid.headers.add(1);

  PdfGridRow header = grid.headers[0];
  header.cells[0].value = 'Disease name';
  header.cells[1].value = 'Number of times detected';
  PdfGridRow row = grid.rows.add();
  row.cells[0].value = mostFrequentDiseaseName;
  row.cells[1].value = mostFrequentDiseaseCount.toString();

  grid.draw(
      page: pdfdocument.pages.add(), bounds: const Rect.fromLTWH(0, 0, 0, 0));

  List<int> bytes = pdfdocument.save();
  pdfdocument.dispose();
  saveAndLaunchFile(bytes, 'Diseases Report.pdf');
}

Future<void> saveAndLaunchFile(List<int> bytes, String fileName) async {
  final path = (await getExternalStorageDirectory())?.path;
  final file = File('$path/$fileName');
  await file.writeAsBytes(bytes, flush: true);
  OpenFile.open('$path/$fileName');
}