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

class OrderView extends StatefulWidget {
  @override
  _OrderViewState createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  final _qty = TextEditingController();
  bool _validate = false, _isLoading = false;
  int index = 0, _length = Const.showMachine.length;
  List<String> nameDropDown = List<String>();
  String _value;
  List<String> name;
  String _oilName, _oilValue, _machineId, _oilTypeId, qty, sumConstValue;
  int _lengthdetail = Const.selectMachineOilPrice.length;

  // For loop dropdown menu
  setNameDropDown() {
    nameDropDown.clear();
    for (int i = 0; i < _length; i++) {
      nameDropDown.add(Const.showMachine[i].name);
      //print('print : ${Const.showMachine[i].name}');
    }
  }

  // For loop select from dropdown menu to show oilname, oilValue, machineId
  setStationCode() {
    String oilName, oilValue, machineId, oilTypeId;
    //print(Const.selectMachineOilPrice.length);
    for (int i = 0; i < _lengthdetail; i++) {
      if (_value == Const.selectMachineOilPrice[i].machineName) {
        oilName = Const.selectMachineOilPrice[i].oilName;
        oilValue = Const.selectMachineOilPrice[i].oilValue;
        machineId = Const.selectMachineOilPrice[i].machineId;
        oilTypeId = Const.selectMachineOilPrice[i].oilTypeId;
        //print('$rm');
      }
    }
    setState(() {
      _oilName = oilName;
      _oilValue = oilValue;
      _machineId = machineId;
      _oilTypeId = oilTypeId;
    });
  }

  // Function dialog to input data fail
  void showdialog() {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierDismissible: false, // for tap button!
      builder: (BuildContext context) {
        return CustomImageDialog(
          title: "โปรดระบุจำนวนน้ำมันที่ต้องการ",
          image: 'asset/logo.png',
          fontsize: size.height * 0.025,
          next: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  // Function dialog to show after send data finish and clear textfield qty, namedropdown
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
              _qty.clear();
              nameDropDown.clear();
            });
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => HomeView(),
              ),
            );
          },
        );
      },
    );
  }

  // Function dialog to show after send data fail
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
            Navigator.pop(context);
          },
        );
      },
    );
  }

  // Api Post Order
  apiPostOrder(qty) async {
    var url = Api.urlServer + '/api/OilOrder/InsertOilOrder';
    Map data = {
      'MachineId': _machineId,
      'oiltypeId': _oilTypeId,
      'qty': qty,
      'cost': (double.parse(_oilValue) * double.parse(_qty.text)).toString()
    };
    print('body: $data');
    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      //print(jsonResponse);
      setState(() {
        _isLoading = false;
        showdialogFinish(jsonResponse);
      });
    } else {
      print('PostOrder Request failed with status: ${response.statusCode}.');
      setState(() {
        _isLoading = false;
        showdialogNoFinish("คำสั่งซื้อไม่สำเร็จ กรุณาลองใหม่อีกครั้ง");
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
            "Order Oil",
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
                          turns: AlwaysStoppedAnimation(-20 / 360),
                          child: Image.asset(
                            "asset/OrderOil.png",
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
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Card(
                      elevation: 10,
                      child: Container(
                        width: size.width * 0.9,
                        height: size.height * 0.45,
                        child: Column(
                          children: <Widget>[
                            SizedBox(height: size.height * 0.02),
                            Padding(
                              padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
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
                                      color: Colors.white,
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(
                                        size.width * 0.02,
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
                            SizedBox(height: size.height * 0.001),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
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
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "ราคาน้ำมัน : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  (_oilValue == null)
                                      ? Text(
                                          "-",
                                          style: GoogleFonts.prompt(
                                            fontSize: size.height * 0.02,
                                          ),
                                        )
                                      : Text(
                                          '$_oilValue',
                                          style: GoogleFonts.prompt(
                                            fontSize: size.height * 0.02,
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
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                children: [
                                  Text(
                                    "จำนวนที่ต้องการ : ",
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
                                      border: Border.all(
                                        color: Colors.black,
                                      ),
                                      borderRadius: BorderRadius.circular(
                                        size.width * 0.02,
                                      ),
                                    ),
                                    child: TextFormField(
                                      controller: _qty,
                                      autofocus: false,
                                      obscureText: false,
                                    ),
                                  ),
                                  Text(
                                    " ลิตร",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.02,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: size.height * 0.01),
                            Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                              child: Row(
                                children: [
                                  /*(_oilValue != null && _qty.text != null)
                                      ? sumCost()
                                      : Container(),*/
                                  Text(
                                    "รวมราคาน้ำมันที่ต้องจ่าย : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.02,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  (_oilValue == null || _qty.text.isEmpty)
                                      ? Text(
                                          "-",
                                          style: GoogleFonts.prompt(
                                            fontSize: size.height * 0.02,
                                          ),
                                        )
                                      : Text(
                                          (double.parse(_oilValue) *
                                                  double.parse(_qty.text))
                                              .toString(),
                                          style: GoogleFonts.prompt(
                                            fontSize: size.height * 0.02,
                                          ),
                                        ),
                                  Text(
                                    " บาท",
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
                                    setState(
                                      () {
                                        _qty.text.isEmpty
                                            ? _validate = true
                                            : _validate = false;
                                        _validate
                                            ? _isLoading = false
                                            : _isLoading = true;
                                      },
                                    );
                                    _validate
                                        ? showdialog()
                                        : apiPostOrder(_qty.text);
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
