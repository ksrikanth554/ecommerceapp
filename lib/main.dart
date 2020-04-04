import 'package:carousel_pro/carousel_pro.dart';
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
      
      home: HomePage(),
    )
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
  @override
  Widget build(BuildContext context) {
     Widget images_carousel=Container(
        height: MediaQuery.of(context).size.width*0.5,
        child: Carousel(
          boxFit: BoxFit.fill,
          images: [
            AssetImage('images/c1.jpg'),
            AssetImage('images/m1.jpeg'),
            AssetImage('images/m2.jpg'),
            AssetImage('images/w1.jpeg'),
            AssetImage('images/w3.jpeg'),
            AssetImage('images/w4.jpeg')
          ],
       // dotBgColor: Colors.grey,
        dotSize: 4.0,
        dotColor: Colors.pink,
        indicatorBgPadding: 12.0,
        autoplay: false,
        ),
     );
     SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.red));
    return Scaffold(
      appBar: AppBar(
        elevation: 0.1,
        title: Text('ShopApp'),
        backgroundColor: Colors.red,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search,color: Colors.white,), onPressed: (){}),
          IconButton(icon: Icon(Icons.shopping_cart,color: Colors.white,), 
          onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx)=>Cart()));
          }
          ),

        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
             accountName:Text('Kotla Srikanth'),
             accountEmail: Text('ksrikanth554@gmail.com'),
             currentAccountPicture: GestureDetector(
               child: CircleAvatar(
                 backgroundColor: Colors.grey,
                 child: Icon(Icons.person,color: Colors.white,),
               ),
             ),
             decoration: BoxDecoration(
               color: Colors.red
             ),
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.home,color: Colors.red,),
                title: Text('Home Page'),
              ),
              onTap:(){},
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.person,color: Colors.red,),
                title: Text('My Account'),
              ),
              onTap:(){},
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.shopping_basket,color: Colors.red,),
                title: Text('My Orders'),
              ),
              onTap:(){},
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.shopping_cart,color: Colors.red,),
                title: Text('Shopping Cart'),
              ),
              onTap:(){
                Navigator.of(context).push(MaterialPageRoute(builder:(ctx)=>Cart()));
              },
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.dashboard,color: Colors.red,),
                title: Text('Categories'),
              ),
              onTap:(){},
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.favorite,color: Colors.red,),
                title: Text('Favourities'),
              ),
              onTap:(){},
            ),
            Divider(height: 2,),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.settings,color: Colors.blue,),
                title: Text('Settings'),
              ),
              onTap:(){},
            ),
            InkWell(
              child: ListTile(
                leading: Icon(Icons.help,color: Colors.green,),
                title: Text('About'),
              ),
              onTap:(){},
            ),
          ],
        ),
      ),
      body: ListView(
        children: <Widget>[
          images_carousel,
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text('Categroies',style: TextStyle(fontWeight: FontWeight.w500),),
          ),
          HorizontalList(),
         Container(
           height: MediaQuery.of(context).size.height*0.04,
           alignment: Alignment.topLeft,
           padding: EdgeInsets.all(4.0),
           child: Text('Recent Products',style: TextStyle(fontWeight:FontWeight.w500,),),
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