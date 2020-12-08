import 'package:google_fonts/google_fonts.dart';
import 'package:happyoilmerchant/UI/shared/globals.dart';
import 'package:flutter/material.dart';

class RowcheckboxWidget extends StatelessWidget {
  final String title;
  final bool boolValue;
  final Function onChanged;

  RowcheckboxWidget({this.title, this.boolValue, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Checkbox(
          activeColor: Global.green,
          value: boolValue,
          onChanged: onChanged,
        ),
        Text(
          title,
          style: GoogleFonts.prompt(
              color: Global.green, fontSize: size.height * 0.018),
        ),
      ],
    );
  }
}
