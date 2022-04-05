import 'package:flutter/material.dart';
import 'package:leafly/services/style.dart';

class TryAgain extends StatefulWidget {
  const TryAgain({Key? key}) : super(key: key);

  @override
  _TryAgainState createState() => _TryAgainState();
}

class _TryAgainState extends State<TryAgain> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primary,
        elevation: 0,
      ),
      body: Center(
        child: AlertDialog(
            title: const Text("Sorry"),
            content:
            const Text("Could not detect disease. Please try a different "
                "picture."),
            actions: [
              TextButton(
                // FlatButton widget is used to make a text to work like a button
                onPressed: () {
                  Navigator.pop(context);
                },
                // function used to perform after pressing the button
                child: const Text("Okay"),
              )
            ]),
      ),
      backgroundColor: darkGreen,
    );
  }
}
