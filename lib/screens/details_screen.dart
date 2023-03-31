import 'dart:async';
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:simple_food_app/screens/cart.dart';
import 'package:simple_food_app/utility/shared_prefs_util.dart';
import '../utility/model_car.dart';

class DetailScreen extends StatefulWidget {
  Cars singleCar;

  DetailScreen({Key? key, required this.singleCar}) : super(key: key);

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  late Timer timer;
  bool isCarAdded = false;
  List<CartModel> checkList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    List<String> chk =
        SharedPreferenceUtils.getInstance().getStringList("cartModel") ?? [];
    for (var element in chk) {
      var car = json.decode(element);
      if (kDebugMode) {
        print(element);
      }
      var singleCar = CartModel.fromJson(car);
      checkList.add(singleCar);
      if (singleCar.productName == widget.singleCar.modelName) {
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
          widget.singleCar.modelName,
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
                      "Engine Displacement(cc)", widget.singleCar.engine),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("MaxPower BHP", widget.singleCar.maxPower),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("MaxTorque NM", widget.singleCar.maxTorque),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("Body Type", widget.singleCar.bodyType),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures(
                      "Fuel Type",
                      "${widget.singleCar.fuelType.first} / ${widget.singleCar.fuelType.last}"),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("Mileage", widget.singleCar.mileage),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("Mileage", widget.singleCar.mileage),
                  buildSizedBox5(5),
                  buildDivider(),
                  rowFeatures("Safety Rating", widget.singleCar.safetyRating),
                  buildSizedBox5(5),
                  buildDivider(),
                  buildSizedBox5(10),
                  addTOCartButton(),
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
                    children: widget.singleCar.sliderImages
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
          "${widget.singleCar.make}  ${widget.singleCar.modelName}",
          style: const TextStyle(
              fontSize: 19, color: Colors.black, fontWeight: FontWeight.bold),
        ),
        const Spacer(),
        Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 15.0),
              child: Text(
                "₹${widget.singleCar.price}",
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

  InkWell addTOCartButton() {
    return InkWell(
        onTap: () {
          if (!isCarAdded) {
            List<String> allCars = SharedPreferenceUtils.getInstance()
                    .getStringList("cartModel") ??
                [];
            String singleCar = json.encode(CartModel(
              widget.singleCar.modelName,
              widget.singleCar.make,
              widget.singleCar.image,
              widget.singleCar.price,
              1,
              int.parse(widget.singleCar.price) * 1,
            ));

            allCars.add(singleCar);

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
