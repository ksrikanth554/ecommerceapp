import './components/cart_products.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  @override
  _CartState createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text('Cart'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: (){}),
         // IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,), onPressed: (){}),

        ],
      ),
      body: CartProducts(),
      bottomNavigationBar: Container(
        height:MediaQuery.of(context).size.height*0.08,
        color:Colors.white,
        child: Row(
          children: <Widget>[
            Expanded(
              child: ListTile(
                title:Text('Total'),
                subtitle:Text('₹250'), 
              ),
            ),
              Expanded(
                child:MaterialButton(
                  color:Colors.red,
                  child:Text("Check Out",style:TextStyle(color:Colors.white),),
                  onPressed: (){}
                  ) ,
                )
          ],
        ),
      ),
      
    );
  }
}