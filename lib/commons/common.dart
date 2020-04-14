import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void changeScreen(BuildContext context,Widget widget){
  Navigator.of(context).push(MaterialPageRoute(builder:(context)=>widget));
}
void changeScreenReplacement(BuildContext context,Widget widget){
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context)=>widget));
}