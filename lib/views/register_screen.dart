
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/user_model.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => _RegisterScreen();

}

class _RegisterScreen extends State<RegisterScreen>{

  final databaseReference = FirebaseDatabase.instance.ref();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var addressController = TextEditingController();
  var passwordController = TextEditingController();
  String idController = ' ';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Register Screen'),
      // ),
      body: Stack(children: [
        SizedBox(width : double.infinity , height : double.infinity ,child: Image.asset('assets/images/bg.jpg',fit: BoxFit.fill,)),
        Center(
            child: SingleChildScrollView(child: Container(
              margin: EdgeInsets.only(top: 20 ,left: 15 , right: 15, bottom: 20), width: double.infinity,
              child:(Card( shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0),),
                child: Container(padding: EdgeInsets.all(10),margin: EdgeInsets.only(top: 30), child: Column(children: [
                  Text('Create Account' , style: TextStyle(fontSize: 30 , color: Colors.blue.shade500, fontWeight: FontWeight.bold)),
                  Container(height : 50,margin: EdgeInsets.only(top: 50),
                    child: TextField(controller : nameController ,cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Name', hintText: 'Enter Name'),
                    ),
                  ),Container(height : 50,margin: EdgeInsets.only(top: 10),
                    child: TextField(controller : emailController ,cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email', hintText: 'Enter Email'),
                    ),
                  ),Container(height : 50,margin: EdgeInsets.only(top: 10),
                    child: TextField(controller : phoneController ,cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Phone No', hintText: 'Enter Phone No'),
                    ),
                  ),Container(height : 50,margin: EdgeInsets.only(top: 10),
                    child: TextField(controller : addressController ,cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Address', hintText: 'Enter Address'),
                    ),
                  ),Container(height : 50,margin: EdgeInsets.only(top: 10),
                    child: TextField(controller : passwordController ,cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Password', hintText: 'Enter Password'),
                    ),
                  ),Container(height : 50,margin: EdgeInsets.only(top: 10),
                    child: TextField(cursorColor: Colors.lightBlue,
                      decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Confirm Password', hintText: 'Enter Confirm Password'),
                    ),
                  ),
                  // Container(margin: EdgeInsets.only(top: 10),
                  //   child: Align(alignment: Alignment.topRight,child: Text('Forgot Password?')),
                  // ),
                  Container(margin:const EdgeInsets.only(top: 20),child: ElevatedButton(onPressed: () async{
                    var name  = nameController.text.toString();
                    var email  = emailController.text.toString();
                    var phone  = phoneController.text.toString();
                    var address  = addressController.text.toString();
                    var password  = passwordController.text.toString();
                    registerUsingEmailPassword(name: name , email:  email , password: password ,phone : phone ,address: address);

                    // var userModel = UserModel(id: idController++, name: name, email: email, phoneNo: phone, address: address , password: password);
                    //
                    // _insert(name , email , phone , address , password);
                    //
                    //
                    // Map<String , dynamic> map = userModel.toJson();
                    // SharedPreferences pref = await SharedPreferences.getInstance();
                    // pref.setString(Constants.USER_PREF, json.encode(map));
                    // pref.setBool(Constants.IS_LOGIN, true);
                    //
                    // Navigator.pushAndRemoveUntil(
                    //     context,
                    //     MaterialPageRoute(
                    //         builder: (context) => DashBoardScreen()
                    //     ),
                    //     ModalRoute.withName("/DashBoard")
                    // );

                  }, child: Text('     Register     '))),
                  Container(margin: EdgeInsets.only(top: 22 , bottom: 20), child: InkWell(onTap: (){Navigator.of(context).pop();
                  }, child: RichText(text: TextSpan(
                    text: 'Already a Member ', style: TextStyle(fontSize: 16 , color: Colors.grey),
                    children: const <TextSpan>[
                      TextSpan(text: 'Login Now', style: TextStyle(fontWeight: FontWeight.bold ,color: Colors.blue)),
                    ],
                  )),
                  ),
                  )
                ],),
                ),
              )),
            ),
            )),
      ],
      ),
    );
  }

  Future<User?> registerUsingEmailPassword({
    required String name, required String email, required String password, required String phone, required String address,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password,
      );
      user = userCredential.user;
      await user!.updateProfile(displayName: name);
      await user.reload();
      user = auth.currentUser;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    if (user != null){
      saveUserOnRealTimeDb(user ,name , phone , address ,password);
    }
    return user;
  }

  void saveUserOnRealTimeDb(User user, String name, String phone, String address, String password) async{
    UserModel userModel = UserModel(id : user.uid , name: name , email: user.email , phoneNo: phone , address: address ,password: password );
    await databaseReference.child('Users').child(user.uid).set(userModel.toJson()).then((value) => {
      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), ModalRoute.withName("/Login"))
    }).catchError((error) {
      print('Exception : ${error.message}');
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //   content: Text('SignUp Successfully'),
      // ));
    });
  }

  showSnackBar(String message){
    SnackBar snackBar = SnackBar(
      content: const Text('SignUp Successfully',
          style: TextStyle(fontSize: 20)),
      backgroundColor: Colors.indigo,
      dismissDirection: DismissDirection.up,
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).size.height - 150,
          left: 10,
          right: 10),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

}