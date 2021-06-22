import 'package:firebase_core/firebase_core.dart';
import 'package:projeck_uas/Page_Auth/loginPage.dart';
import 'package:projeck_uas/Page_Landing/landingPage.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Page_onBoarding/onbording.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.greenAccent));
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var onBoarding = prefs.getBool("Onboarding");
  var login = prefs.getString("email");
  runApp((GetMaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      debugShowCheckedModeBanner: false,
      home: onBoarding == null
          ? Onbording()
          : login == null
              ? LoginPage()
              : Landing())));
}
