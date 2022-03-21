import 'dart:io';

import 'package:flutter/material.dart';
import 'package:leafly/models/disease_model.dart';
import 'package:leafly/screens/plant_image.dart';
import 'package:leafly/screens/text_property.dart';
import 'package:leafly/services/disease_provider.dart';
import 'package:leafly/services/style.dart';
import 'package:provider/provider.dart';

class Suggestions extends StatelessWidget {
  const Suggestions({Key? key}) : super(key: key);

  static const routeName = '/suggestions';

  @override
  Widget build(BuildContext context) {
    // Get disease from provider
    final _diseaseService = Provider.of<DiseaseService>(context);

    Disease _disease = _diseaseService.disease;
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        title: const Text('Suggestions'),
      ),
      body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                    'assets/images/green-leaves-white-background.jpg'),
                fit: BoxFit.cover),
          ),
          child: Padding(
            padding: EdgeInsets.all((0.02 * size.height)),
            child: Column(
              children: [
                Flexible(
                    child: Center(
                        child: PlantImage(
                  size: size,
                  imageFile: File(_disease.imagePath),
                ))),
                Divider(
                  thickness: (0.0066 * size.height),
                  height: (0.013 * size.height),
                ),
                SizedBox(
                  height: size.height * 0.5,
                  child: ListView(
                    children: [
                      TextProperty(
                        title: 'Disease name',
                        value: _disease.name,
                        height: size.height,
                      ),
                      TextProperty(
                        title: 'Possible causes',
                        value: _disease.possibleCauses,
                        height: size.height,
                      ),
                      TextProperty(
                        title: 'Possible solution',
                        value: _disease.possibleSolution,
                        height: size.height,
                      ),
                    ],
                  ),
                )
              ],
            ),
          )),
    );
  }
}
