
import 'dart:core';

import '../db/products.dart';
import 'package:ecommerceapp/model/productmodel.dart';
import 'package:flutter/cupertino.dart';

class AppProvider with ChangeNotifier{
  List<Product>_listProduct=[];
  ProductServices _productServices=ProductServices();
  AppProvider(){
    _getlistProducts();
  }
  List<Product> get listProduct=>_listProduct;
  void _getlistProducts()async{
    _listProduct=await _productServices.getProductsList();
    notifyListeners();
  }
}