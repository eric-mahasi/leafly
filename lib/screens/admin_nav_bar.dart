import 'package:flutter/material.dart';
import 'package:leafly/core/admin_sign_in.dart';
import 'package:leafly/providers/user.dart';
import 'package:leafly/screens/admin_page.dart';
import 'package:leafly/screens/dashboard.dart';
import 'package:leafly/services/screen_navigation.dart';
import 'package:leafly/services/style.dart';
import 'package:provider/provider.dart';

class AdminNavDrawer extends StatelessWidget {
  const AdminNavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
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
            title: const Text("Manage Users"),
            leading: IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            onTap: () {
              Navigator.of(context).pop();
              changeScreenReplacement(context, const AdminPage());
            },
          ),
          const Divider(
            color: black,
          ),
          ListTile(
            title: const Text("Dashboard"),
            leading: IconButton(
              icon: const Icon(Icons.bar_chart),
              onPressed: () {},
            ),
            onTap: () {
              Navigator.of(context).pop();
              changeScreenReplacement(context, const Dashboard());
            },
          ),
          const Divider(
            color: black,
          ),
          ListTile(
            title: const Text("Sign out"),
            leading: IconButton(
              icon: const Icon(Icons.add_to_home_screen),
              onPressed: () {},
            ),
            onTap: () async {
              authProvider.signOut();
              const snackBar =
                  SnackBar(content: Text("Successfully signed out"));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
              changeScreenReplacement(context, const AdminSignInPage());
            },
          ),
        ],
      ),
    );
  }
}
