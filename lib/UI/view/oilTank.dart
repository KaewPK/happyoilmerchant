import 'package:happyoilmerchant/UI/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happyoilmerchant/UI/view/home.dart';
import 'package:progress_indicators/progress_indicators.dart';

class OilTankView extends StatefulWidget {
  @override
  _OilTankViewState createState() => _OilTankViewState();
}

class _OilTankViewState extends State<OilTankView> {
  List<int> _current = [100, 200, 59, 160];
  int index = 0;
  // Get Zone
  List<String> nameDropDown = List<String>();
  int _length = Const.showMachine.length;
  int _lengthRemain = Const.showMachineRemain.length;
  String _value, _id, _name = '', _remaining, chkimage;
  List<String> name;
  double _doubleremaining;

  // Function condition check show image
  void checkimage(double remaining) {
    String image;
    if (0 <= remaining && remaining < 25) {
      image = "asset/0lit.png";
    } else if (25 <= remaining && remaining < 50) {
      image = "asset/25lit.png";
    } else if (50 <= remaining && remaining < 75) {
      image = "asset/50lit.png";
    } else if (75 <= remaining && remaining < 100) {
      image = "asset/75lit.png";
    } else if (100 <= remaining && remaining < 125) {
      image = "asset/100lit.png";
    } else if (125 <= remaining && remaining < 150) {
      image = "asset/125lit.png";
    } else if (150 <= remaining && remaining < 175) {
      image = "asset/150lit.png";
    } else if (175 <= remaining && remaining < 200) {
      image = "asset/175lit.png";
    } else {
      image = "asset/200lit.png";
    }
    setState(() {
      chkimage = image;
    });
  }

  @override
  void initState() {
    super.initState();
    setNameDropDown();
  }

  // For loop dropdown menu
  setNameDropDown() {
    nameDropDown.clear();
    for (int i = 0; i < _length; i++) {
      nameDropDown.add(Const.showMachine[i].name);
      //print('print : ${Const.showMachine[i].name}');
    }
  }

  // For loop select from dropdown menu to show remaining
  setStationCode() {
    String rm;
    //print(Const.showMachineRemain.length);
    for (int i = 0; i < _lengthRemain; i++) {
      if (_value == Const.showMachineRemain[i].name.toString()) {
        rm = Const.showMachineRemain[i].remaining.toString();
        //print('$rm');
      }
    }
    setState(() {
      _remaining = rm;
      _doubleremaining = double.parse('$rm');
      //print(_doubleremaining);
    });
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
            "Oil In Tank",
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
          child: Container(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(size.height * 0.02),
                  child: Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                        left: size.width * 0.05, right: size.width * 0.05),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(color: Colors.black),
                        borderRadius: BorderRadius.circular(size.width * 0.05)),
                    child: DropdownButton(
                      hint:
                          Text('โปรดเลือกตู้น้ำมัน'), //('${_nameStation[0]}'),
                      style: GoogleFonts.prompt(
                        fontSize: size.height * 0.02,
                        color: Colors.black,
                      ),
                      dropdownColor: Colors.grey[200],
                      underline: Container(height: 0),
                      elevation: 5,
                      icon: Icon(Icons.arrow_drop_down_circle,
                          color: Global.greenBlue),
                      value: _value,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                          /*var name = Const.showMachine
                            .firstWhere((element) => element.name == value);
                        if (name != null) print(name.name);*/
                        });
                        setStationCode();
                        checkimage(_doubleremaining);
                      },
                      items: Const.showMachine
                          .map((e) => DropdownMenuItem(
                              child: Text(e.name,
                                  style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.02)),
                              value: e.name)) //value: e.id
                          .toList(),
                    ),
                  ),
                ),
                (_value == null)
                    ? Expanded(
                        child: Center(
                          child: ScalingText(
                            'Loading...',
                            style: TextStyle(
                              fontSize: size.height * 0.02,
                              color: Global.white,
                            ),
                          ),
                        ),
                      )
                    : Card(
                        elevation: 10,
                        child: Container(
                          width: size.width * 0.9,
                          height: size.height * 0.65,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: size.height * 0.02),
                              Text(
                                (_value == null)
                                    ? Const.showMachine[0].name
                                    : "$_value",
                                style: GoogleFonts.prompt(
                                  fontSize: size.height * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Global.green,
                                ),
                              ),
                              SizedBox(height: size.height * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  (chkimage != null || _value != null)
                                      ? Container(
                                          height: size.height * 0.3,
                                          child: Image.asset(
                                            chkimage,
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      : Container(
                                          height: size.height * 0.3,
                                        ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.03),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "จำนวนเต็ม : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w500,
                                      color: Global.green,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.5,
                                    height: size.height * 0.06,
                                    child: Card(
                                      color: Global.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 8,
                                      child: Container(
                                        child: Center(
                                          child: Text(
                                            "200.00 ลิตร",
                                            style: GoogleFonts.prompt(
                                              fontSize: size.height * 0.03,
                                              color: Global.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ตอนนี้ : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w500,
                                      color: Global.green,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.5,
                                    height: size.height * 0.06,
                                    child: Card(
                                      color: Global.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 8,
                                      child: Container(
                                        child: Center(
                                          child: (_remaining != null ||
                                                  _value != null)
                                              ? Text(
                                                  '$_remaining' + " ลิตร",
                                                  style: GoogleFonts.prompt(
                                                    fontSize:
                                                        size.height * 0.03,
                                                    color: Global.white,
                                                  ),
                                                )
                                              : Text(
                                                  '0' + " ลืตร",
                                                  style: GoogleFonts.prompt(
                                                    fontSize:
                                                        size.height * 0.03,
                                                    color: Global.white,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.02),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
