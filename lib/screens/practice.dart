

import 'package:flutter/material.dart';

class Practice extends StatefulWidget {
  const Practice({Key? key}) : super(key: key);

  @override
  State<Practice> createState() => _PracticeState();
}
bool invert = false;
class _PracticeState extends State<Practice> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Center(
            child: Transform(
              transform: Matrix4.skew(0.1,0.2),
              child: Container(
                height: 150, width: 150,
                decoration: BoxDecoration(gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [Colors.purple, Colors.blue]),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(15))
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              invert = !invert;

            },
            child: AnimatedContainer(duration: Duration(seconds: 2),
              height: 60,width: double.maxFinite,
              decoration: BoxDecoration(gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Colors.purple, Colors.blue]),
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(15))
              ),
              child: Center(child: Text("Take effect",style: TextStyle(fontSize: 25,color: Colors.white70,fontWeight: FontWeight.bold),)),
            ),
          ),
        ],
      ),
    );
  }
}
