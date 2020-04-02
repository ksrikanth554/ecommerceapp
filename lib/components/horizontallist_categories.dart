import 'package:flutter/material.dart';

class HorizontalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height*0.15,
      child:ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Category(
          image_location: 'images/cats/tshirt.png',
          image_caption: 't-shirt'
          ),
          Category(
          image_location: 'images/cats/dress.png',
          image_caption: 'dress'
          ),
          Category(
          image_location: 'images/cats/formal.png',
          image_caption: 'formal'
          ),
          Category(
          image_location: 'images/cats/informal.png',
          image_caption: 'informal'
          ),
          Category(
          image_location: 'images/cats/jeans.png',
          image_caption: 'jeans'
          ),
          Category(
          image_location: 'images/cats/shoe.png',
          image_caption: 'shoe'
          ),
        ],
        

      ),
      
    );
  }
}
class Category extends StatelessWidget{
  final String image_location;
  final String image_caption;
  Category({
    this.image_caption,
    this.image_location
  });
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.3,
      child: InkWell(
              child: ListTile(
          
          title: Image.asset(image_location,height: MediaQuery.of(context).size.height*0.1,),
          subtitle: Container(
            child: Text(image_caption,textAlign: TextAlign.center,)),
        ),
        onTap: (){},
      ),
      
    );
  }
}