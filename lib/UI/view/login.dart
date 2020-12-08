import 'dart:convert';
import 'package:google_fonts/google_fonts.dart';
import 'package:happyoilmerchant/UI/shared/api.dart';
import 'package:happyoilmerchant/UI/view/forgot.dart';
import 'package:happyoilmerchant/UI/widget/checkbox_widget.dart';
import 'package:happyoilmerchant/UI/widget/dialogwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/widget/button_widget.dart';
import 'package:happyoilmerchant/UI/widget/textfield_widget.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:happyoilmerchant/UI/view/home.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class LoginView extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _validate = false;
  bool _isLoading = false;
  bool rememberMe = false;
  bool _obscureTextLogin = true;
  String user_remember, pass_remember;

  @override
  void initState() {
    super.initState();
    checkdata_remember();
  }

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  // Function clear textField Username, Password
  void clearText() {
    _username.clear();
    _password.clear();
  }

  // Function clear Username, Password SharedPreferences or Key to save on Appication
  rememberme_clear() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("username");
    prefs.remove("password");
    setState(() {
      rememberMe = false;
    });
  }

  // Function check condition Username, Password from SharedPreferences or Key on Appication
  checkdata_remember() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //print(prefs.get('username'));
    //print(prefs.get('password'));
    setState(() {
      user_remember = prefs.get('username');
      pass_remember = prefs.get('password');
      user_remember != null && pass_remember != null
          ? rememberMe = true
          : rememberMe = false;
    });
    user_remember != null && pass_remember != null
        ? {_username.text = user_remember, _password.text = pass_remember}
        : null;
  }

  // Function save Username, Password from SharedPreferences or Key on Appication
  remember_me(String user, pass) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("username", user);
    sharedPreferences.setString("password", pass);
  }

  // Function dialog to show on Appcation after login fail
  void showdialogsuggestion() {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false, // for tap button!
      builder: (BuildContext context) {
        return CustomImageDialog(
          title: "โปรดระบุ Username, Password ให้ถูกต้อง",
          image: 'asset/logo.png',
          fontsize: size.height * 0.025,
          next: () {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => LoginView()),
                (Route<dynamic> route) => false);
          },
        );
      },
    );
  }

  // Function Login send username, password
  signIn(String username, password) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    Map data = {
      'username': username,
      'password': password,
    };
    var jsonResponse = null;
    try {
      print(data);
      var response =
          await http.post(Api.urlServer + "/api/LoginOwner", body: data);
      jsonResponse = json.decode(response.body);
      if (jsonResponse != null) {
        //print("$jsonResponse");
        if (jsonResponse["status"] == true) {
          setState(() {
            _isLoading = false;
            // Save sharedPreferences or key Customer
            sharedPreferences.setString('Customer', jsonResponse['Customer']);
            // Save sharedPreferences or key StationId
            sharedPreferences.setString(
                'StationId', jsonResponse['Station']['result'][0]['id']);
            // Save sharedPreferences or key StationCode
            sharedPreferences.setString('StationCode',
                jsonResponse['Station']['result'][0]['stationCode']);
            // Function next to homepage
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomeView()),
                (Route<dynamic> route) => false);
          });
        } else {
          setState(() {
            _isLoading = false;
          });
          // Function Login Fail
          showdialogsuggestion();
        }
      } else if (jsonResponse == null) {
        setState(() {});
        // Function Login Fail
        showdialogsuggestion();
      }
    } catch (Exception) {
      print(Exception);
      // Function Login Fail
      showdialogsuggestion();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: MaterialApp(
        home: Container(
          color: Global.white,
          child: _isLoading
              ? Center(
                  child: ScalingText(
                    'Loading...',
                    style: TextStyle(
                      fontSize: size.height * 0.02,
                      color: Global.green,
                    ),
                  ),
                )
              : Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Image.asset(
                          "asset/icon2.png",
                          fit: BoxFit.fill,
                          width: size.width,
                          height: size.height,
                        ),
                      ],
                    ),
                    Container(
                      child: Scaffold(
                        backgroundColor: Colors.transparent,
                        body: SafeArea(
                          child: SingleChildScrollView(
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      SizedBox(
                                        height: size.height * 0.01,
                                      ),
                                      Container(
                                        height: size.height * 0.18,
                                        width: size.width,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: AssetImage('asset/logo.png'),
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(
                                        height: size.height * 0.03,
                                      ),
                                      Container(
                                        height: size.height * 0.06,
                                        child: TextFieldWidget(
                                          controller: _username,
                                          hintText: 'Username',
                                          obscureText: false,
                                          prefixIconData: Icons.person,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.03,
                                      ),
                                      Container(
                                        height: size.height * 0.06,
                                        child: TextFieldWidget(
                                          controller: _password,
                                          hintText: 'Password',
                                          obscureText: _obscureTextLogin,
                                          prefixIconData: Icons.lock,
                                          onTap: () {
                                            setState(() {
                                              _obscureTextLogin =
                                                  !_obscureTextLogin;
                                            });
                                          },
                                          suffixIconData: _obscureTextLogin
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                        ),
                                      ),
                                      SizedBox(
                                        height: size.height * 0.015,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          GestureDetector(
                                            child: RowcheckboxWidget(
                                              title: "Remember me",
                                              boolValue: rememberMe,
                                              onChanged: (bool value) {
                                                setState(() {
                                                  rememberMe = value;
                                                });
                                              },
                                            ),
                                            onTap: () {
                                              setState(() {
                                                rememberMe = !rememberMe;
                                              });
                                            },
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          ForgotView(),
                                                ),
                                              );
                                            },
                                            child: Text(
                                              'Forgot password?',
                                              style: GoogleFonts.prompt(
                                                color: Global.green,
                                                fontSize: size.height * 0.018,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: size.height * 0.025,
                                      ),
                                      Container(
                                        width: size.width * 0.5,
                                        child: ButtonWidget(
                                          title: 'Login',
                                          hasBorder: false,
                                          onTap: () {
                                            setState(
                                              () {
                                                _username.text.isEmpty ||
                                                        _password.text.isEmpty
                                                    ? _validate = true
                                                    : _validate = false;
                                                _validate
                                                    ? _isLoading = false
                                                    : _isLoading = true;
                                              },
                                            );
                                            _validate
                                                ? showdialogsuggestion()
                                                : signIn(
                                                    _username.text,
                                                    _password.text,
                                                  );
                                            rememberMe
                                                ? remember_me(_username.text,
                                                    _password.text)
                                                : rememberme_clear();
                                          },
                                          button1: Global.white,
                                          button2: Global.green,
                                          colorhasBorder: Global.greenBlue,
                                          borderRadius: 10,
                                          height: size.height * 0.06,
                                          text1: Global.greenBlue,
                                          text2: Global.white,
                                          fontsize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
