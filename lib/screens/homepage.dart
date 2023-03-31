import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../utility/carList.dart';
import '../utility/const.dart';
import '../utility/model_car.dart';
import 'cart.dart';
import 'second_screen.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

List<BrandDetail> brandDetail = [
  BrandDetail(marutiImageURL, maruti),
  BrandDetail(hyundaiImageURL, hyundai),
  BrandDetail(mahindraImageURl, mahindra),
  BrandDetail(tataImageURl, tata),
  BrandDetail(toyotaImageURL, toyota),
];

List<Categories> categories = [
  Categories(
      "https://bharathautos.com/wp-content/uploads/2018/04/skoda-premium-hatchback-car-india-pictures-photos-images-snaps-rear-back.jpg",
      hatchback),
  Categories(
      "https://gaadiwaadi.com/wp-content/uploads/2020/07/2020-Lexus-ES.jpg",
      seden),
  Categories(
      "https://images.livemint.com/img/2019/10/16/1600x900/Mercedes_1571218796443.jpg",
      suv),
  Categories(
      "https://stimg.cardekho.com/images/carexteriorimages/630x420/Toyota/Toyota-Vellfire/7024/1563439989810/front-left-side-47.jpg?tr=w-300",
      muv)
];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(title: const Text("Cars"), centerTitle: true, actions: [
        appbarCartIcon(context),
      ]),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            searchBar(),
            buildSizedBox10(),
            textPopularBrand(),
            buildSizedBox10(),
            popularBrands(context),
            buildSizedBox10(),
            textByCategories(),
            carCategories(),
          ],
        ),
      ),
    );
  }

  Padding appbarCartIcon(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 8.0),
      child: IconButton(
        icon: const Icon(Icons.shopping_cart),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const CartScreen()));
        },
      ),
    );
  }

  SizedBox buildSizedBox10() {
    return const SizedBox(
      height: 10,
    );
  }

  Widget carCategories() {
    return Container(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          shrinkWrap: true,
          itemCount: 4,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 7.0,
              mainAxisSpacing: 7.0,
              mainAxisExtent: 150),
          itemBuilder: (BuildContext context, int index) {
            return singleGridItem(index);
          },
        ));
  }

  Widget singleGridItem(int index) {
    List<Cars> filteredList = carsList
        .where((e) => e.bodyType == categories[index].textCategories)
        .toList();

    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => SecondScreen(
                      filteredList: filteredList,
                      title: categories[index].textCategories,
                    )));
      },
      child: Column(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                image: DecorationImage(
                    image: NetworkImage(categories[index].image),
                    fit: BoxFit.cover,
                    scale: 2),
              ),
            ),
          ),
          Text(
            categories[index].textCategories,
            style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: Colors.black87),
          ),
        ],
      ),
    );
  }

  Text textByCategories() {
    return const Text(
      "Shop by Categories",
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
    );
  }

  SingleChildScrollView popularBrands(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
          children:
              brandDetail.map((e) => buildBrandLogo(e, context)).toList()),
    );
  }

  Text textPopularBrand() {
    return const Text(
      "Popular Brands",
      style: TextStyle(
          fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
    );
  }

  Padding searchBar() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: 'Search',
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0)),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade500, width: 1.2),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.blueGrey.shade200, width: 2.0),
            borderRadius: const BorderRadius.all(Radius.circular(5.0)),
          ),
        ),
      ),
    );
  }


  Widget buildBrandLogo(BrandDetail singleBrandDetail, context) {
    List<Cars> filteredList = carsList
        .where((company) => company.make == singleBrandDetail.textBrand)
        .toList();
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => SecondScreen(
                    filteredList: filteredList,
                    title: singleBrandDetail.textBrand,
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Transform(
          transform: Matrix4.skewY(0.5)..rotateZ(-math.pi / 25),

          // angle:  math.pi / 100.0,
          child: AnimatedContainer(
            transform: Matrix4.skewY(0.2)..rotateZ(-math.pi / 15),
            duration: const Duration(seconds: 2),
            curve: Curves.linear,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              // image: DecorationImage(image:NetworkImage("https://cdn.freebiesupply.com/logos/large/2x/maruti-suzuki-logo-png-transparent.png"),),
              color: Colors.blueGrey,
            ),
            height: 120,
            width: 120,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.network(singleBrandDetail.image),
            ),
          ),
        ),
      ),
    );
  }
}
  /*Container(
              height: 500,
              child: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: carsList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Image.network(carsList[index].image),
                    height: 100,
                    width: 100,
                  );
                },
              ),
            ),*/
/*
*   Container(
              padding: EdgeInsets.all(5),
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(width: 1, color: Colors.grey.shade500),
              ),
              child: Column(
                children: [
                  Container(
                    height: 200,
                    child: Image.network(
                      "https://imgd.aeplcdn.com/664x374/n/cw/ec/41197/hyundai-verna-right-front-three-quarter7.jpeg?q=75",
                      fit: BoxFit.fitHeight,
                    ),
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              maruti,
                              style: TextStyle(fontSize: 18),
                            ),
                            SizedBox(
                              height: 2,
                            ),
                            Text(
                              "Swift VDI",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 5,
                            ),
                            Container(
                                child: Text(
                                  "₹10L",
                                  style: TextStyle(fontSize: 25),
                                )),
                            Text(
                              "Starting MSRP",
                              style:
                              TextStyle(fontSize: 12, color: Colors.grey),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),*/
