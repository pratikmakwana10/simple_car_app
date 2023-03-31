import 'package:flutter/material.dart';
import 'package:simple_food_app/screens/homepage.dart';
import 'package:simple_food_app/screens/main_Screen.dart';
import 'package:simple_food_app/screens/practice.dart';
import 'package:simple_food_app/utility/shared_prefs_util.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
await  SharedPreferenceUtils.getInstance().initializePreference();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',

      theme: ThemeData(
       primarySwatch: Colors.blueGrey,
      ),

      home:   MainScreen(),
    );
  }
}

