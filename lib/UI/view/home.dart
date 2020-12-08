import 'dart:async';
import 'package:happyoilmerchant/UI/const.dart';
import 'package:happyoilmerchant/UI/shared/api.dart';
import 'package:happyoilmerchant/UI/view/login.dart';
import 'package:happyoilmerchant/UI/view/machine.dart';
import 'package:happyoilmerchant/UI/view/massage.dart';
import 'package:happyoilmerchant/UI/view/oilTank.dart';
import 'package:happyoilmerchant/UI/view/order.dart';
import 'package:happyoilmerchant/UI/view/sales.dart';
import 'package:happyoilmerchant/UI/view/setPrice.dart';
import 'package:happyoilmerchant/UI/view/totalIncome.dart';
import 'package:happyoilmerchant/UI/widget/dialogwidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  // List menu to image
  List<String> image = [
    "asset/TotalMachine.png",
    "asset/CheckMachine.png",
    "asset/OilInTank.png",
    "asset/CheckSales.png",
    "asset/OrderOil.png",
    "asset/PriceCorrection.png",
  ];

  // List menu to name EN
  List<String> name = [
    "Total InCome",
    "Check Machine",
    "Oil In Tank",
    "Check Sales",
    "Order Oil",
    "Price Correction",
  ];

  // List menu to name TH
  List<String> nameDetail = [
    "(ตรวจสอบสถานะยอดขาย)",
    "(ตรวจสอบสถานะเครื่อง)",
    "(ตรวจสอบสถานะน้ำมัน)",
    "(ตรวจสอบยอดขายต่อวัน)",
    "(สั่งซื้อน้ำมัน)",
    "(ปรับแก้ราคาน้ำมัน)",
  ];

  // List menu to next show widget
  List<Widget> onTap = [
    TotalInComeView(),
    MachineView(),
    OilTankView(),
    SalesView(),
    OrderView(),
    SetPriceView(),
    //SetPriceView(),
  ];

  // Remove SharedPreferences
  removeValues() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    //Remove String
    //print(prefs.get('Customer'));
    prefs.remove("Customer");
    prefs.remove("StationId");
    prefs.remove("StationCode");
    //print(prefs.get('token'));
  }

  // Dialog Logout
  void showdialog() {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false, // for tap button!
      builder: (BuildContext context) {
        return CustomImageTwoButtonDialog(
          title: "ออกจากระบบ",
          image: 'asset/logo.png',
          fontsize: size.height * 0.025,
          next1: () {
            removeValues();
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => LoginView(),
                ),
                (Route<dynamic> route) => false);
          },
          next2: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    Const.initFirebaseMessaging();
    Api.apiSumValue();
    Api.apiShowMachine();
    Api.apiLocationMachine();
    Api.apiShowMachineRemain();
    Api.apiShowDailyMachine();
    Api.apiSelectMachineOilPrice();
    Timer.periodic(
      Duration(seconds: 3),
      (Timer t) => () {
        Api.apiSumValue();
        Api.apiShowMachine();
        Api.apiLocationMachine();
        Api.apiShowMachineRemain();
        Api.apiShowDailyMachine();
        Api.apiSelectMachineOilPrice();
      },
    );
    //print(Const.sumValue);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mediaQueryData = MediaQuery.of(context);
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Global.greenLight,
        appBar: AppBar(
          leading: IconButton(
              iconSize: size.height * 0.04,
              icon: Icon(
                Icons.notifications,
                color: Global.green,
              ),
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(
                    builder: (BuildContext context) => MessageView(),
                  ),
                  (Route<dynamic> route) => false,
                );
              }),
          centerTitle: true,
          title: Text(
            "MENU",
            style: GoogleFonts.prompt(
              color: Global.green,
              fontSize: size.height * 0.045,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Global.white,
          elevation: 0.0,
          actions: <Widget>[
            IconButton(
              iconSize: size.height * 0.04,
              icon: Icon(
                Icons.exit_to_app,
                color: Global.green,
              ),
              onPressed: showdialog,
            )
          ],
        ),
        body: SafeArea(
          child: Column(
            children: [
              SizedBox(height: size.height * 0.02),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  height: size.height * 0.75,
                  width: size.width * 0.9,
                  child: Center(
                    child: GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 6,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) => GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushAndRemoveUntil(
                            MaterialPageRoute(
                              builder: (BuildContext context) => onTap[index],
                            ),
                            (Route<dynamic> route) => false,
                          );
                        },
                        child: Card(
                          elevation: 8,
                          color: Global.white,
                          child: Padding(
                            padding: const EdgeInsets.all(10),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Container(
                                    height: size.height * 0.1,
                                    child: Image.asset(image[index]),
                                  ),
                                  Text(
                                    name[index],
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.018,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  Text(
                                    nameDetail[index],
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.012,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  height: size.height * 0.15,
                  color: Global.yellow,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
