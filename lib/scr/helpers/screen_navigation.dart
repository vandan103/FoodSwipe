import 'package:flutter/material.dart';

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (context) => widget));
}

void closePreviousScreen(BuildContext context, Widget widget) {
  Navigator.pushAndRemoveUntil(
      context, MaterialPageRoute( builder: (context) => widget  ), (Route<dynamic> route) => false  );
}


void closePrevious(BuildContext context ,Widget widget){
  Navigator.popUntil(context, (route) => false);
}
