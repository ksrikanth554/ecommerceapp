import 'package:flutter/material.dart';
class CartProducts extends StatefulWidget {
  @override
  _CartProductsState createState() => _CartProductsState();
}

class _CartProductsState extends State<CartProducts> {
 var cart_product_list=[
   {
      "product_name":"Blazer",
      "product_image":"images/products/blazer1.jpeg",
      "product_price":850.00,
      "size":"M",
      "color":"Black",
      "quantity":1
    },
    {
      "product_name":"Red Dress",
      "product_image":"images/products/dress1.jpeg",
      "product_price":600.00,
      "size":"L",
      "color":"Red",
      "quantity":1
    },
    {
      "product_name":"Hills",
      "product_image":"images/products/hills1.jpeg",
      "product_price":400.00,
      "size":"6",
      "color":"Grey",
      "quantity":1
    
    },
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: cart_product_list.length,
      itemBuilder: (ctx,index){
        return SingleCart(
          cart_product_name:cart_product_list[index]["product_name"],
          cart_product_image: cart_product_list[index]["product_image"],
          cart_product_price: cart_product_list[index]["product_price"],
          cart_product_size: cart_product_list[index]["size"],
          cart_product_color: cart_product_list[index]["color"],
          cart_product_quantity:cart_product_list[index]["quantity"],
        );
      }
      
    );
  }
}

class SingleCart extends StatelessWidget {
  final cart_product_name;
  final cart_product_image;
  final cart_product_price;
  final cart_product_size;
  final cart_product_color;
  final cart_product_quantity;
  SingleCart({
    this.cart_product_color,this.cart_product_image,this.cart_product_name,
    this.cart_product_price,this.cart_product_quantity,this.cart_product_size
  });
  @override
  Widget build(BuildContext context) {
    return Card(    
        child:Row(
          children: <Widget>[
          Image.asset(cart_product_image,
          width: MediaQuery.of(context).size.width*0.1,
          height:MediaQuery.of(context).size.height*0.1,),
          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
          Container(
          // padding:EdgeInsets.only(top:MediaQuery.of(context).size.height*0.01),
            child: Column(
              
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Text('$cart_product_name',style:TextStyle(fontWeight:FontWeight.w600),)),
               SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Row(
                    children: <Widget>[
                      Text('Size:'),
                      SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                      Text('$cart_product_size',style:TextStyle(color:Colors.red),),
                      SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                      Text('Color'),
                      SizedBox(width: MediaQuery.of(context).size.width*0.04,),
                      Text('$cart_product_color',style:TextStyle(color:Colors.red)),

                    ],
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height*0.01,),
                Container(
                  width: MediaQuery.of(context).size.width*0.5,
                  child: Row(
                    children: <Widget>[
                      Text("₹$cart_product_price",style:TextStyle(color:Colors.red,fontWeight:FontWeight.w700),)
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: MediaQuery.of(context).size.width*0.1,),
            Column(
              children: <Widget>[
                
                  
               Icon(Icons.arrow_drop_up), 
                   
                   Text("$cart_product_quantity"),
                   
                     Icon(Icons.arrow_drop_down), 
                  
                    
                
              ],
            ),
          ],
          
            //height: 150,
          
        ),
      
    );
  }
}