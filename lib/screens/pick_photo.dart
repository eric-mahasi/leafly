// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:leafly/models/disease_model.dart';
import 'package:leafly/screens/suggestions.dart';
import 'package:leafly/screens/title_section.dart';
import 'package:leafly/screens/try_again.dart';
import 'package:leafly/services/classify.dart';
import 'package:leafly/services/disease_provider.dart';
import 'package:leafly/services/hive_database.dart';
import 'package:leafly/services/screen_navigation.dart';
import 'package:leafly/services/style.dart';
import 'package:leafly/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

import 'history.dart';
import 'instructions.dart';

class PickPhoto extends StatefulWidget {
  const PickPhoto({Key? key}) : super(key: key);

  @override
  _PickPhotoState createState() => _PickPhotoState();
}

class _PickPhotoState extends State<PickPhoto> {
  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final _diseaseService = Provider.of<DiseaseService>(context);
    // Hive service
    HiveService _hiveService = HiveService();
    // Data
    Size size = MediaQuery.of(context).size;
    final Classifier classifier = Classifier();
    late Disease _disease;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0,
        ),
        drawer: const NavDrawer(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: SpeedDial(
          icon: Icons.camera_alt,
          spacing: 10,
          children: [
            SpeedDialChild(
              child: const FaIcon(
                FontAwesomeIcons.file,
                color: white,
              ),
              label: "Choose image",
              backgroundColor: primary,
              onTap: () async {
                late double _confidence;
                await classifier.getDisease(ImageSource.gallery).then((value) {
                  _disease = Disease(
                      name: value![0]["label"],
                      imagePath: classifier.imageFile.path);

                  _confidence = value[0]['confidence'];
                });
                // Check confidence
                if (_confidence > 0.8) {
                  // Set disease for Disease Service
                  _diseaseService.setDiseaseValue(_disease);

                  // Save disease
                  _hiveService.addDisease(_disease);
                  final FirebaseAuth auth = FirebaseAuth.instance;
                  final User? user = auth.currentUser;
                  final userID = user?.uid ?? "";
                  Map<String, String> map = {
                    "disease name": _disease.name,
                    "detected date": _disease.dateTime.toString(),
                    "user id": userID
                  };
                  FirebaseFirestore.instance.collection("diseases").doc().set(
                      map);
                  changeScreenReplacement(context, const Suggestions());
                } else {
                  // Display unsure message
                  changeScreenReplacement(context, const TryAgain());
                }
              },
            ),
            SpeedDialChild(
              child: const FaIcon(
                FontAwesomeIcons.camera,
                color: white,
              ),
              label: "Take photo",
              backgroundColor: primary,
              onTap: () async {
                late double _confidence;

                await classifier.getDisease(ImageSource.camera).then((value) {
                  _disease = Disease(
                      name: value![0]["label"],
                      imagePath: classifier.imageFile.path);

                  _confidence = value[0]['confidence'];
                });

                // Check confidence
                if (_confidence > 0.8) {
                  // Set disease for Disease Service
                  _diseaseService.setDiseaseValue(_disease);
                  // Save disease
                  _hiveService.addDisease(_disease);
                  changeScreenReplacement(context, const Suggestions());
                } else {
                  changeScreenReplacement(context, const TryAgain());
                }
              },
            ),
          ],
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/green-leaves-white-background.jpg'),
                fit: BoxFit.cover),
          ),
          child: CustomScrollView(
            slivers: [
              TitleSection('Instructions', size.height * 0.066),
              InstructionsSection(size),
              TitleSection('Your History', size.height * 0.066),
              HistorySection(size, context, _diseaseService)
            ],
          ),
        ));
    // bottomNavigationBar: const BottomNavBarWidget());
  }
}
