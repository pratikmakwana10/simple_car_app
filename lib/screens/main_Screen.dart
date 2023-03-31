import 'package:flutter/material.dart';
import 'package:simple_food_app/screens/cart.dart';
import 'package:simple_food_app/screens/homepage.dart';

import 'order_Screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pagesData = [
    const Home(),
    const CartScreen(),
    const OrderScreen(),
  ];
  int _selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pagesData[_selectedItem],
      ),
      bottomNavigationBar: BottomNavigationBar(
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
          currentIndex: _selectedItem,
          onTap: (setValue) {
              _selectedItem = setValue;
            setState(() {

            });
          }),
    );
  }
}
