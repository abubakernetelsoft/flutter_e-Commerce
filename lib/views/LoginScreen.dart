
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'RegisterScreen.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _LoginScreen();

}

class _LoginScreen extends State<LoginScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(width : double.infinity,height: double.infinity,child: Image.asset('assets/images/bg.jpg',fit: BoxFit.fill,),),
          Center(child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.only(left: 15, right: 15),
                child: Card(
                  child: Container(
                    margin: EdgeInsets.only(top: 20 ,left: 25 , right: 25, bottom: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Login", style: TextStyle(fontSize: 30, color: Colors.blue),),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: TextField(
                            keyboardType: TextInputType.emailAddress,decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email', hintText: 'Enter Email'),),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 30),
                          child: TextField(decoration: InputDecoration(border: OutlineInputBorder(),
                              labelText: "Password"
                          ),),
                        ),
                        Container(alignment : Alignment.topRight,margin: EdgeInsets.only(top: 15),child: Text("Forgot Password?")),
                        Container(
                          margin: EdgeInsets.only(top: 50),
                          child: ElevatedButton(onPressed:(){
                            print("Clicked");
                          }, child: Text("      Login     ")),
                        ),
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

}