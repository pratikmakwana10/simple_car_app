import 'package:flutter/material.dart';
import 'package:simple_food_app/screens/details_screen.dart';
import 'package:simple_food_app/utility/model_car.dart';

import 'cart.dart';

class SecondScreen extends StatelessWidget {
  List<Cars> filteredList;
String title;
  SecondScreen({
    Key? key,
    required this.filteredList,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredList.length,
        itemBuilder: (context, index) {
          return productDescription(filteredList[index],context);
        },
      ),
    );
  }

  Container productDescription(Cars singleCar,BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.blueGrey,
            offset: Offset(
              5.0,
              5.0,
            ),
            blurRadius: 10.0,
            spreadRadius: 3.0,
          ),
          BoxShadow(
            color: Colors.white,
            offset: Offset(0.0, 0.0),
            blurRadius: 0.0,
            spreadRadius: 0.0,
          ),
        ],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Image.network(
              singleCar.image,
              fit: BoxFit.fitHeight,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.blueGrey.shade500,
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                        : null,
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      singleCar.make,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      singleCar.modelName,
                      style:
                          const TextStyle(fontSize: 25, fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
             // Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      singleCar.bodyType,
                      style:
                          TextStyle(fontSize: 12, color: Colors.grey.shade800),
                    ),
                    Text(
                      "₹${singleCar.price}",
                      style: const TextStyle(fontSize: 25),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 3,
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          DetailScreen(singleCar: singleCar)));
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(5)),
                color: Colors.blueGrey.shade400,
              ),
              height: 35,
              width: double.maxFinite,
              child: const Center(
                  child: Text(
                "View Info",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w600),
              )),
            ),
          ),
        ],
      ),
    );
  }
}
