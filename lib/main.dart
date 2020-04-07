import 'package:carousel_pro/carousel_pro.dart';
import 'package:ecommerceapp/login.dart';
import './cart.dart';
import './components/horizontallist_categories.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'components/recent_products.dart';



void main(){
  
  // FlutterStatusbarcolor.setStatusBarColor(Colors.green);
  runApp(
    MaterialApp(
      
      debugShowCheckedModeBanner: false,
      
      home: Login(),
    )
  );
}

