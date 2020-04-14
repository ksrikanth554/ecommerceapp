import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';


class UserServices{
  Firestore _firestore=Firestore.instance;
  String ref="users";
  createUser(Map<String,dynamic> value){
    var id=Uuid();
    String userId=id.v1();
    _firestore.collection(ref).document(userId).setData(
      value
    ).catchError((e)=>print(e.toString()));
  }
}