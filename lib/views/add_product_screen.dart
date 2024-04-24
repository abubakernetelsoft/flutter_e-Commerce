import 'dart:ffi';

import 'package:ecommerce/models/product_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddProductScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _AddProductScreen();
}

class _AddProductScreen extends State<AddProductScreen> {
  File? image;
  final picker = ImagePicker();
  var placeholder = AssetImage('assets/images/bg.jpg');
  var nameController = TextEditingController();
  var descController = TextEditingController();
  var priceController = TextEditingController();

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future pickImageC() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);

      if (image == null) return;

      final imageTemp = File(image.path);

      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Container(margin: EdgeInsets.all(15),
      child: Center(child: SingleChildScrollView(child: Column(
        children: [
          Container(width: 100, height: 100, decoration: BoxDecoration(shape: BoxShape.circle),
              child: image != null ? Image.file(image!, width: 100, height: 100,)
                  : Image.asset('assets/images/bg.jpg', fit: BoxFit.fill,)),
          Row(mainAxisAlignment : MainAxisAlignment.center,children: [
            InkWell(child: Container(margin : EdgeInsets.only(right: 10),alignment : Alignment.center,width: 30, height: 30, child:
            Image.asset('assets/images/gallery.png', fit: BoxFit.fill,)), onTap: (){
              pickImage();
            }),
            InkWell(child: Container(alignment : Alignment.center,width: 30, height: 30, child: Image.asset('assets/images/camera.png', fit: BoxFit.fill,)), onTap: () {
              pickImageC();
            },)],
          ),
          Container(height: 50, margin: EdgeInsets.only(top: 10), child: TextField(controller : nameController,
              cursorColor: Colors.lightBlue, decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Name', hintText: 'Product Name'),),),
          Container(height: 50, margin: EdgeInsets.only(top: 10), child: TextField(controller : descController,
            cursorColor: Colors.lightBlue, decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Description', hintText: 'Product Description'),),),
          Container(height: 50, margin: EdgeInsets.only(top: 10), child: TextField(controller : priceController,keyboardType: TextInputType.number,
            cursorColor: Colors.lightBlue, decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Price', hintText: 'Product Price'),),),
          Container(margin:EdgeInsets.only(top: 20),child: ElevatedButton(onPressed: () async{
            // var pref = await SharedPreferences.getInstance();
            // pref.setBool(Constants.IS_LOGIN, true);
            // Navigator.pushReplacement(context,
            //     MaterialPageRoute(builder:
            //         (context) => DashBoardScreen()
            //     )
            // );
            var name = nameController.text.toString();
            var desc = descController.text.toString();
            var price = priceController.text.toString();
            // FocusManager.instance.primaryFocus?.unfocus();
            // print(email+"   "+password);
            // addNewProduct(name , desc , price );
          }, child: Text('     Add Product     '))),

        ],
      ))
              // child: Column(
              //   children: [
              //     Container(width : 100,height : 100,child: Image.file(image!)),
              //     SizedBox(height: 20,),
              //     image != null ? Image.file(image!, width: 100,height: 100,): Text("No image selected")
              //   ],
              // ),
              ),
    ));
  }

  // void addNewProduct(String name, String desc, String price) async{
  //   ProductModel userModel = ProductModel( name , name: name , email: user.email , phoneNo: phone , address: address ,password: password );
  //   await databaseReference.child('Users').child(user.uid).set(userModel.toJson()).then((value) => {
  //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), ModalRoute.withName("/Login"))
  //   }).catchError((error) {
  //     print('Exception : ${error.message}');
  //     // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
  //     //   content: Text('SignUp Successfully'),
  //     // ));
  //   });
  // }
//   late File _image;
//   final picker = ImagePicker();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//           child: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 20),
//           width: double.infinity,
//           child: (Column(
//             children: [
//             Container(height : 50,margin: EdgeInsets.only(top: 10),
//             child: TextField(cursorColor: Colors.lightBlue,
//               decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email', hintText: 'Enter Email'),
//             ),
//           ),Container(height : 50,margin: EdgeInsets.only(top: 10),
//                 child: TextField(cursorColor: Colors.lightBlue,
//                   decoration: InputDecoration(border: OutlineInputBorder(), labelText: 'Email', hintText: 'Enter Email'),
//                 ),
//               )
//             ],
//           )),
//         ),
//       )),
//     );
//   }
//
//   Future getImageFromGallery() async {
//     final pickedFile = await picker.getImage(source: ImageSource.gallery);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }
// //Image Picker function to get image from camera
//   Future getImageFromCamera() async {
//     final pickedFile = await picker.getImage(source: ImageSource.camera);
//
//     setState(() {
//       if (pickedFile != null) {
//         _image = File(pickedFile.path);
//       }
//     });
//   }
//
//   //Show options to get image from camera or gallery
//   Future showOptions() async {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) => CupertinoActionSheet(
//         actions: [
//           CupertinoActionSheetAction(
//             child: Text('Photo Gallery'),
//             onPressed: () {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from gallery
//               getImageFromGallery();
//             },
//           ),
//           CupertinoActionSheetAction(
//             child: Text('Camera'),
//             onPressed: () {
//               // close the options modal
//               Navigator.of(context).pop();
//               // get image from camera
//               getImageFromCamera();
//             },
//           ),
//         ],
//       ),
//     );
//   }
}
