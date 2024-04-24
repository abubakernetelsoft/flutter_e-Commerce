import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import '../models/user_model.dart';
import '../other/constants.dart';
import 'dashboard_screen.dart';
import 'register_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginScreen();

}

class _LoginScreen extends State<LoginScreen>{

  final databaseReference = FirebaseDatabase.instance.ref();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(width : double.infinity,height: double.infinity,child: Image.asset('assets/images/bg.jpg',fit: BoxFit.fill,),),
          Center(child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Card(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                  child: Container(
                    margin: EdgeInsets.only(top: 20 ,left: 25 , right: 25, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Login", style: TextStyle(fontSize: 30, color: Colors.blue),),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: TextField(controller : emailController,
                            keyboardType: TextInputType.emailAddress,decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email', hintText: 'Enter Email'),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: TextField(controller : passwordController ,decoration: InputDecoration(border: OutlineInputBorder(),
                              labelText: "Password"
                          ),),
                        ),
                        Container(alignment : Alignment.topRight,margin: EdgeInsets.only(top: 15),child: Text("Forgot Password?")),
                        Container(margin:EdgeInsets.only(top: 20),child: ElevatedButton(onPressed: () async{
                          // var pref = await SharedPreferences.getInstance();
                          // pref.setBool(Constants.IS_LOGIN, true);
                          // Navigator.pushReplacement(context,
                          //     MaterialPageRoute(builder:
                          //         (context) => DashBoardScreen()
                          //     )
                          // );
                          var email  = emailController.text.toString();
                          var password  = passwordController.text.toString();
                          FocusManager.instance.primaryFocus?.unfocus();
                          print(email+"   "+password);
                          signInUsingEmailPassword(email : email , password : password , context:context );
                        }, child: Text('     Login     '))),
                        Container(margin: EdgeInsets.only(top: 22 ,bottom: 20),
                          child: InkWell(onTap: (){
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen()));
                          },
                            child: RichText(text: TextSpan(
                              text: 'Don\'t have an account? ', style:
                            TextStyle(fontSize: 16 , color: Colors.grey),
                              children: const <TextSpan>[
                                TextSpan(text: 'Register Now', style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.blue)),
                              ],
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
          ),
          )
        ],
      ),
    );
  }

  void signInUsingEmailPassword({required String email, required String password, required BuildContext context,}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(email: email, password: password);
      print(userCredential.user!.uid);
      getUserDataFromDb(userCredential.user!.uid);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        showDialog(message: 'No user found for that email.');
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showDialog(message: 'Wrong password provided.');
        print('Wrong password provided.');
      } else {
        showDialog(message: 'Wrong password provided.');
        print(e.message);
      }
    }

  }

  void showDialog({required String message}) {
    AlertDialog(
      title: Text(message),
      // To display the title it is optional
      content: Text(''),
      // Message which will be pop up on the screen
      // Action widget which will provide the user to acknowledge the choice
      actions: [
        TextButton(
          onPressed: () {},
          child: Text('Ok'),
        ),
      ],
    );
  }

  void getUserDataFromDb(String id) async {
    UserModel userModel;
    var pref = await SharedPreferences.getInstance();

    databaseReference.child('Users').child(id).once().then((DatabaseEvent event) {
      userModel = UserModel.fromJson(jsonDecode(jsonEncode(event.snapshot.value)));
      print(userModel.password);
      pref.setBool(Constants.IS_LOGIN, true);
      Map<String, dynamic> map = userModel.toJson();
      pref.setString(Constants.USER_PREF, json.encode(map));
      pref.getString(Constants.USER_PREF);
      print("email___Name${pref.getString(Constants.USER_PREF)}   ${userModel.email}");
    })
        .then((value) => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DashBoardScreen()))})
        .catchError((error) {
      print('Exception : ${error.message}');
    });
  }


}