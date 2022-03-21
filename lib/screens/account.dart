import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:leafly/core/sign_in.dart';
import 'package:leafly/providers/user.dart';
import 'package:leafly/services/screen_navigation.dart';
import 'package:leafly/services/style.dart';
import 'package:leafly/services/user.dart';
import 'package:leafly/widgets/nav_drawer.dart';
import 'package:provider/provider.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({Key? key}) : super(key: key);

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final UserServices _userServices = UserServices();
  String firstName = " ";
  String lastName = " ";

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<UserProvider>(context);
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userEmail = user?.email ?? "";

    return Scaffold(
        appBar: AppBar(
          backgroundColor: primary,
          elevation: 0,
        ),
        body: Center(
            child: Form(
          key: _formKey,
          child: Column(children: [
            GestureDetector(
              onTap: () async {
                final QuerySnapshot snap = await FirebaseFirestore.instance
                    .collection("users")
                    .where("email", isEqualTo: userEmail)
                    .get();
                setState(() {
                  firstName = snap.docs[0]["first name"];
                  lastName = snap.docs[0]["last name"];
                });
              },
              child: Text(
                firstName + " " + lastName,
                style: const TextStyle(
                    color: black, fontSize: 40.0, fontFamily: "WorkSansBold"),
              ),
            ),
            Row(
              children: <Widget>[
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: authProvider.first_name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                    showCursor: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                        color: Color(0xFF666666),
                      ),
                      hintText: "First Name",
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: TextFormField(
                    controller: authProvider.last_name,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                    showCursor: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderSide: BorderSide(
                          width: 0,
                          style: BorderStyle.none,
                        ),
                      ),
                      filled: true,
                      fillColor: Color(0xFFF2F3F5),
                      hintStyle: TextStyle(
                        color: Color(0xFF666666),
                      ),
                      hintText: "Last Name",
                    ),
                  ),
                ),
              ],
            ),
            Row(children: [
              Expanded(
                flex: 1,
                child: MaterialButton(
                    color: darkGreen,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "REFRESH",
                        style: TextStyle(
                            color: white,
                            fontSize: 15.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () async {
                      final QuerySnapshot snap = await FirebaseFirestore
                          .instance
                          .collection("users")
                          .where("email", isEqualTo: userEmail)
                          .get();
                      setState(() {
                        firstName = snap.docs[0]["first name"];
                        lastName = snap.docs[0]["last name"];
                      });
                    }),
              ),
              Expanded(
                flex: 1,
                child: MaterialButton(
                    color: darkGreen,
                    //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 42.0),
                      child: Text(
                        "UPDATE",
                        style: TextStyle(
                            color: white,
                            fontSize: 15.0,
                            fontFamily: "WorkSansBold"),
                      ),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Map<String, String> map = {
                          "first name": authProvider.first_name.text.trim(),
                          "last name": authProvider.last_name.text.trim()
                        };
                        _userServices.updateUserData(map);
                        const snackBar =
                            SnackBar(content: Text("Successfully updated"));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        authProvider.clearController();
                      }
                    }),
              ),
            ]),
            const Flexible(
                child: SizedBox(
              height: 500,
            )),
            MaterialButton(
                color: darkGreen,
                //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                child: const Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 42.0),
                  child: Text(
                    "SIGN OUT",
                    style: TextStyle(
                        color: white,
                        fontSize: 25.0,
                        fontFamily: "WorkSansBold"),
                  ),
                ),
                onPressed: () async {
                  authProvider.signOut();
                  const snackBar =
                      SnackBar(content: Text("Successfully signed out"));
                  authProvider.clearController();
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  changeScreenReplacement(context, const SignInPage());
                }),
          ]),
        )),
        drawer: const NavDrawer());
  }
}
