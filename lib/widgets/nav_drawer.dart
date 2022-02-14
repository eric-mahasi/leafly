import 'package:flutter/material.dart';
import 'package:leafly/screens/home_page.dart';
import 'package:leafly/screens/pick_photo.dart';
import 'package:leafly/services/screen_navigation.dart';
import 'package:leafly/services/style.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: darkGreen,
            ),
            child: Center(
              child: Row(
                children: const [
                  Expanded(
                    child: Icon(
                      Icons.account_circle,
                      color: Colors.white,
                      size: 40,
                    ),
                    flex: 2,
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(
                      "Welcome ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListTile(
            title: const Text("Home"),
            leading: IconButton(
              icon: const Icon(Icons.home),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
              changeScreenReplacement(context, const HomePage());
            },
          ),
          const Divider(
            color: black,
          ),
          ListTile(
            title: const Text("Detect"),
            leading: IconButton(
              icon: const Icon(Icons.add_a_photo),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              changeScreenReplacement(context, const PickPhoto());
            },
          ),
          const Divider(
            color: black,
          ),
          ListTile(
            title: const Text("Account"),
            leading: IconButton(
              icon: const Icon(Icons.account_circle_outlined),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }
}
