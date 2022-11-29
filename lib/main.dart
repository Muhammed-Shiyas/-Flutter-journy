import 'package:flutter/material.dart';
import 'package:journalapp/screens/splashScreen.dart';
import './screens/homeScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_launcher_icons/android.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
        apiKey: 'AIzaSyBdSr47kPOMXdayD7IPjHfp_42t0TyuvNM',
        appId: '1:982898998512:android:4b644b48e15bc2a9b91635',
        messagingSenderId: '982898998512',
        projectId: 'journal-29011'),
  );
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.white),
    ),
    home: SplashScreen(),
  ));
}
