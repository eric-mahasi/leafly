import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leafly/screens/admin_nav_bar.dart';
import 'package:leafly/services/style.dart';
import 'package:leafly/services/user.dart';

class AdminPage extends StatefulWidget {
  const AdminPage({Key? key}) : super(key: key);

  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  @override
  Widget build(BuildContext context) {
    final UserServices _userServices = UserServices();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0,
          title: const Text(
            "Users",
            style: TextStyle(color: black),
          ),
        ),
        body: StreamBuilder(
            stream: _userServices.users.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
              if (streamSnapshot.hasData) {
                return ListView.builder(
                    itemCount: streamSnapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final DocumentSnapshot documentSnapshot =
                          streamSnapshot.data!.docs[index];
                      return Card(
                          margin: const EdgeInsets.all(10),
                          child: ListTile(
                              title: Text(documentSnapshot["first name"] +
                                  " " +
                                  documentSnapshot["last name"]),
                              subtitle: Text(documentSnapshot["email"]),
                              trailing: SizedBox(
                                  width: 100,
                                  child: Row(children: [
                                    // This icon button is used to delete a single product
                                    IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: darkGreen,
                                        ),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                  title: const Text("Warning"),
                                                  // To display the title it is optional
                                                  content: const Text(
                                                      "Are you sure you want to delete this user?"),
                                                  // Message which will be pop up on the screen
                                                  // Action widget which will provide the user to acknowledge the choice
                                                  actions: [
                                                    TextButton(
                                                      // FlatButton widget is used to make a text to work like a button
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                      // function used to perform after pressing the button
                                                      child:
                                                          const Text("CANCEL"),
                                                    ),
                                                    TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        _userServices
                                                            .deleteUser(
                                                                documentSnapshot
                                                                    .id);
                                                        const snackBar = SnackBar(
                                                            content: Text(
                                                                "User deleted"));
                                                        ScaffoldMessenger.of(
                                                                context)
                                                            .showSnackBar(
                                                                snackBar);
                                                      },
                                                      child:
                                                          const Text("ACCEPT"),
                                                    ),
                                                  ],
                                                );
                                              });
                                        })
                                  ]))));
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }),
        drawer: const AdminNavDrawer());
  }
}
