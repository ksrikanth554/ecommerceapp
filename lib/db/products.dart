import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/model/productmodel.dart';

class ProductServices{
  Firestore _firestore=Firestore.instance;
  String ref="products";

  Future<List<Product>> getProductsList()=>
    _firestore.collection(ref).getDocuments().then((snap){
    List<Product> listProducts=[];
      snap.documents.map((snapshot)=>listProducts.add(Product.fromSnapshot(snapshot)));
    return listProducts;
    });
  
}