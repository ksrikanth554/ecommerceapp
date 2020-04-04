import 'package:flutter/material.dart';

import 'components/recent_products.dart';

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
                        showDialog(context: context,
                        builder:(ctx){
                          return AlertDialog(
                            title:Text('Size'),
                            content:Text('Select Your Size'),
                            actions: <Widget>[
                              MaterialButton(
                                child:Text('Close',style:TextStyle(color:Colors.blue),),
                                onPressed:()=>Navigator.of(context).pop(),
                              )
                            ],
                          );
                        }
                        );
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
                        showDialog(context: context,
                        builder:(ctx){
                          return AlertDialog(
                            title:Text('Color'),
                            content:Text('Choose Your Color'),
                            actions: <Widget>[
                              MaterialButton(
                                child:Text('Close',style:TextStyle(color:Colors.blue),),
                                onPressed:()=>Navigator.of(context).pop(),
                              )
                            ],
                          );
                        }
                        );
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
                        showDialog(context: context,
                        builder:(ctx){
                          return AlertDialog(
                            title:Text('Quantity'),
                            content:Text('Select Your Quantity'),
                            actions: <Widget>[
                              MaterialButton(
                                child:Text('Close',style:TextStyle(color:Colors.blue),),
                                onPressed:()=>Navigator.of(context).pop(),
                              )
                            ],
                          );
                        }
                        );
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
            ),
            ListTile(
              title:Text('Product Description',style:TextStyle(fontWeight:FontWeight.w500),),
              subtitle: Text('Lorem Ipsum has been the industrys standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum'),
            ),
            Divider(),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03),
                  child: Text('Product Name',style:TextStyle(color:Colors.grey),)),
                Container(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03),
                  child: Text('${widget.product_details_name}',style:TextStyle(fontWeight:FontWeight.w500),))
              ],
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.01,),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03),
                  child: Text('Product Brand',style:TextStyle(color:Colors.grey),)),
                Container(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03),
                  child: Text('BrandX',style:TextStyle(fontWeight:FontWeight.w500),))
              ],
            ),
            SizedBox(height:MediaQuery.of(context).size.height*0.01,),
            Row(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03),
                  child: Text('Product Condition',style:TextStyle(color:Colors.grey),)),
                Container(
                  padding: EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03),
                  child: Text('New',style:TextStyle(fontWeight:FontWeight.w500),))
              ],
            ),
            Divider(),
          Container(
            padding:EdgeInsets.only(left:MediaQuery.of(context).size.width*0.03),
            child:Text('Similar Products',style:TextStyle(fontWeight:FontWeight.w700),),

          ),
          Container(
            height: MediaQuery.of(context).size.width*0.9,
            child: Products()
            )


        ],
      ),
    );
  }
}