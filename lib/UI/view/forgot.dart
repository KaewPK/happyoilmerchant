import 'package:happyoilmerchant/UI/const.dart';
import 'package:happyoilmerchant/UI/shared/api.dart';
import 'package:happyoilmerchant/UI/view/repassword.dart';
import 'package:happyoilmerchant/UI/widget/dialogwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/widget/button_widget.dart';
import 'package:happyoilmerchant/UI/widget/textfield_widget.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart' as UrlLauncher;
import 'package:http/http.dart' as http;

class ForgotView extends StatefulWidget {
  @override
  _ForgotViewState createState() => _ForgotViewState();
}

class _ForgotViewState extends State<ForgotView> {
  final _username = TextEditingController();
  bool _validate = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _username.dispose();
    super.dispose();
  }

  // Function phone connect machine
  Future<void> _URLconnectPhone() async {
    UrlLauncher.launch('tel:0${021206342}');
  }

  // Function dialog to show on Appcation after send data to fail
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
              _username.clear();
            });
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Api Post Order
  apiPostCheckUsername(username) async {
    var url = Api.urlServer + '/api/Password/CheckUser';
    Map data = {'username': username};
    print('body: $data');
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      //var jsonResponse = convert.jsonDecode(response.body)["StatusCode"];
      //print(jsonResponse);
      setState(() {
        _isLoading = false;
        Const.username = _username.text;
        _username.clear();
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => RepasswordView(),
        ),
      );
    } else {
      print('apiPostCheckUsername Request failed : ${response.statusCode}.');
      setState(() {
        _isLoading = false;
        showdialogNoFinish("ไม่พบข้อมูล");
      });
    }
  }

  // Function dialog to input data fail
  void showdialogsuggestion() {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false, // for tap button!
      builder: (BuildContext context) {
        return CustomImageDialog(
          title: "โปรดระบุ Username ให้ถูกต้อง",
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
                  backgroundColor: Colors.transparent,
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
                                  height: size.height * 0.03,
                                ),
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "กรุณาใส่ Username :",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w500,
                                      color: Global.green,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
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
                                  height: size.height * 0.02,
                                ),
                                Container(
                                  width: size.width * 0.5,
                                  child: ButtonWidget(
                                    title: 'ตรวจสอบ',
                                    hasBorder: false,
                                    onTap: () {
                                      setState(
                                        () {
                                          _username.text.isEmpty
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
                                              _username.text);
                                    },
                                    button1: Global.white,
                                    button2: Global.green,
                                    colorhasBorder: Global.greenBlue,
                                    borderRadius: 10,
                                    height: size.height * 0.05,
                                    text1: Global.greenBlue,
                                    text2: Global.white,
                                    fontsize: size.height * 0.02,
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.03,
                                ),
                                FlatButton(
                                  onPressed: _URLconnectPhone,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.phone,
                                        color: Global.green,
                                      ),
                                      SizedBox(
                                        width: size.width * 0.03,
                                      ),
                                      Text(
                                        "02-475-1523",
                                        style: GoogleFonts.prompt(
                                          color: Global.green,
                                          fontSize: size.height * 0.02,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                )
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
