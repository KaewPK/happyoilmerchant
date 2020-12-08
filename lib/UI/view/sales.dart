import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happyoilmerchant/UI/view/home.dart';
import '../const.dart';
import 'package:progress_indicators/progress_indicators.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class SalesView extends StatefulWidget {
  @override
  _SalesViewState createState() => _SalesViewState();
}

class _SalesViewState extends State<SalesView> {
  int index = 0;
  // Get Zone
  List<String> nameDropDown = List<String>();
  int _length = Const.showMachine.length;
  int _lengthSale = Const.showDailyMachine.length;
  String _value;
  List<String> name;
  String _sale;
  double _doublesale;

  //Function condition to show  Chart
  List<charts.Series<Pollution, String>> _seriesData;
  _generateData() {
    var green = charts.MaterialPalette.green.makeShades(2);
    var white = charts.MaterialPalette.white;
    var data3 = [
      Pollution('1', 100),
      Pollution('2', 2000),
      Pollution('3', 300),
      Pollution('4', 4000),
      Pollution('5', 5000),
    ];
    _seriesData.add(
      charts.Series(
        domainFn: (Pollution pollution, _) => pollution.place,
        measureFn: (Pollution pollution, _) => pollution.quantity,
        id: 'Sales',
        data: data3,
        colorFn: (Pollution pollution, _) {
          switch (pollution.place) {
            case "5":
              {
                if (_doublesale > 2400) {
                  return green[0];
                }
                return white;
              }
            case "4":
              {
                if (_doublesale > 1800) {
                  return green[1];
                }
                return white;
              }
            case "3":
              {
                if (_doublesale > 1200) {
                  return green[0];
                }
                return white;
              }
            case "2":
              {
                if (_doublesale > 600) {
                  return green[1];
                }
                return white;
              }
            default:
              {
                return green[0];
              }
          }
        },
      ),
    );
  }

  // For loop dropdown menu
  setNameDropDown() {
    nameDropDown.clear();
    for (int i = 0; i < _length; i++) {
      nameDropDown.add(Const.showMachine[i].name);
      //print('print : ${Const.showMachine[i].name}');
    }
  }

  // For loop select from dropdown menu to show sale
  setStationCode() {
    String sale;
    for (int i = 0; i < _lengthSale; i++) {
      if (_value == Const.showDailyMachine[i].machineName.toString()) {
        sale = Const.showDailyMachine[i].value.toString();
        //print('$rm');
      }
    }
    setState(() {
      _sale = sale;
      _doublesale = double.parse(_sale);
    });
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
            "Check Sales",
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
            height: size.height * 0.8,
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
                      hint: Text('โปรดเลือกตู้น้ำมัน'),
                      style: GoogleFonts.prompt(
                        fontSize: size.height * 0.02,
                        color: Colors.black,
                      ),
                      dropdownColor: Colors.grey[200],
                      underline: Container(height: 0),
                      elevation: 5,
                      icon: Icon(
                        Icons.arrow_drop_down_circle,
                        color: Global.greenBlue,
                      ),
                      value: _value,
                      isExpanded: true,
                      onChanged: (value) {
                        setState(() {
                          _value = value;
                        });
                        if (Const.showMachineRemain.isEmpty) {
                          setStationCode();
                        }
                        _seriesData = List<charts.Series<Pollution, String>>();
                        _generateData();
                      },
                      items: Const.showMachine
                          .map(
                            (e) => DropdownMenuItem(
                              child: Text(
                                e.name,
                                style: GoogleFonts.prompt(
                                  fontSize: size.height * 0.02,
                                ),
                              ),
                              value: e.name,
                            ),
                          )
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
                                "$_value",
                                style: GoogleFonts.prompt(
                                  fontSize: size.height * 0.05,
                                  fontWeight: FontWeight.bold,
                                  color: Global.green,
                                ),
                              ),
                              (Const.showDailyMachine.isEmpty)
                                  ? Container(
                                      height: size.height * 0.35,
                                      width: size.width * 0.9,
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Container(
                                          height: size.height * 0.35,
                                          width: size.width * 0.9,
                                          child: Center(
                                            child: charts.BarChart(
                                              _seriesData,
                                              animate: true,
                                              barGroupingType: charts
                                                  .BarGroupingType.grouped,
                                              animationDuration:
                                                  Duration(seconds: 1),
                                              domainAxis:
                                                  charts.OrdinalAxisSpec(
                                                showAxisLine: false,
                                                renderSpec:
                                                    charts.NoneRenderSpec(),
                                              ),
                                              primaryMeasureAxis:
                                                  charts.NumericAxisSpec(
                                                renderSpec:
                                                    charts.NoneRenderSpec(),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ยอดขายสูงสุด : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w500,
                                      color: Global.green,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.42,
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
                                            "5000.00 บาท",
                                            style: GoogleFonts.prompt(
                                              fontSize: size.height * 0.025,
                                              color: Global.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: size.height * 0.01),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "ยอดขายวันนี้ : ",
                                    style: GoogleFonts.prompt(
                                      fontSize: size.height * 0.025,
                                      fontWeight: FontWeight.w500,
                                      color: Global.green,
                                    ),
                                  ),
                                  Container(
                                    width: size.width * 0.42,
                                    height: size.height * 0.06,
                                    child: Card(
                                      color: Global.green,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      elevation: 8,
                                      child: Container(
                                        child: Center(
                                          child: (_doublesale != null)
                                              ? Text(
                                                  '$_doublesale' + " Bath",
                                                  style: GoogleFonts.prompt(
                                                    fontSize:
                                                        size.height * 0.025,
                                                    color: Global.white,
                                                  ),
                                                )
                                              : Text(
                                                  '0' + " บาท",
                                                  style: GoogleFonts.prompt(
                                                    fontSize:
                                                        size.height * 0.025,
                                                    color: Global.white,
                                                  ),
                                                ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
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

class Pollution {
  String place;
  int quantity;

  Pollution(this.place, this.quantity);
}
