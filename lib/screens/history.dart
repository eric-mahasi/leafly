import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:leafly/models/disease_model.dart';
import 'package:leafly/screens/suggestions.dart';
import 'package:leafly/services/disease_provider.dart';
import 'package:leafly/services/hive_database.dart';
import 'package:leafly/services/screen_navigation.dart';
import 'package:leafly/services/style.dart';

class HistorySection extends SliverFixedExtentList {
  HistorySection(Size size, BuildContext context, DiseaseService diseaseService,
      {Key? key})
      : super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              return ValueListenableBuilder<Box<Disease>>(
                valueListenable: Boxes.getDiseases().listenable(),
                builder: (context, box, _) {
                  final diseases = box.values.toList().cast<Disease>();

                  if (diseases.isNotEmpty) {
                    return Padding(
                      padding: EdgeInsets.fromLTRB((0.053 * size.height * 0.3),
                          (0.053 * size.height * 0.3), 0, 0),
                      child: SizedBox(
                          width: size.width,
                          child: ListView.builder(
                            itemCount: diseases.length,
                            padding: EdgeInsets.symmetric(
                                vertical: (0.035 * size.height * 0.3)),
                            itemExtent: size.width * 0.9,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return _returnHistoryContainer(diseases[index],
                                  context, diseaseService, size);
                            },
                          )),
                    );
                  } else {
                    return _returnNothingToShow(size);
                  }
                },
              );
            },
            childCount: 1,
          ),
          itemExtent: size.height * 0.3,
        );
}

Widget _returnHistoryContainer(Disease disease, BuildContext context,
    DiseaseService diseaseService, Size size) {
  return Padding(
    padding: EdgeInsets.fromLTRB(
        (0.053 * size.height * 0.3), 0, (0.053 * size.height * 0.3), 0),
    child: GestureDetector(
      onTap: () {
        // Set disease for Disease Service
        diseaseService.setDiseaseValue(disease);

        changeScreenReplacement(context, const Suggestions());
      },
      child: Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: Image.file(
                File(disease.imagePath),
                fit: BoxFit.cover,
              ).image),
              boxShadow: [
                BoxShadow(
                  color: primary,
                  spreadRadius: 0.5,
                  blurRadius: (0.022 * size.height * 0.3),
                ),
              ],
              color: darkGreen,
              borderRadius: BorderRadius.circular((0.053 * size.height * 0.3))),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Disease: ${disease.name}',
                    style: TextStyle(
                      color: white,
                      fontSize: (0.066 * size.height * 0.3),
                      fontFamily: 'SFBold',
                    )),
                Text(
                    'Date: ${disease.dateTime.day}/${disease.dateTime.month}/${disease.dateTime.year}',
                    style: TextStyle(
                      color: white,
                      fontSize: (0.066 * size.height * 0.3),
                      fontFamily: 'SFBold',
                    )),
              ],
            ),
          )),
    ),
  );
}

Widget _returnNothingToShow(Size size) {
  return Padding(
    padding: EdgeInsets.fromLTRB((0.053 * size.height * 0.3),
        (0.053 * size.height * 0.3), (0.053 * size.height * 0.3), 0),
    child: Container(
        decoration: BoxDecoration(
            color: darkGreen,
            borderRadius: BorderRadius.circular((0.053 * size.height * 0.3))),
        child: Padding(
          padding: EdgeInsets.fromLTRB(0, 0, 0, (0.066 * size.height * 0.3)),
          child: const Center(
              child: Text(
            'Nothing to show',
            style: TextStyle(color: white),
          )),
        )),
  );
}
