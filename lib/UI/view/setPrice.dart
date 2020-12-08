import 'package:happyoilmerchant/UI/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/shared/api.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happyoilmerchant/UI/view/home.dart';
import 'package:happyoilmerchant/UI/widget/dialogwidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class SetPriceView extends StatefulWidget {
  @override
  _SetPriceViewState createState() => _SetPriceViewState();
}

class _SetPriceViewState extends State<SetPriceView> {
  final _oilprice = TextEditingController();
  int index = 0;
  List<String> nameDropDown = List<String>();
  int _length = Const.showMachine.length;
  String _value;
  List<String> name;
  String _oilName, _oilValue, _machineId, _pricelistDetailId;
  int _lengthdetail = Const.selectMachineOilPrice.length;

  // For loop dropdown menu
  setNameDropDown() {
    nameDropDown.clear();
    for (int i = 0; i < _length; i++) {
      nameDropDown.add(Const.showMachine[i].name);
      //print('print : ${Const.showMachine[i].name}');
    }
  }

  // For loop select from dropdown menu to show oilname, oilValue, machineId, pricelistDetailId
  setStationCode() {
    String oilName, oilValue, machineId, pricelistDetailId;
    //print(Const.selectMachineOilPrice.length);
    for (int i = 0; i < _lengthdetail; i++) {
      if (_value == Const.selectMachineOilPrice[i].machineName) {
        oilName = Const.selectMachineOilPrice[i].oilName;
        oilValue = Const.selectMachineOilPrice[i].oilValue;
        machineId = Const.selectMachineOilPrice[i].machineId;
        pricelistDetailId = Const.selectMachineOilPrice[i].pricelistDetailId;
        //print('$rm');
      }
    }
    setState(() {
      _oilName = oilName;
      _oilprice.text = oilValue;
      _oilName = oilName;
      _machineId = machineId;
      _pricelistDetailId = pricelistDetailId;
    });
  }

  // Function show dialog
  showdialog(String msg, Function next) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false, // for tap button!
      builder: (BuildContext context) {
        return CustomImageDialog(
          title: msg,
          image: 'asset/logo.png',
          fontsize: size.height * 0.025,
          next: next,
        );
      },
    );
  }

  // Api Post Price Correction
  apiPriceCorrection(price) async {
    Map data = {
      'PricelistDetailId': _pricelistDetailId,
      'price': price,
    };
    print(data);
    var url = Api.urlServer + '/api/setprice/Setprice';
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body)["StatusCode"];
      if (jsonResponse == "Success") {
        showdialog("สำเร็จ", () {
          setState(() {
            _oilprice.clear();
            nameDropDown.clear();
          });
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        });
      } else {
        setState(() {
          showdialog("ไม่สำเร็จ", () {
            setState(() {
              _oilprice.clear();
              nameDropDown.clear();
            });
            Navigator.pop(context);
          });
        });
      }
    } else {
      print('Price Correction failed with status: ${response.statusCode}.');
      showdialog("ไม่สำเร็จ", () {
        setState(() {
          _oilprice.clear();
          nameDropDown.clear();
        });
        Navigator.pop(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    setNameDropDown();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final mediaQueryData = MediaQuery.of(context);
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
            "Price Correction",
            style: GoogleFonts.prompt(
              color: Global.green,
              fontSize: size.height * 0.04,
              fontWeight: FontWeight.w700,
            ),
          ),
          backgroundColor: Global.white,
          elevation: 0.0,
        ),
        body: SafeArea(
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  Container(
                    width: size.width,
                    height: size.height * 0.3,
                    color: Global.yellow,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RotationTransition(
                          turns: AlwaysStoppedAnimation(-10 / 360),
                          child: Image.asset(
                            "asset/PriceCorrection.png",
                            fit: BoxFit.contain,
                            width: size.width * 0.4,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      elevation: 10,
                      child: Container(
                        width: size.width * 0.9,
                        height: size.height * 0.4,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: size.height * 0.04),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 10),
                              child: Row(
                                children: [
                                  Text(
                                    "ตู้น้ำมัน : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    height: size.height * 0.05,
                                    width: size.width * 0.55,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      left: size.width * 0.05,
                                      right: size.width * 0.05,
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(
                                        size.width * 0.05,
                                      ),
                                    ),
                                    child: DropdownButton(
                                      hint: Text('โปรดเลือกตู้น้ำมัน'),
                                      style: GoogleFonts.prompt(
                                        fontSize: size.height * 0.015,
                                      ),
                                      dropdownColor: Colors.grey[50],
                                      underline: Container(height: 0),
                                      elevation: 5,
                                      icon: Icon(
                                        Icons.arrow_drop_down_circle,
                                      ),
                                      value: _value,
                                      isExpanded: true,
                                      onChanged: (value) {
                                        setState(() {
                                          _value = value;
                                        });
                                        setStationCode();
                                      },
                                      items: Const.showMachine
                                          .map(
                                            (e) => DropdownMenuItem(
                                              child: Text(
                                                e.name,
                                                style: GoogleFonts.prompt(
                                                  fontSize: size.height * 0.02,
                                                  color: Colors.black,
                                                ),
                                              ),
                                              value: e.name,
                                            ),
                                          )
                                          .toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "ประเภทน้ำมัน : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  (_oilName == null)
                                      ? Text(
                                          "-",
                                          style: GoogleFonts.prompt(
                                            fontSize: size.height * 0.02,
                                          ),
                                        )
                                      : Text(
                                          '$_oilName',
                                          style: GoogleFonts.prompt(
                                            fontSize: size.height * 0.02,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "ราคาน้ำมัน : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.3,
                                    height: size.height * 0.05,
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.only(
                                      left: size.width * 0.05,
                                      right: size.width * 0.05,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        size.width * 0.02,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _oilprice,
                                      decoration: InputDecoration(
                                        hintText: _oilValue,
                                      ),
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                  Text(
                                    " บาท/ลิตร",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.02,
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.04),
                            Center(
                              child: Container(
                                width: size.width * 0.6,
                                child: RaisedButton(
                                  elevation: 5,
                                  onPressed: () {
                                    apiPriceCorrection(_oilprice.text);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "ยืนยัน",
                                        style: GoogleFonts.prompt(
                                          fontSize: size.width * 0.06,
                                          fontWeight: FontWeight.w500,
                                          color: Global.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  color: Global.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
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
