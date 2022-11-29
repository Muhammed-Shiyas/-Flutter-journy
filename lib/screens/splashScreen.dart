import 'package:flutter/material.dart';
import 'package:journalapp/screens/homeScreen.dart';
import 'package:journalapp/constants.dart';
import '../components.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) => homeScreen(),
        ),
      );
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          decoration: kScreenBg,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                JournyTitle(),
                SizedBox(
                  height: 10,
                ),
                Image.asset(
                  "images/diary.png",
                  scale: 4,
                )
              ],
            ),
          ),
        ));
  }
}
