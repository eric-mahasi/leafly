import 'package:flutter/material.dart';
import 'package:leafly/services/style.dart';

class TextProperty extends StatelessWidget {
  const TextProperty(
      {Key? key,
      required this.title,
      required this.value,
      required this.height})
      : super(key: key);

  final String title;
  final double height;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(
              color: darkGreen,
              fontFamily: 'SFBold',
              fontSize: (0.039 * height),
            ),
          ),
          subtitle: Text(
            value,
            style: TextStyle(
              color: black,
              fontFamily: 'SFRegular',
              fontSize: (0.026 * height),
            ),
          ),
        )
      ],
    );
  }
}
