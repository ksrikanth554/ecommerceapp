import 'package:flutter/material.dart';

import '../product_details.dart';

class Products extends StatelessWidget {
  var product_list=[
    {
      "product_name":"Blazer",
      "product_image":"images/products/blazer1.jpeg",
      "product_price":850.00,
      "product_oldprice":1200.00
    },
    {
      "product_name":"Red Dress",
      "product_image":"images/products/dress1.jpeg",
      "product_price":600.00,
      "product_oldprice":1100.00
    },
    {
      "product_name":"Hills",
      "product_image":"images/products/hills1.jpeg",
      "product_price":400.00,
      "product_oldprice":850.00
    },
    {
      "product_name":"Pants",
      "product_image":"images/products/pants1.jpg",
      "product_price":1000.00,
      "product_oldprice":1250.00
    }
  ];
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount:product_list.length ,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
      itemBuilder: (ctx,index) {
        return SingleProduct(
          productName:product_list[index]["product_name"] ,
          productImage: product_list[index]["product_image"],
          productPrice: product_list[index]["product_price"],
          productOldPrice: product_list[index]["product_oldprice"],
        );
      },
      
      
    );
  }
}
class SingleProduct extends StatelessWidget {
  final  productName;
  final  productImage;
  final  productPrice;
  final  productOldPrice;

  SingleProduct({
    this.productImage,this.productName,this.productOldPrice,this.productPrice
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Card(
        child: Hero(
          tag: productName, 
          child: Material(
            child:InkWell(
                child: GridTile(
                child: Image.asset(productImage,fit: BoxFit.fill,),
                footer: Container(
                  color: Colors.white70,
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.01),
                      child: Text(productName,style: TextStyle(fontWeight: FontWeight.bold),)),
                    title: Text('₹$productPrice',style: TextStyle(fontWeight: FontWeight.bold,color:Colors.red),),
                    subtitle:Text('₹$productOldPrice',style:TextStyle(fontWeight:FontWeight.bold,color:Colors.black54,
                                                                    decoration: TextDecoration.lineThrough),),
                  ),
                ),
                ),
              onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>ProductDetails(
                  product_details_image: productImage,
                  product_details_name: productName,
                  product_details_newprice: productPrice,
                  product_details_oldprice: productOldPrice,
                )));
              },
            ) ,
          )
          ),
      ),
    );
  }
}