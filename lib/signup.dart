import 'package:ecommerceapp/commons/common.dart';
import 'package:ecommerceapp/db/users.dart';
import 'package:ecommerceapp/homepage.dart';
import 'package:ecommerceapp/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final FirebaseAuth firebaseAuth=FirebaseAuth.instance;
  TextEditingController emailController=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  TextEditingController confirmPasswordController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  
  final _formkey=GlobalKey<FormState>();
  UserServices _userServices=UserServices();
  SharedPreferences preferences;
  bool isLoading=false;
  bool isLoggedin=false;
  bool hidePass=true;
  bool hideConfirmPass=true;
  String gender="Male";
  String groupValue='Male';
  valueChanged(String str){
    setState(() {
      if (str=='Male') {
        groupValue=str;
        gender=str;        
      }
      if (str=='Female') {
        groupValue=str;
        gender=str;        
      }
    });
  }
  Future validateForm()async{
    FormState formState=_formkey.currentState;
    if (formState.validate()) {
      formState.reset();
      setState(() {
        isLoading=true;
      });
     // FirebaseUser user=await firebaseAuth.currentUser();
      Map<String,dynamic> value;
      try{
        AuthResult res=await firebaseAuth.createUserWithEmailAndPassword(email:emailController.text, 
        password: passwordController.text);
              if (res!=null) {
                {
                    value={
                      "username":nameController.text,
                      "userid":res.user.uid,
                      "email":emailController.text,
                      "gender":gender,
                      "password":passwordController.text
                    };
                    _userServices.createUser(value);
              Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(ctx)=>HomePage(
                name:nameController.text ,
                email: emailController.text,
                photo:res.user.photoUrl ,
              )));     
              }
                
            }

      }
      on PlatformException catch(ex)
      {
        print(ex.toString());
          Toast.show('Email Already in use', context,duration:Toast.LENGTH_LONG);
          setState(() {
            isLoading=false;
          });
          
      }
            
      
    }

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
               top:MediaQuery.of(context).size.height*0.1
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
                                hintText: "Enter Full Name",
                                labelText: "Full Name",
                                border: InputBorder.none,
                                
                                icon: Padding(
                                  padding: const EdgeInsets.only(left:8.0),
                                  child: Icon(Icons.person,color: Colors.red,),
                                )
                              ),
                              controller:nameController ,
                              validator: (val){
                                if (val.isEmpty) {
                                  return"Please Enter Name";
                                  
                                }
                                else{
                                  return null;
                                }
                                
                              },
                            ),
                          ),
                          ),
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(
                              child: ListTile(
                                leading: Radio(value: 'Male', groupValue: groupValue,
                                onChanged:valueChanged,
                                ),
                                title: Text('Male',style: TextStyle(color:Colors.white),),
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                leading: Radio(value: 'Female', groupValue: groupValue, 
                                onChanged:valueChanged,
                                ),
                                title: Text('Female',style: TextStyle(color:Colors.white),),
                              ),
                            ),
                          ],
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
                          child: Row(
                            children: <Widget>[
                              Expanded(
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
                                    obscureText: hidePass,
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
                              IconButton(icon: Icon(Icons.remove_red_eye,color:Colors.red,),
                              splashColor: Colors.transparent,
                               onPressed: (){
                                 
                                 setState(() {
                                   if (hidePass==true) {
                                     hidePass=false;
                                   }
                                   else
                                    hidePass=true;
                                 });
                               })
                            ],
                          ),
                          ),
                        ),
                        Padding(
                          padding:  EdgeInsets.all(MediaQuery.of(context).size.width*0.02),
                          child: Material(
                          elevation: 0.0,
                          borderRadius: BorderRadius.circular(20.0),
                          color: Colors.white.withOpacity(0.8),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                  child: Container(
                                  decoration: BoxDecoration(
                                    
                                  ),
                                  child: TextFormField( 
                                    decoration: InputDecoration(
                                      hintText: "Enter Confirm Password",
                                      labelText: "Confirm Password",
                                      border: InputBorder.none,
                                      icon: Padding(
                                        padding: const EdgeInsets.only(left:8.0),
                                        child: Icon(Icons.lock_outline,color: Colors.red,),
                                      )
                                    ),
                                    obscureText: hideConfirmPass,
                                    controller:confirmPasswordController ,
                                    validator: (val){
                                      if (val.isNotEmpty) {
                                        if (passwordController.text!=val) {
                                          return " Password does not matched";
                                        }
                                        
                                        else{
                                          return null;
                                        }
                                      }
                                      else{
                                        return "Please Confirm EnterPassword";
                                      }
                                    },
                                  ),
                                ),
                              ),
                              IconButton(icon: Icon(Icons.remove_red_eye,color:Colors.red,),
                              splashColor: Colors.transparent,
                               onPressed: (){
                                 
                                 setState(() {
                                   if (hideConfirmPass==true) {
                                     hideConfirmPass=false;
                                   }
                                   else
                                    hideConfirmPass=true;
                                 });
                               })
                            ],
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
                              child: Text('Register',style: TextStyle(color:Colors.white),),
                              onPressed:()async{
                                validateForm();
                              }
                              ),
                          ),
                          ),
                        ),
                        FlatButton(
                          child: Text('Login',style:TextStyle(color:Colors.red[100],fontSize:20.0,decoration:TextDecoration.underline),),
                          onPressed:(){
                            changeScreenReplacement(context, Login());
                          },
                          )
                        

                      ],
                ),
                    
                  ),
              ),

            ),
          ),


          Visibility(
            visible:isLoading==true,
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