// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:pasien_arifa_medikal/App/Auth/login_view.dart';
import 'package:pasien_arifa_medikal/App/Pasien/hasil_mcu.dart';
import 'package:pasien_arifa_medikal/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
    apiKey: "AIzaSyBLOcPh2gHRHry-ZXy_dEjCop2pWcNQYX4",
    authDomain: "arifa-medikal-klinik-c8675.firebaseapp.com",
    databaseURL:
        "https://arifa-medikal-klinik-c8675-default-rtdb.asia-southeast1.firebasedatabase.app",
    projectId: "arifa-medikal-klinik-c8675",
    storageBucket: "arifa-medikal-klinik-c8675.appspot.com",
    messagingSenderId: "603088810081",
    appId: "1:603088810081:web:21eff1676e09d379f3fa20",
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? token;
  Map<String, dynamic>? userMap;
  String? nik;
  String idPasien = "";
  String nikDb = "";
  // DocumentSnapshot? userMap;
  final db = FirebaseFirestore.instance;
  @override
  void initState() {
    getData();

    super.initState();
  }

  getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      nik = prefs.getString('nikUser')!;
    });
    if (nik != null) {
      Get.offAll(HasilMCU());
    } else {
      Get.offAll(LoginView());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(debugShowCheckedModeBanner: false, home: LoginView());
  }
}
