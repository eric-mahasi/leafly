import 'package:flutter/material.dart';
import 'package:leafly/services/style.dart';

class InstructionsSection extends SliverFixedExtentList {
  InstructionsSection(Size size, {Key? key})
      : super(
          key: key,
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, index) {
              return Padding(
                padding: EdgeInsets.fromLTRB(
                    (0.061 * size.height * 0.26),
                    (0.071 * size.height * 0.26),
                    (0.076 * size.height * 0.26),
                    (0.076 * size.height * 0.26)),
                child: Container(
                  height: size.height * 0.26,
                  decoration: BoxDecoration(
                    color: darkGreen,
                    borderRadius:
                        BorderRadius.circular((0.061 * size.height * 0.26)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB((0.025 * size.height * 0.26),
                        0, 0, (0.025 * size.height * 0.26)),
                    child: ListView(
                      children: const [
                        ListTile(
                            leading: CircleAvatar(
                              backgroundColor: primary,
                              child: Text(
                                '1',
                                style: TextStyle(color: white),
                              ),
                            ),
                            title: Text(
                              'Take or select a photo of an affected leaf by tapping '
                              'the camera button below.',
                              style: TextStyle(color: white, fontSize: 20),
                            )),
                        ListTile(
                          leading: CircleAvatar(
                            backgroundColor: primary,
                            child: Text(
                              '2',
                              style: TextStyle(color: white),
                            ),
                          ),
                          title: Text(
                              'Please wait a few seconds for the disease to be '
                              'detected.',
                              style: TextStyle(color: white, fontSize: 20)),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: 1,
          ),
          itemExtent: size.height * 0.26,
        );
}
