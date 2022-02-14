// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:leafly/screens/title_section.dart';
import 'package:leafly/services/style.dart';
import 'package:leafly/widgets/nav_drawer.dart';

import 'instructions.dart';

class PickPhoto extends StatefulWidget {
  const PickPhoto({Key? key}) : super(key: key);

  @override
  _PickPhotoState createState() => _PickPhotoState();
}

class _PickPhotoState extends State<PickPhoto> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
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
              onTap: () async {},
            ),
            SpeedDialChild(
              child: const FaIcon(
                FontAwesomeIcons.camera,
                color: white,
              ),
              label: "Take photo",
              backgroundColor: primary,
              onTap: () async {},
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
              InstructionsSection(size)
            ],
          ),
        ));
    // bottomNavigationBar: const BottomNavBarWidget());
  }
}
