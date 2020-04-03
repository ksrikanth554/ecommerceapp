import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  final product_details_name;
  final product_details_image;
  final product_details_newprice;
  final product_details_oldprice;

  ProductDetails({
    this.product_details_image,this.product_details_name,this.product_details_newprice,this.product_details_oldprice
  });
  @override
  _ProductDetailsState createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
       elevation: 0.1,
        title: Text('ShopApp'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: (){}),
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,), onPressed: (){}),


        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height*0.4,
            child: GridTile(
              child:Image.asset("${widget.product_details_image}",fit: BoxFit.fill,),
              footer: Container(
                color: Colors.white70,
                child: ListTile(
                  leading:Text("${widget.product_details_name}",style:TextStyle(fontWeight:FontWeight.bold,fontSize:16),),
                  title: Row(
                    children: <Widget>[
                    Expanded(child: Text("₹${widget.product_details_oldprice}",style:TextStyle(fontWeight:FontWeight.w400,color:Colors.black,decoration:TextDecoration.lineThrough),)),
                    Expanded(child: Text("₹${widget.product_details_newprice}",style:TextStyle(color:Colors.red,fontWeight:FontWeight.bold),)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
            //height:MediaQuery.of(context).size.height*0.05,
           // child: Text('data'),
             Container(
               height:MediaQuery.of(context).size.height*0.05,
               child: Row(
                children: <Widget>[
                  Expanded(
                      child: MaterialButton(
                        elevation: 0.1,
                      color:Colors.white,
                      textColor:Colors.grey,
                      child:Row(
                          children: <Widget>[
                            Expanded(child: Text('Size')),
                            Expanded(child: Icon(Icons.arrow_drop_down))
                          ],
                      ),
                      onPressed:(){

                      },
                    ),
                  ),
                  Expanded(
                      child: MaterialButton(
                        elevation: 0.1,
                      color:Colors.white,
                      textColor:Colors.grey,
                      child:Row(
                          children: <Widget>[
                            Expanded(child: Text('Color')),
                            Expanded(child: Icon(Icons.arrow_drop_down))
                          ],
                      ),
                      onPressed:(){

                      },
                    ),
                  ),
                  Expanded(
                      child: MaterialButton(
                        elevation: 0.1,
                      color:Colors.white,
                      textColor:Colors.grey,
                      child:Row(
                          children: <Widget>[
                            Expanded(child: Text('Qty')),
                            Expanded(child: Icon(Icons.arrow_drop_down))
                          ],
                      ),
                      onPressed:(){

                      },
                    ),
                  ),
                ],
            ),
             ),
            Row(
              children: <Widget>[
                Expanded(
                  child: MaterialButton(
                    elevation:0.1,
                    color:Colors.red,
                    textColor:Colors.white,
                    child:Text('Buy Now'),
                    onPressed:(){},
                  ),

                ),
                IconButton(icon: Icon(Icons.add_shopping_cart,color:Colors.red,), 
                onPressed: (){
                  
                }
                ),
                IconButton(icon: Icon(Icons.favorite_border,color:Colors.red,), 
                onPressed: (){

                }
                ),
              ],
            )
          

        ],
      ),
    );
  }
}