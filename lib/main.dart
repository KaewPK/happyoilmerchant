import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/view/home.dart';
import 'package:happyoilmerchant/UI/view/splashscreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var _islogin = prefs.getString('Customer');
  runApp(
    MaterialApp(
      home: _islogin == null ? SplashscreenView() : HomeView(),
    ),
  );
}
