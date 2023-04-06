import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_food_app/screens/cart.dart';
import 'package:simple_food_app/utility/shared_prefs_util.dart';
import '../utility/model_car.dart';

class DetailScreen extends StatelessWidget {
  Cars singleCar;

  DetailScreen({Key? key, required this.singleCar}) : super(key: key);

  final PageController _pageController = PageController();

  int _currentPage = 0;

  late Timer timer;

  bool isCarAdded = false;

  List<CartModel> checkList = [];

  void init(){
    List<String> chk =
        SharedPreferenceUtils.getInstance().getStringList("cartModel") ?? [];
    for (var element in chk) {
      var car = json.decode(element);
      if (kDebugMode) {
        print(element);
      }
      var sCar = CartModel.fromJson(car);
      checkList.add(sCar);
      if (sCar.productName == singleCar.modelName) {
        isCarAdded = true;
        continue;
      }
  }
    Timer.periodic(const Duration(seconds: 3), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }

      _pageController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    init();
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const CartScreen()));
              },
            ),
          ),
        ],
        title: Text(
          singleCar.modelName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Row(
                children: [
                  buildPageView(context),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  buildSizedBox5(10),
                  headLineOfProduct(),
                  buildSizedBox5(15),
                  rowFeatures(
                      "Engine Displacement(cc)", singleCar.engine),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("MaxPower BHP", singleCar.maxPower),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("MaxTorque NM", singleCar.maxTorque),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("Body Type", singleCar.bodyType),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures(
                      "Fuel Type",
                      "${singleCar.fuelType.first} / ${singleCar.fuelType.last}"),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("Mileage", singleCar.mileage),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("Mileage", singleCar.mileage),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("Safety Rating", singleCar.safetyRating),
                  buildSizedBox5(5),
                  buildDivider(),
                  buildSizedBox5(10),
                  addTOCartButton(context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container buildPageView(BuildContext context) {
    return Container(
                  height: 250,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.blueGrey.shade100,
                  child: PageView(
                    physics: const BouncingScrollPhysics(),
                    controller: _pageController,
                    scrollDirection: Axis.horizontal,
                    children: singleCar.sliderImages
                        .map((e) => imagePageView(
                              e,
                            ))
                        .toList(),
                  ),
                );
  }

  Row headLineOfProduct() {
    return Row(
      children: [
        Text(
          "${singleCar.make}  ${singleCar.modelName}",
          style: const TextStyle(
              fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                "₹${singleCar.price}",
                style: const TextStyle(
                    fontSize: 19,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Text(
              "EX-showroom Price",
              style: TextStyle(fontSize: 10),
            ),
          ],
        ),
      ],
    );
  }

  InkWell addTOCartButton(BuildContext context) {
    return InkWell(
        onTap: () {
          if (!isCarAdded) {
            List<String> allCars = SharedPreferenceUtils.getInstance()
                    .getStringList("cartModel") ??
                [];
            String sCar = json.encode(CartModel(
              singleCar.modelName,
              singleCar.make,
              singleCar.image,
              singleCar.price,
              1,
              int.parse(singleCar.price) * 1,
            ));

            allCars.add(sCar);

            SharedPreferenceUtils.getInstance().setData("cartModel", allCars);
            isCarAdded = true;
          } else {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const CartScreen()));
          }

             ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.blueGrey,
              content: Text(
              "Item Added to Cart",
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            duration: Duration(milliseconds: 500),
          ));

        },
        child: Container(
          margin: const EdgeInsets.only(
            right: 10,
          ),
          //  padding: EdgeInsets.only(right: 20),
          height: 50,
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.blueGrey.shade500,
          ),

          child: Center(
              child: !isCarAdded
                  ? const Text(
                      "Add to Cart",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  : const Text(
                      "Place Order",
                      style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )),
        ));
  }

  Row rowFeatures(String text1, String text2) {
    return Row(
      children: [
        Text(
          text1,
          style: const TextStyle(fontSize: 15, color: Colors.black),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.only(right: 17),
          child: Text(
            text2,
            style: const TextStyle(fontSize: 15, color: Colors.black),
          ),
        ),
      ],
    );
  }

  SizedBox buildSizedBox5(double value) => SizedBox(
        height: value,
      );

  Divider buildDivider() {
    return Divider(
      color: Colors.grey.shade600,
      indent: 0,
      thickness: 0.7,
      endIndent: 10,
    );
  }

  Image imagePageView(String e) {
    return Image.network(
      e,
      fit: BoxFit.cover,
      scale: 3,
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent? loadingProgress) {
        if (loadingProgress == null) return child;
        return Center(
          child: CircularProgressIndicator(
            color: Colors.blueGrey,
            value: loadingProgress.expectedTotalBytes != null
                ? loadingProgress.cumulativeBytesLoaded /
                    loadingProgress.expectedTotalBytes!
                : null,
          ),
        );
      },
    );
  }
}
