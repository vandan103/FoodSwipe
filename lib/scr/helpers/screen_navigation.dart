import 'package:flutter/material.dart';

void changeScreen(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void changeScreenReplacement(BuildContext context, Widget widget) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => widget));
}

void closePreviousScreen(BuildContext context,Widget widget)
{
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>widget)   , (route) => false );
}