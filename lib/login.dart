import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

import 'homepage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GoogleSignIn googleSignIn=GoogleSignIn();
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  final _formkey=GlobalKey<FormState>();

  SharedPreferences preferences;
  bool isLoading=false;
  bool isLoggedin=false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // isSignedIn();
  }
  void isSignedIn()async{
        setState(() {
          isLoading=true;
        });
      preferences=await SharedPreferences.getInstance();
      isLoggedin=await googleSignIn.isSignedIn();
      if (isLoggedin) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomePage()));
      }
      setState(() {
        isLoading=false;
      });

  }

  Future handleSignIn()async{
    preferences=await SharedPreferences.getInstance();
    setState(() {
      isLoading=true;
    });
    GoogleSignInAccount googleuser=await googleSignIn.signIn();
    GoogleSignInAuthentication googleSignInAuthentication=await googleuser.authentication;

    final AuthCredential credential=GoogleAuthProvider.getCredential(
                                                                      idToken: googleSignInAuthentication.idToken,
                                                                       accessToken: googleSignInAuthentication.accessToken
                                                                    );

    final AuthResult authResult=await firebaseAuth.signInWithCredential(credential);
    FirebaseUser firebaseUser=authResult.user;
    if (firebaseUser!=null) {
      final QuerySnapshot result=await Firestore.instance.collection("users").where("id",isEqualTo:firebaseUser.uid).getDocuments();
      final List<DocumentSnapshot> documnets=result.documents;
      if (documnets.length==0) {
        Firestore.instance.collection("users").document(firebaseUser.uid)
                                              .setData(
                                                    {
                                                      "id":firebaseUser.uid,
                                                      "username":firebaseUser.displayName,
                                                      "profilePicture":firebaseUser.photoUrl
                                                    }
                                                 );
        await preferences.setString("id", firebaseUser.uid);
        await preferences.setString("username", firebaseUser.displayName);
        await preferences.setString("profilePicture", firebaseUser.photoUrl);
      }
      else{
        await preferences.setString("id", documnets[0]["id"]);
        await preferences.setString("username", documnets[0]["username"]);
        await preferences.setString("profilePicture", documnets[0]["profilePicture"]);

      }
       isLoggedin=await googleSignIn.isSignedIn();
      if (isLoggedin) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomePage()));
      }
      Toast.show("Successfully LoggedIn", context,duration:Toast.LENGTH_LONG);
      setState(() {
        isLoading=false;
      });
    }
    else{

    }
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // resizeToAvoidBottomInset: false,
      // appBar: AppBar(
      //   title: Text('Loggin'),

      // ),
      body: Stack(
        
        children: <Widget>[
          // Center(
          //   child:FlatButton(onPressed:(){
          //     handleSignIn();
          //   }, child: Text('Sign In/Sign up with google')),
          // ),


          Image.asset("images/login_image.jpg",
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
          ),
          SingleChildScrollView(
              child: Container(
              padding:EdgeInsets.only(
               top:MediaQuery.of(context).size.height*0.3
                ),
              child: Form(
                  key: _formkey,
                  child: Container(
                    
                         child: Column(
                      children: <Widget>[
                        Padding(
                          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                          child: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.8),
                          child: Container(
                            decoration: BoxDecoration(
                              
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Email",
                                labelText: "Email",
                                border: InputBorder.none,
                                
                                icon: Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Icon(Icons.email,color: Colors.red,),
                                )
                              ),
                              controller:emailController ,
                            ),
                          ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                          child: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.8),
                          child: Container(
                            decoration: BoxDecoration(
                              
                            ),
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: "Enter Password",
                                labelText: "Password",
                                border: InputBorder.none,
                                icon: Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Icon(Icons.lock_outline,color: Colors.red,),
                                )
                              ),
                              controller:passwordController ,
                            ),
                          ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                          child: Material(
                            
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.blue.withOpacity(0.8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.07,
                            decoration: BoxDecoration(
                              
                            ),
                            child: MaterialButton(
                              //color: Colors.blue,
                              child: Text('Login',style: TextStyle(color:Colors.white),),
                              onPressed:(){}
                              ),
                          ),
                          ),
                        ),
                        Divider(color: Colors.red,),
                        Text('Other Login Options',style:TextStyle(color:Colors.white,fontSize: 17.0),),
                        Padding(
                          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                          child: Material(
                            
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.red.withOpacity(0.8),
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height*0.07,
                            decoration: BoxDecoration(
                              
                            ),
                            child: MaterialButton(
                              //color: Colors.blue,
                              child: Text('Google',style: TextStyle(color:Colors.white),),
                              onPressed:(){
                                handleSignIn();
                              }
                              ),
                          ),
                          ),
                        ),


                      ],
                ),
                    
                  ),
              ),

            ),
          ),


          Visibility(
            visible:isLoading??true,
            child: Center(
              child: Container(
                   child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
            ),
          )
        ],
      ),
      
    );
  }

  
}