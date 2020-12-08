import 'dart:math';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:happyoilmerchant/UI/view/home.dart';

class MessageView extends StatefulWidget {
  @override
  _MessageViewState createState() => _MessageViewState();
}

class _MessageViewState extends State<MessageView> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List<String> _machineStatus;
  Random r;
  List<String> _date;

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 3));
    addRandomCompany();
    return null;
  }

  addCompanies() {
    _date.add("1 ก.ย. 2563");
    _date.add("2 ก.ย. 2563");
    _date.add("3 ก.ย. 2563");
    _date.add("4 ก.ย. 2563");
    _machineStatus.add("กำลังเปิดใช้งาน 1");
    _machineStatus.add("กำลังเปิดใช้งาน 2");
    _machineStatus.add("กำลังเปิดใช้งาน 3");
    _machineStatus.add("กำลังเปิดใช้งาน 4");
  }

  // undoDelete(index, company) {
  //   setState(() {
  //     _machineStatus.insert(index, company);
  //   });
  // }

  addRandomCompany() {
    int nextCount = r.nextInt(100);
    setState(() {
      _machineStatus.add("Company $nextCount");
    });
  }

  // removeCompany(index) {
  //   setState(() {
  //     _date.removeAt(index);
  //     _machineStatus.removeAt(index);
  //   });
  // }

  // showSnackBar(context, company, index) {
  //   Scaffold.of(context).showSnackBar(SnackBar(
  //     content: Text('$company deleted'),
  //     action: SnackBarAction(
  //       label: "UNDO",
  //       onPressed: () {
  //         undoDelete(index, company);
  //       },
  //     ),
  //   ));
  // }

  Widget refreshBg() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 35, 0, 5),
      child: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.fromLTRB(0, 0, 20, 0),
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
    r = Random();
    _machineStatus = List();
    _date = List();
    addCompanies();
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
          backgroundColor: Global.green,
          leading: IconButton(
            iconSize: size.height * 0.04,
            icon: Icon(
              Icons.arrow_back_ios,
              color: Global.white,
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
            "Messsage",
            style: GoogleFonts.prompt(
              color: Global.white,
              fontSize: size.height * 0.045,
              fontWeight: FontWeight.w700,
            ),
          ),
          elevation: 0.0,
        ),
        body: RefreshIndicator(
          key: refreshKey,
          onRefresh: () async {
            await refreshList();
          },
          child: Container(
            padding: EdgeInsets.all(size.height * 0.02),
            child: ListView.builder(
              itemCount: _machineStatus.length,
              itemBuilder: (context, index) {
                return Dismissible(
                  key: Key(_machineStatus[index]),
                  onDismissed: (direction) {
                    // var company = _machineStatus[index];
                    // showSnackBar(context, company, index);
                    // removeCompany(index);
                  },
                  background: refreshBg(),
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.02),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          '${_date[index]}',
                          maxLines: 2,
                          style: GoogleFonts.prompt(
                            fontSize: size.height * 0.015,
                            fontWeight: FontWeight.w500,
                            color: Global.white,
                          ),
                        ),
                      ),
                      Container(
                        height: size.height * 0.15,
                        child: Card(
                          elevation: 5,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                            child: Row(
                              children: <Widget>[
                                Padding(
                                  padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                                  child: Image.asset(
                                    'asset/CheckMachine.png',
                                    width: size.width * 0.25,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(20, 0, 10, 0),
                                  width: size.width * 0.55,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      SizedBox(height: size.height * 0.01),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          '${_machineStatus[index]}',
                                          maxLines: 2,
                                          style: GoogleFonts.prompt(
                                            fontSize: size.height * 0.018,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                      Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(
                                          'ตำแหน่ง : ${_machineStatus[index]}',
                                          maxLines: 2,
                                          style: GoogleFonts.prompt(
                                            fontSize: size.height * 0.015,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: size.height * 0.01),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
