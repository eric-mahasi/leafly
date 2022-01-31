import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:leafly/core/sign_in.dart';
import 'package:leafly/core/sign_up.dart';
import 'package:leafly/core/onboarding.dart';
import 'package:leafly/providers/app.dart';
import 'package:leafly/providers/user.dart';
import 'package:leafly/screens/home_page.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: AppProvider()),
    ChangeNotifierProvider.value(value: UserProvider.initialize()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Leafly',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const OnBoardingPage(),
    );
  }
}

class ScreensController extends StatelessWidget {
  const ScreensController({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<UserProvider>(context);
    switch (auth.status) {
      case Status.Unauthenticated:
        return const SignUpPage();
      case Status.Authenticating:
        return const SignInPage();
      case Status.Authenticated:
        return const HomePage();
      default:
        return const SignInPage();
    }
  }
}
