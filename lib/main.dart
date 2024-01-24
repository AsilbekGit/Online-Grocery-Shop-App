import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:project/pages/Sign_in.dart';
import 'package:project/pages/home_page.dart';
import 'package:project/pages/intro_screen.dart';
import 'package:project/pages/paymentPage.dart';
import 'package:project/pages/productDescriptionPage.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';
import 'model/cart_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options:DefaultFirebaseOptions.currentPlatform);
  runApp(
    ChangeNotifierProvider(
      create: (context) => CartModel(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Online Grocery Shop',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: FutureBuilder(
        future: checkFirstSeen(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return IntroScreen();
            } else {
              return SignInScreen();
            }
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  Future<bool> checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      return false;
    } else {
      await prefs.setBool('seen', true);
      return true;
    }
  }
}
