import 'package:google_fonts/google_fonts.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:happyoilmerchant/UI/view/login.dart';
import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashscreenView extends StatefulWidget {
  @override
  _SplashscreenViewState createState() => new _SplashscreenViewState();
}

class _SplashscreenViewState extends State<SplashscreenView> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new SplashScreen(
      seconds: 3,
      navigateAfterSeconds: LoginView(),
      title: Text(
        "Happy Oil Merchant",
        style: GoogleFonts.lobster(
          fontSize: size.height * 0.045,
          fontWeight: FontWeight.w500,
          color: Global.white,
        ),
      ),
      image: Image.asset(
        'asset/Asset1.png',
        fit: BoxFit.contain,
      ),
      backgroundColor: Global.green,
      styleTextUnderTheLoader: TextStyle(),
      photoSize: size.width * 0.35,
      loadingText: Text(
        "Welcome",
        style: GoogleFonts.indieFlower(
          fontSize: size.height * 0.03,
          fontWeight: FontWeight.w500,
          color: Global.white,
        ),
      ),
      loaderColor: Global.white,
    );
  }
}
