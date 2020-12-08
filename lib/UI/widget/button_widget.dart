import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final Function onTap;
  final double borderRadius, height, fontsize, width;
  final Color button1, button2, colorhasBorder, text1, text2, backgroundColor;

  ButtonWidget(
      {this.title,
      this.hasBorder,
      this.onTap,
      this.button1,
      this.button2,
      this.colorhasBorder,
      this.borderRadius,
      this.height,
      this.text1,
      this.text2,
      this.fontsize,
      this.backgroundColor,
      this.width});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: Ink(
        decoration: BoxDecoration(
          color: hasBorder ? button1 : button2,
          borderRadius: BorderRadius.circular(borderRadius),
          border: hasBorder
              ? Border.all(
                  color: colorhasBorder,
                  width: 1.0,
                )
              : Border.fromBorderSide(BorderSide.none),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: Container(
            height: height,
            width: width,
            child: Center(
              child: Text(
                title,
                textScaleFactor: 1,
                style: GoogleFonts.prompt(
                  color: hasBorder ? text1 : text2,
                  fontWeight: FontWeight.w600,
                  fontSize: fontsize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ButtonGDWidget extends StatelessWidget {
  final String title;
  final bool hasBorder;
  final Function onTap;
  final Color color, fontcolor, backgroundColor;
  final double height, width, fontsize;

  ButtonGDWidget(
      {this.title,
      this.hasBorder,
      this.onTap,
      this.color,
      this.height,
      this.width,
      this.fontsize,
      this.fontcolor,
      this.backgroundColor});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: backgroundColor,
      child: GestureDetector(
        onTap: onTap,
        child: ClipOval(
          child: Container(
            color: color,
            height: height,
            width: width,
            child: Center(
              child: Text(
                title,
                textScaleFactor: 1,
                style: GoogleFonts.prompt(
                  color: fontcolor,
                  fontSize: fontsize,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
