import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerceapp/commons/common.dart';
import 'package:ecommerceapp/db/auth.dart';
import 'package:ecommerceapp/db/users.dart';
import 'package:ecommerceapp/signup.dart';
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
  Auth _auth=Auth();
  UserServices _userServices=UserServices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isSignedIn();
  }
  void isSignedIn()async{
        setState(() {
          isLoading=true;
        });
      preferences=await SharedPreferences.getInstance();
     // isLoggedin=await googleSignIn.isSignedIn();
      if (isLoggedin) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomePage()));
      }
      setState(() {
        isLoading=false;
      });

  }
 Future handleNormalSignIn()async{

    if (_formkey.currentState.validate()) {
        try{
                  setState(() {
                    isLoading=true;
                  });
                  final QuerySnapshot result=await Firestore.instance.collection("users").
                                              where("email",isEqualTo:emailController.text).getDocuments();
                  final List<DocumentSnapshot> documents=result.documents;
                  if (documents!=null && documents[0]["password"]==passwordController.text) {
                      
                    changeScreenReplacement(context, HomePage(
                      email: documents[0]["email"],
                      name: documents[0]["username"],
                    ));
                  }
                  else{
                    Toast.show('Invalid Password', context,duration: Toast.LENGTH_LONG);
                    setState(() {
                      isLoading=false;
                    });
                  }
           }
          catch(ex)
          {
            Toast.show(ex.toString(), context,duration: Toast.LENGTH_LONG);
            setState(() {
              isLoading=false;
            });
          }
      
    }
          

  }

  Future handleGoogleSignIn()async{
    preferences=await SharedPreferences.getInstance();
    
    GoogleSignInAccount googleuser=await googleSignIn.signIn();
    if (googleuser!=null) {
      
     setState(() {
          isLoading=true;
        });
    }
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
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx)=>HomePage(
          name: firebaseUser.displayName,
          email: firebaseUser.email,
          photo: firebaseUser.photoUrl,
        )));
      }
      
      Toast.show("Successfully LoggedIn", context,duration:Toast.LENGTH_LONG);
      setState(() {
        isLoading=false;
      });
    }
    else{
       setState(() {
        isLoading=false;
      });
    }
    setState(() {
        isLoading=false;
      });
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(     
        children: <Widget>[         
         Image.asset("images/login_image.jpg",
          fit: BoxFit.fill,
          width: double.infinity,
          height: double.infinity,
          ),
          SingleChildScrollView(
              child: Container(
              padding:EdgeInsets.only(
               top:MediaQuery.of(context).size.height*0.15
                ),
              child: Form(
                  key: _formkey,
                  child: Container(
                         child: Column(
                      children: <Widget>[
                        ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                         child: Image.asset('images/shopapp_logo.jpg', 
                          scale: 1,),
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
                                hintText: "Enter Email",
                                labelText: "Email",
                                border: InputBorder.none,
                                
                                icon: Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Icon(Icons.email,color: Colors.red,),
                                )
                              ),
                              controller:emailController ,
                              validator: (val){
                                if (val.isNotEmpty) {
                                  Pattern pattern=r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
                                  RegExp regExp=RegExp(pattern);
                                  if (!regExp.hasMatch(val)) {
                                    return"Please Enter Valid Email";                                 
                                  }
                                  else{
                                    return null;
                                  }
                                }
                                else{
                                  return "Please Enter Email";
                                }
                                
                              },
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
                              obscureText: true,
                              controller:passwordController ,
                              validator: (val){
                                if (val.isNotEmpty) {
                                  if (val.length<6) {
                                    return "Please Enter Valid Password";
                                  }
                                  else{
                                    return null;
                                  }
                                }
                                else{
                                  return "Please Enter Password";
                                }
                              },
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
                              onPressed:handleNormalSignIn
                              ),
                          ),
                          ),
                        ),
                        FlatButton(
                          child: Text('Forgot Password',style:TextStyle(color:Colors.white),),
                          onPressed: (){

                          },
                          ),
                        Padding(
                          padding: EdgeInsets.only(left: MediaQuery.of(context).size.width*0.02),
                          child: Row(children: <Widget>[
                              Text('Dont have account?click here to',style: TextStyle(color:Colors.red[200],decoration:TextDecoration.underline),),
                              FlatButton( 
                                child: Text('Sign Up',style:TextStyle(color:Colors.white),),
                                onPressed: (){
                                  changeScreenReplacement(context, SignUp());
                                },
                                )
                          ],),
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
                              onPressed:()async{
                                handleGoogleSignIn();
                                // FirebaseUser user=await _auth.googleSignIn();
                                // if (user==null) {
                                //       _userServices.createUser({
                                //         "name":user.displayName,
                                //         "image":user.photoUrl,
                                //         "email":user.email,
                                //         "userId":user.uid
                                //       });                              
                                // }
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