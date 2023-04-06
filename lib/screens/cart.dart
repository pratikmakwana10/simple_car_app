import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:simple_food_app/utility/shared_prefs_util.dart';
import '../utility/model_car.dart';
import 'order_Screen.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<CartModel> cartList = [];

  void init(){
    List<String> pol =
        SharedPreferenceUtils.getInstance().getStringList("cartModel") ?? [];
    for (var element in pol) {
      // print(element);
      var singleObject = json.decode(element);
      var singleCartItem = CartModel.fromJson(singleObject);
      cartList.add(singleCartItem);
    }

    calculateCartPrice();
  }

  calculateCartPrice() {
    total = 0;
    for (int i = 0; i < cartList.length; i++) {
      //  print("before - $total");
      total += double.parse(cartList[i].productPrice) *
          cartList[i].productQuantity.toDouble();
      //  print("After - $total");
    }
  }
  double total = 0;


  incrementTotalPrice(int index) {
    calculateCartPrice();

    setState(() {});
  }

  incrementSingleTotal(int index) {
    cartList[index].productQuantityPrice.toString();
    /*  singleTotal = cartList[index].productQuantityPrice * SharedPreferenceUtils.
    print( singleTotal);*/
    setState(() {});
  }

  decrementTotalPrice(int index) {
    total = cartList[index].productQuantity *
        double.parse(cartList[index].productPrice);
  }

  removePriceTotal(int index) {
    // total = total - cartList[index].productPrice
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: cartList.isEmpty
          ? buildEmptyCart()
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  buildCartItem(),
                  totalAmount(),
                  buildCheckOutButton(context)
                ],
              ),
            ),
    );
  }

  InkWell buildCheckOutButton(BuildContext context) {
    return InkWell(
      onTap: () {
        List<String> chk =
            SharedPreferenceUtils.getInstance().getStringList("OrderList") ??
                [];
        for (var element in cartList) {
          var car = json.encode(element);

          chk.add(car);
        }
        SharedPreferenceUtils.getInstance().setData("OrderList", chk);

        SharedPreferenceUtils.getInstance().removeString("cartModel");
        cartList.clear();
        setState(() {});

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>  OrderScreen()),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(left: 10, right: 10),
        height: 50,
        width: double.maxFinite,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(5)),
          color: Colors.blueGrey,
        ),
        child: const Center(
            child: Text(
          "CheckOut",
          style: TextStyle(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        )),
      ),
    );
  }

  SizedBox buildEmptyCart() {
    return const SizedBox(
      height: 700,
      child: Center(
        child: Text("Your Cart is Empty",
            style: TextStyle(
                color: Colors.black45,
                fontSize: 18,
                fontWeight: FontWeight.w800)),
      ),
    );
  }

  Padding totalAmount() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.blueGrey,
        ),
        margin: const EdgeInsets.all(10),
        height: 70,
        width: double.maxFinite,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Text("Total Amount",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w800)),
            Text(
              "₹ ${total.toStringAsFixed(2)}",
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }

  SingleChildScrollView buildCartItem() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 500,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView.builder(
            itemCount: cartList.length,
            itemBuilder: (context, index) {
              return singleCartItem(index);
            },
          ),
        ),
      ),
    );
  }

  Widget singleCartItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.blueGrey,
            ),
            child: Row(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.blueGrey,
                          ),
                          margin: const EdgeInsets.only(left: 8),
                          height: 80,
                          width: 120,
                          child: Image.network(
                            cartList[index].productImage,
                            fit: BoxFit.cover,
                            scale: 1,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              right: 10.0, top: 15, bottom: 15),
                          child: Column(
                            children: [
                              textProductInfo(
                                index,
                                cartList[index].productName,
                              ),
                              textProductInfo(
                                index,
                                cartList[index].productBrand,
                              ),
                              textProductInfo(
                                index,
                                cartList[index].productPrice,
                              ),
                              textProductInfo(
                                index,
                                cartList[index].productQuantityPrice.toString(),
                                // singleTotal.toString(),
                                // qtyTotal.toStringAsFixed(2),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            InkWell(
                              onTap: () {
                                setState(() {
                                  cartList[index].productQuantity <= 1
                                      ? cartList.removeAt(index)
                                      : cartList[index].productQuantity--;
                                  incrementTotalPrice(index);
                                  cartList[index].productQuantityPrice =
                                      int.parse(cartList[index].productPrice) *
                                          cartList[index].productQuantity;
                                  //incrementSingleTotal(index);
                                  // cartList[index].productQuantity == 0 ?
                                  // cartList.removeAt(index):
                                });
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                color: Colors.blueGrey.shade800,
                                child: const Center(
                                    child: Icon(
                                  Icons.remove,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8),
                              child: Text(
                                cartList[index].productQuantity.toString(),
                                style: const TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                cartList[index].productQuantity++;
                                cartList[index].productQuantityPrice =
                                    int.parse(cartList[index].productPrice) *
                                        cartList[index].productQuantity;
                                incrementTotalPrice(index);
                                /* SharedPreferenceUtils.getInstance().setData(
                                    "cartModel",
                                    cartList[index].productQuantity);*/
                                // incrementSingleTotal(index);
                                setState(() {});
                              },
                              child: Container(
                                height: 25,
                                width: 25,
                                color: Colors.blueGrey.shade800,
                                child: const Center(
                                    child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                )),
                              ),
                            ),
                          ],
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              cartList.removeAt(index);
                              calculateCartPrice();
                              SharedPreferenceUtils.getInstance()
                                  .removeString("cartModel");
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10.0),
                            child: Icon(
                              Icons.delete,
                              color: Colors.red.shade200,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Text textProductInfo(int index, String text) {
    return Text(text,
        style: const TextStyle(
            fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold));
  }
}
