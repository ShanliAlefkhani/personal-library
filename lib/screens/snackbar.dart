import 'package:flutter/material.dart';

void showAlert(BuildContext context,String errorMessage) {
  Scaffold.of(context).showSnackBar(SnackBar(
    content:
    Text(errorMessage,textAlign: TextAlign.right,style: TextStyle(fontSize: 15, fontFamily: 'IRAN_SANS'),)
    ,shape:RoundedRectangleBorder(borderRadius: BorderRadius.only(topRight: Radius.circular(5),topLeft: Radius.circular(5))) ,
  ));
}