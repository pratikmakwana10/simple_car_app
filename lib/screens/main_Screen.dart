import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_food_app/provider/bottom_navigation_provider.dart';
import 'package:simple_food_app/screens/cart.dart';
import 'package:simple_food_app/screens/homepage.dart';

import 'order_Screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({Key? key}) : super(key: key);

  final _pagesData = [
      Home(),
     const CartScreen(),
    OrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final screenIndex = Provider.of<screenIndexProvider>(context);
    int cIndex = screenIndex.fetchCurrentScreenIndex;
    return Scaffold(
      body: Center(
        child: _pagesData[cIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: cIndex,
        onTap: (value) => screenIndex.updateScreenIndex(value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.save),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'My order',
          ),
        ],
      ),
    );
  }
}
