
import 'package:ecommerce/views/cart_screen.dart';
import 'package:ecommerce/views/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

import 'add_product_screen.dart';
import 'favourite_screen.dart';
import 'home_screen.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({super.key});

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {

  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex,
          children:  [HomeScreen(), FavouriteScreen(), CartScreen(), ProfileScreen(),]),
      floatingActionButton: FloatingActionButton(backgroundColor: Colors.purple, onPressed: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AddProductScreen()));
      }, child: const Icon(Icons.add)),
      bottomNavigationBar: SalomonBottomBar(currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [/// Home
          SalomonBottomBarItem(icon: const Icon(Icons.home), title: const Text("Home"), selectedColor: Colors.purple),
          /// Likes
          SalomonBottomBarItem(icon: const Icon(Icons.favorite_border), title: const Text("Favourite"), selectedColor: Colors.red),
          /// Search
          SalomonBottomBarItem(icon: const Icon(Icons.shopping_cart), title: const Text("Cart"), selectedColor: Colors.orange),
          /// Profile
          SalomonBottomBarItem(icon: const Icon(Icons.person), title: const Text("Profile"), selectedColor: Colors.teal),
        ],
      ),
    );
  }
}