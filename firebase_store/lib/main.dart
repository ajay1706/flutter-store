import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
      
    );
  }
}

class HomePage extends StatelessWidget {

// first we need top creat the instance of the FirebaseAuth and Google-Sign-In
final FirebaseAuth _auth = FirebaseAuth.instance; //FirebaseAuth instance
final GoogleSignIn googleSignIn = new GoogleSignIn(); //Google-Sign-In Instance


//methods to user sign-in & sign-out
Future<FirebaseUser> _signIn() async {
  //instance of the GoogleSignIn Account
  GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();

  //Now we need to authenticate the Google Sign In account
   GoogleSignInAuthentication gSA =
      await googleSignInAccount.authentication;

      

 final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: gSA.accessToken,
      idToken: gSA.idToken,
    );
    //To access the FirebaseUser or get the FirebaseUser
    FirebaseUser user =(await _auth.signInWithCredential(credential)).user;

      print("User Name: ${user.displayName}");
      return user;


}

void _signOut(){
  googleSignIn.signOut();
  print("User Signed out");
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google-Sign-In"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(28.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
RaisedButton(  
  child: Text("Sign In"),
  onPressed: () => _signIn().then((FirebaseUser user) => print(user)).catchError((e) => print(e)),
  color: Colors.green,
),
RaisedButton(  
  child: Text("Sign Out"),
  onPressed: () => _signOut(),
  color: Colors.red,
)


          ],
        ),
      ),
      
    );
  }
}