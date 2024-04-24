
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';

import '../models/product_model.dart';

class CatProvider extends ChangeNotifier {

  String _name = 'undefined michi 😼';
  final databaseReference = FirebaseDatabase.instance.ref();
  late List<ProductModel>? _productModel = [];

  String get name => _name;

  set name (String newName) {
    _name = newName;
    notifyListeners();
  }

  // void _getData() async {
  //   var apiResponse = ApiService();
  //   _productModel = (await apiResponse.getProducts());
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }


}