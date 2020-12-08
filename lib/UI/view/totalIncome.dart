import 'package:happyoilmerchant/UI/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:flutter_money_formatter/flutter_money_formatter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happyoilmerchant/UI/view/home.dart';

class TotalInComeView extends StatefulWidget {
  @override
  _TotalInComeViewState createState() => _TotalInComeViewState();
}

class _TotalInComeViewState extends State<TotalInComeView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mediaQueryData = MediaQuery.of(context);
    // Format Money
    FlutterMoneyFormatter fmf = FlutterMoneyFormatter(
        amount: double.parse((Const.sumValue != null) ? Const.sumValue : "0"));
    MoneyFormatterOutput fo = fmf.output;
    return MediaQuery(
      data: mediaQueryData.copyWith(textScaleFactor: 1.0),
      child: Scaffold(
        backgroundColor: Global.green,
        appBar: AppBar(
          leading: IconButton(
            iconSize: size.height * 0.04,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Global.green,
            ),
            onPressed: () {
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                  builder: (BuildContext context) => HomeView(),
                ),
                (Route<dynamic> route) => false,
              );
            },
          ),
          centerTitle: true,
          title: Text(
            "Total Income",
            style: GoogleFonts.prompt(
              color: Global.green,
              fontSize: size.height * 0.045,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Global.white,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Container(
                height: size.height * 0.5,
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                    height: size.height * 0.4,
                    width: size.width * 0.9,
                    child: Card(
                      elevation: 8,
                      color: Global.white,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "รายได้ทั้งหมด",
                            style: GoogleFonts.prompt(
                              fontSize: size.height * 0.04,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          SizedBox(height: size.height * 0.02),
                          Text(
                            (fo == null) ? "0.00 บาท" : fo.nonSymbol + " บาท",
                            textScaleFactor: 1,
                            style: GoogleFonts.prompt(
                              fontSize: size.height * 0.04,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  width: size.width,
                  color: Global.yellow,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "asset/TotalMachine.png",
                        fit: BoxFit.contain,
                        width: size.width * 0.35,
                      ),
                    ],
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
