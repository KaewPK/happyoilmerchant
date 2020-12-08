import 'package:happyoilmerchant/Model/mol_Machine.dart';
import 'package:happyoilmerchant/UI/const.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:happyoilmerchant/UI/shared/api.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:happyoilmerchant/UI/view/home.dart';
import 'package:happyoilmerchant/UI/widget/button_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class MachineView extends StatefulWidget {
  @override
  _MachineViewState createState() => _MachineViewState();
}

class _MachineViewState extends State<MachineView> {
  GlobalKey<RefreshIndicatorState> refreshKey;
  List<LocationMachine> locationMachineDetail = Const.locationMachine;

  Future<Null> refreshList() async {
    await Future.delayed(Duration(seconds: 3));
    print(Const.locationMachine.length);
    Api.apiLocationMachine();
    return null;
  }

  @override
  void initState() {
    super.initState();
    refreshKey = GlobalKey<RefreshIndicatorState>();
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
          backgroundColor: Global.white,
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
            "Check Machine",
            style: GoogleFonts.prompt(
              color: Global.green,
              fontSize: size.height * 0.04,
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
          child: (locationMachineDetail.length > 0)
              ? Container(
                  padding: EdgeInsets.all(size.height * 0.015),
                  child: ListView.builder(
                    itemCount: locationMachineDetail.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Card(
                          elevation: 5,
                          child: Container(
                            height: size.height * 0.15,
                            child: Padding(
                              padding: const EdgeInsets.all(5),
                              child: Row(
                                children: <Widget>[
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                                    child: Image.asset(
                                      'asset/CheckMachine.png',
                                      width: size.width * 0.25,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                                    width: size.width * 0.45,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        SizedBox(height: size.height * 0.01),
                                        Container(
                                          width: size.width * 0.3,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: Colors.teal,
                                            ),
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                size.height * 0.05,
                                              ),
                                            ),
                                          ),
                                          child: Text(
                                            'เครื่องที่ ${locationMachineDetail[index].id}',
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.prompt(
                                              fontSize: size.height * 0.015,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Padding(
                                          padding:
                                              EdgeInsets.fromLTRB(5, 0, 1, 0),
                                          child: Text(
                                            'ตำแหน่ง : ${locationMachineDetail[index].locationName}',
                                            maxLines: 2,
                                            style: GoogleFonts.prompt(
                                              fontSize: size.height * 0.015,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                            padding:
                                                EdgeInsets.fromLTRB(5, 0, 1, 0),
                                            child: Row(
                                              children: [
                                                Text(
                                                  'สถานะ : ',
                                                  maxLines: 2,
                                                  style: GoogleFonts.prompt(
                                                    fontSize:
                                                        size.height * 0.015,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                                (locationMachineDetail[index]
                                                                .status ==
                                                            "Draft" ||
                                                        locationMachineDetail[
                                                                    index]
                                                                .status ==
                                                            "Disable")
                                                    ? Text(
                                                        '${locationMachineDetail[index].statusThai}',
                                                        maxLines: 2,
                                                        style:
                                                            GoogleFonts.prompt(
                                                          fontSize:
                                                              size.height *
                                                                  0.015,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Colors.red,
                                                        ),
                                                      )
                                                    : Text(
                                                        '${locationMachineDetail[index].statusThai}',
                                                        maxLines: 2,
                                                        style:
                                                            GoogleFonts.prompt(
                                                          fontSize:
                                                              size.height *
                                                                  0.015,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                        ),
                                                      ),
                                              ],
                                            )),
                                      ],
                                    ),
                                  ),
                                  (locationMachineDetail[index].status ==
                                              "Draft" ||
                                          locationMachineDetail[index].status ==
                                              "Disable")
                                      ? ButtonWidget(
                                          title:
                                              '${locationMachineDetail[index].status}',
                                          hasBorder: false,
                                          onTap: () {},
                                          button1: Global.white,
                                          button2: Colors.red,
                                          colorhasBorder: Colors.red,
                                          borderRadius: size.height * 0.01,
                                          height: size.height * 0.1,
                                          width: size.width * 0.15,
                                          text1: Global.greenDark,
                                          text2: Global.white,
                                          fontsize: size.height * 0.018,
                                        )
                                      : ButtonWidget(
                                          title:
                                              '${locationMachineDetail[index].status}',
                                          hasBorder: false,
                                          onTap: () {},
                                          button1: Global.white,
                                          button2: Global.green,
                                          colorhasBorder: Global.green,
                                          borderRadius: size.height * 0.01,
                                          height: size.height * 0.1,
                                          width: size.width * 0.15,
                                          text1: Global.greenDark,
                                          text2: Global.white,
                                          fontsize: size.height * 0.018,
                                        ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              : Center(
                  child: Container(
                    child: Text(
                      "ไม่พบข้อมูล",
                      style: GoogleFonts.prompt(
                        fontSize: size.height * 0.02,
                        fontWeight: FontWeight.w500,
                        color: Global.white,
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
