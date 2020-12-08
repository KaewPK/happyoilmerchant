import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomImageDialog extends StatelessWidget {
  final String image, title;
  final double fontsize;
  final Function next;
  CustomImageDialog({this.image, this.title, this.fontsize, this.next});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.height * 0.05)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialog(context),
    );
  }

  dialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width * 0.8,
          padding: EdgeInsets.only(
            top: size.height * 0.016,
            bottom: size.height * 0.016,
            left: size.width * 0.02,
            right: size.width * 0.02,
          ),
          margin: EdgeInsets.only(top: size.height * 0.016),
          decoration: BoxDecoration(
              color: Global.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(size.height * 0.017),
              boxShadow: [
                BoxShadow(
                    color: Global.green,
                    blurRadius: size.width * 0.01,
                    offset: Offset(0.0, size.height * 0.01))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.contain)),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                title,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: GoogleFonts.prompt(
                  fontWeight: FontWeight.w500,
                  color: Global.green,
                  fontSize: fontsize,
                ),
              ),
              SizedBox(height: size.height * 0.04),
              Container(
                width: size.width * 0.5,
                height: size.height * 0.07,
                child: RaisedButton(
                  elevation: 5,
                  onPressed: next,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "ตกลง",
                        textScaleFactor: 1,
                        style: GoogleFonts.prompt(
                          fontSize: size.width * 0.06,
                          fontWeight: FontWeight.w400,
                          color: Global.white,
                        ),
                      ),
                    ],
                  ),
                  color: Global.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        )
      ],
    );
  }
}

class CustomImageTwoButtonDialog extends StatelessWidget {
  final String image, title;
  final double fontsize;
  final Function next1, next2;
  CustomImageTwoButtonDialog(
      {this.image, this.title, this.fontsize, this.next1, this.next2});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(size.height * 0.05)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: dialog(context),
    );
  }

  dialog(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width * 0.8,
          padding: EdgeInsets.only(
            top: size.height * 0.016,
            bottom: size.height * 0.016,
            left: size.width * 0.02,
            right: size.width * 0.02,
          ),
          margin: EdgeInsets.only(top: size.height * 0.016),
          decoration: BoxDecoration(
              color: Global.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.circular(size.height * 0.017),
              boxShadow: [
                BoxShadow(
                    color: Global.green,
                    blurRadius: size.width * 0.01,
                    offset: Offset(0.0, size.height * 0.01))
              ]),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: size.height * 0.02),
              Container(
                height: size.height * 0.15,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(image), fit: BoxFit.contain)),
              ),
              Text(
                title,
                textScaleFactor: 1,
                textAlign: TextAlign.center,
                style: GoogleFonts.prompt(
                  fontWeight: FontWeight.w500,
                  color: Global.green,
                  fontSize: fontsize,
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: size.width * 0.3,
                    height: size.height * 0.07,
                    child: RaisedButton(
                      elevation: 5,
                      onPressed: next1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ตกลง",
                            textScaleFactor: 1,
                            style: GoogleFonts.prompt(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.w400,
                              color: Global.white,
                            ),
                          ),
                        ],
                      ),
                      color: Global.green,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                  Container(
                    width: size.width * 0.3,
                    height: size.height * 0.07,
                    child: RaisedButton(
                      elevation: 5,
                      onPressed: next2,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ยกเลิก",
                            textScaleFactor: 1,
                            style: GoogleFonts.prompt(
                              fontSize: size.width * 0.06,
                              fontWeight: FontWeight.w400,
                              color: Global.white,
                            ),
                          ),
                        ],
                      ),
                      color: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        )
      ],
    );
  }
}
