import 'dart:convert';
import 'package:flutter/material.dart';
import '../utility/model_car.dart';
import '../utility/shared_prefs_util.dart';

class OrderScreen extends StatelessWidget {
  OrderScreen({Key? key}) : super(key: key);

  late BuildContext _context;

  List<CartModel> checkList1 = [];

  // @override
  void init(BuildContext context) {
    _context = context;
    // provider = Provider.of(context,listen: false);
  }

  void getOrderList() {
    List<String> chk =
        SharedPreferenceUtils.getInstance().getStringList("OrderList") ?? [];
    for (var element in chk) {
      var car = json.decode(element);
      var singleCar = CartModel.fromJson(car);
      checkList1.add(singleCar);
    }
  }

  @override
  Widget build(BuildContext context) {
    getOrderList();
    init(context);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: checkList1.map((e) => singleCartItem(e)).toList(),
          ),
        ),
      ),
    );
  }
}

Widget singleCartItem(CartModel e) {
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
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.blueGrey,
                        ),
                        margin: const EdgeInsets.only(left: 10),
                        height: 85,
                        width: 120,
                        child: Image.network(
                          e.productImage,
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
                              e.productName,
                            ),
                            textProductInfo(
                              e.productBrand,
                            ),
                            textProductInfo(
                              e.productPrice,
                            ),
                            textProductInfo(e.productQuantity.toString()),
                            textProductInfo(e.productQuantityPrice.toString()),
                          ],
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

Text textProductInfo(String text) {
  return Text(text,
      style: const TextStyle(
          fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold));
}
