import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

abstract class BaseAuth{
  Future<FirebaseUser> googleSignIn();
}
class Auth implements BaseAuth{
  FirebaseAuth _firebaseAuth=FirebaseAuth.instance;
  @override
  Future<FirebaseUser> googleSignIn() async{
    // TODO: implement googleSignIn

    final GoogleSignIn googleSignIn=GoogleSignIn();
    final GoogleSignInAccount googleSignInAccount=await googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth=await googleSignInAccount.authentication;
    final AuthCredential credential=GoogleAuthProvider.getCredential(idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
    try{
      AuthResult authResult=await _firebaseAuth.signInWithCredential(credential);
      FirebaseUser user=authResult.user;
      return user;
    }
    catch(e){
      print(e.toString());
    return null;
    }
  }

}