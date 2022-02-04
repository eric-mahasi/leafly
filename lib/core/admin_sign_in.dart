import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:leafly/providers/user.dart';
import 'package:leafly/screens/admin_page.dart';
import 'package:leafly/services/screen_navigation.dart';
import 'package:leafly/services/style.dart';
import 'package:provider/provider.dart';

class AdminSignInPage extends StatefulWidget {
  const AdminSignInPage({Key? key}) : super(key: key);

  @override
  _AdminSignInPageState createState() => _AdminSignInPageState();
}

class _AdminSignInPageState extends State<AdminSignInPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    String defaultFontFamily = 'Roboto-Light.ttf';
    double defaultFontSize = 14;
    double defaultIconSize = 17;
    final authProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      body: Container(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 35, bottom: 30),
        width: double.infinity,
        height: double.infinity,
        color: primary,
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 1,
              child: InkWell(
                child: const Align(
                  alignment: Alignment.topLeft,
                  child: Icon(Icons.close),
                ),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ),
            Flexible(
              flex: 8,
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        child: Image.asset(
                          "assets/images/engineer.png",
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        showCursor: true,
                        controller: authProvider.email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter an email';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.email,
                            color: black,
                            size: defaultIconSize,
                          ),
                          fillColor: const Color(0xFFF2F3F5),
                          hintStyle: TextStyle(
                              color: const Color(0xFF666666),
                              fontFamily: defaultFontFamily,
                              fontSize: defaultFontSize),
                          hintText: "Email",
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        showCursor: true,
                        controller: authProvider.password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter a password';
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.0)),
                            borderSide: BorderSide(
                              width: 0,
                              style: BorderStyle.none,
                            ),
                          ),
                          filled: true,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: black,
                            size: defaultIconSize,
                          ),
                          suffixIcon: IconButton(
                              icon: Icon(_isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                              color: primary,
                              onPressed: () {
                                setState(() {
                                  _isObscure = !_isObscure;
                                });
                              }),
                          fillColor: const Color(0xFFF2F3F5),
                          hintStyle: TextStyle(
                            color: const Color(0xFF666666),
                            fontFamily: defaultFontFamily,
                            fontSize: defaultFontSize,
                          ),
                          hintText: "Password",
                        ),
                        obscureText: _isObscure,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                            color: darkGreen,
                            //shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0))),
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 42.0),
                              child: Text(
                                "ADMIN SIGN IN",
                                style: TextStyle(
                                    color: white,
                                    fontSize: 25.0,
                                    fontFamily: "WorkSansBold"),
                              ),
                            ),
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (!await authProvider.signIn()) {
                                  const snackBar =
                                      SnackBar(content: Text("Sign in failed"));
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  return;
                                }
                                authProvider.clearController();
                                changeScreenReplacement(
                                    context, const AdminPage());
                              }
                            }),
                      ),
                      const SizedBox(
                        height: 2,
                      ),
                    ],
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
