import 'package:happyoilmerchant/UI/const.dart';
import 'package:happyoilmerchant/UI/shared/api.dart';
import 'package:happyoilmerchant/UI/view/login.dart';
import 'package:happyoilmerchant/UI/widget/dialogwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/widget/button_widget.dart';
import 'package:happyoilmerchant/UI/widget/textfield_widget.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RepasswordView extends StatefulWidget {
  @override
  _RepasswordViewState createState() => _RepasswordViewState();
}

class _RepasswordViewState extends State<RepasswordView> {
  final _password = TextEditingController();
  final _confirmpassword = TextEditingController();
  bool _validate = false;
  bool _isLoading = false;
  bool _obscureTextLogin = true;
  bool _obscureTextLogin1 = true;

  @override
  void dispose() {
    _password.dispose();
    _confirmpassword.dispose();
    super.dispose();
  }

  // Api Post Order
  apiPostCheckUsername(password) async {
    var url = Api.urlServer + '/api/Password/ResetPasswordUser';
    Map data = {'username': Const.username, 'password': password};
    print('body: $data');
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      //var jsonResponse = convert.jsonDecode(response.body)["StatusCode"];
      //print(jsonResponse);
      setState(() {
        _isLoading = false;
        showdialogFinish("เปลี่ยนรหัสสำเร็จ");
      });
    } else {
      print(
          'apiPostCheckUsername Request failed with status: ${response.statusCode}.');
      setState(() {
        _isLoading = false;
        showdialogNoFinish("ไม่พบข้อมูล");
      });
    }
  }

  // Function dialog to show after send data finish and clear textfield password, textfield confirmpassword
  void showdialogFinish(String msg) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false, // for tap button!
      builder: (BuildContext context) {
        return CustomImageDialog(
          title: msg,
          image: 'asset/logo.png',
          fontsize: size.height * 0.025,
          next: () {
            setState(() {
              _password.clear();
              _confirmpassword.clear();
            });
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (BuildContext context) => LoginView(),
              ),
              (Route<dynamic> route) => false,
            );
          },
        );
      },
    );
  }

  // Function dialog to show after send data fail and clear textfield password, textfield confirmpassword
  void showdialogNoFinish(String msg) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false, // for tap button!
      builder: (BuildContext context) {
        return CustomImageDialog(
          title: msg,
          image: 'asset/logo.png',
          fontsize: size.height * 0.025,
          next: () {
            setState(() {
              _password.clear();
              _confirmpassword.clear();
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Function dialog to input data fail
  void showdialogsuggestion() {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false, // for tap button!
      builder: (BuildContext context) {
        return CustomImageDialog(
          title: "โปรดระบุ Username, New Password ให้ครบถ้วน",
          image: 'asset/logo.png',
          fontsize: size.height * 0.025,
          next: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
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
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Image.asset(
                    "asset/icon2.png",
                    fit: BoxFit.contain,
                    width: size.width,
                    height: size.height,
                  ),
                ],
              ),
              Container(
                child: Scaffold(
                  backgroundColor: Colors.transparent,
                  appBar: AppBar(
                    backgroundColor: Global.white,
                    elevation: 0.0,
                    leading: IconButton(
                      iconSize: size.height * 0.04,
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: Global.green,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  body: SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: <Widget>[
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                height: size.height * 0.18,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage('asset/logo.png'),
                                    fit: BoxFit.contain,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "reset password :",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w500,
                                      color: Global.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
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
                                        _obscureTextLogin = !_obscureTextLogin;
                                      });
                                    },
                                    suffixIconData: _obscureTextLogin
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Container(
                                  height: size.height * 0.06,
                                  child: TextFieldWidget(
                                    controller: _confirmpassword,
                                    hintText: 'Confirm Password',
                                    obscureText: _obscureTextLogin1,
                                    prefixIconData: Icons.lock,
                                    onTap: () {
                                      setState(() {
                                        _obscureTextLogin1 =
                                            !_obscureTextLogin1;
                                      });
                                    },
                                    suffixIconData: _obscureTextLogin1
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.5,
                                  child: ButtonWidget(
                                    title: 'ยืนยัน',
                                    hasBorder: false,
                                    onTap: () {
                                      setState(
                                        () {
                                          _password.text.isEmpty ||
                                                  _confirmpassword
                                                      .text.isEmpty ||
                                                  _password.text !=
                                                      _confirmpassword.text
                                              ? _validate = true
                                              : _validate = false;
                                          _validate
                                              ? _isLoading = false
                                              : _isLoading = true;
                                        },
                                      );
                                      _validate
                                          ? showdialogsuggestion()
                                          : apiPostCheckUsername(
                                              _password.text);
                                    },
                                    button1: Global.white,
                                    button2: Global.green,
                                    colorhasBorder: Global.greenBlue,
                                    borderRadius: 10,
                                    height: size.height * 0.06,
                                    text1: Global.greenBlue,
                                    text2: Global.white,
                                    fontsize: size.height * 0.02,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
