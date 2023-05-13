// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';
import 'package:pasien_arifa_medikal/App/Auth/login_view.dart';
import 'package:pasien_arifa_medikal/App/Components/widget.dart';
import 'package:pasien_arifa_medikal/App/Pasien/hasil_mcu.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  final namaController = TextEditingController();
  final nikController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool boolErrokNik = true;
  bool boolErrokEmail = true;
  bool boolErrokPassword = true;

  String msgErrorNik = "";
  String msgErrorEmail = "";
  String msgErrorPassword = "";

  bool obsPass = true;

  Map<String, dynamic>? userMap;
  String idPasien = "";
  String nikDb = "";
  // DocumentSnapshot? userMap;
  final db = FirebaseFirestore.instance;

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple, Colors.orange],
                begin: Alignment.bottomLeft,
                end: Alignment.topRight)),
        child: Center(
          child: Container(
            width: 500,
            // height: 650,
            margin: EdgeInsets.symmetric(vertical: 20),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 160,
                        height: 80,
                        child: Image.asset(
                          'assets/images/favicon.png',
                          fit: BoxFit.cover,
                        )),
                  ],
                ),
                textDefault("Daftar", 30, Colors.black, FontWeight.bold),
                Divider(
                  thickness: 1,
                ),
                SizedBox(
                  height: 10,
                ),
                textDefault("Nama", 14, Colors.black, FontWeight.normal),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                      controller: namaController,
                      style: TextStyle(fontFamily: 'poppins', fontSize: 14),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan Nama Anda",
                      )),
                ),
                SizedBox(
                  height: 10,
                ),
                textDefault("NIK", 14, Colors.black, FontWeight.normal),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: msgErrorNik == "" ? Colors.grey : Colors.red),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                      controller: nikController,
                      onChanged: (value) {
                        onChanged(value);
                      },
                      keyboardType: TextInputType.number,
                      style: TextStyle(fontFamily: 'poppins', fontSize: 14),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan NIK Anda",
                      )),
                ),
                msgErrorNik == ""
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          textDefault(
                              msgErrorNik, 12, Colors.red, FontWeight.normal)
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
                textDefault("Email", 14, Colors.black, FontWeight.normal),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color:
                              msgErrorEmail == "" ? Colors.grey : Colors.red),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                      controller: emailController,
                      onChanged: (value) {
                        onChanged(value);
                      },
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(fontFamily: 'poppins', fontSize: 14),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Masukkan Email Anda",
                      )),
                ),
                msgErrorEmail == ""
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          textDefault(
                              msgErrorEmail, 12, Colors.red, FontWeight.normal)
                        ],
                      ),
                SizedBox(
                  height: 10,
                ),
                textDefault("Password", 14, Colors.black, FontWeight.normal),
                SizedBox(
                  height: 5,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: msgErrorPassword == ""
                              ? Colors.grey
                              : Colors.red),
                      borderRadius: BorderRadius.circular(5)),
                  child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: obsPass,
                      controller: passwordController,
                      onChanged: (value) {
                        onChanged(value);
                      },
                      style: TextStyle(fontFamily: 'poppins', fontSize: 14),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Masukkan Password Anda",
                          suffixIcon: obsPass
                              ? InkWell(
                                  onTap: () {
                                    setState(() {
                                      obsPass = !obsPass;
                                    });
                                  },
                                  child: Icon(
                                    Icons.visibility,
                                    color: Colors.grey,
                                  ),
                                )
                              : InkWell(
                                  onTap: () {
                                    setState(() {
                                      obsPass = !obsPass;
                                    });
                                  },
                                  child: Icon(
                                    Icons.visibility_off,
                                    color: Colors.grey,
                                  )))),
                ),
                msgErrorPassword == ""
                    ? Container()
                    : Column(
                        children: [
                          SizedBox(
                            height: 5,
                          ),
                          textDefault(msgErrorPassword, 12, Colors.red,
                              FontWeight.normal)
                        ],
                      ),
                SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    btnRegister();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        gradient: LinearGradient(
                            colors: [Colors.blue, Colors.green])),
                    child: Center(
                      child: isLoading
                          ? Container(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                          : textDefault(
                              "Daftar", 14, Colors.white, FontWeight.normal),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          text: 'Sudah punya akun?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'poppins'),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Login disini',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14,
                                    fontFamily: 'poppins'),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return LoginView();
                                    }));
                                  }),
                          ]),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  onChanged(String value) {
    if (nikController.text.length < 16) {
      setState(() {
        msgErrorNik = "NIK Minimal 16 Digit Angka !";
        msgErrorEmail = "";
        msgErrorPassword = "";
        boolErrokNik = true;
        boolErrokEmail = false;
        boolErrokPassword = false;
      });
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      setState(() {
        msgErrorEmail = "Email Tidak Valid !";
        msgErrorNik = "";
        msgErrorPassword = "";
        boolErrokNik = false;
        boolErrokEmail = true;
        boolErrokPassword = false;
      });
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(passwordController.text)) {
      setState(() {
        msgErrorPassword =
            "Password minimal 8 karakter dan harus mengandung angka, huruf besar serta huruf kecil";
        msgErrorEmail = "";
        msgErrorNik = "";
        boolErrokNik = false;
        boolErrokEmail = false;
        boolErrokPassword = true;
      });
    } else {
      setState(() {
        msgErrorEmail = "";
        msgErrorNik = "";
        msgErrorPassword = "";
        boolErrokNik = false;
        boolErrokEmail = false;
        boolErrokPassword = false;
      });
    }
  }

  btnRegister() async {
    if (boolErrokEmail == false &&
        boolErrokNik == false &&
        boolErrokPassword == false) {
      setState(() {
        isLoading = true;
      });
      String mydata1 = passwordController.text;
      List<int> mydataint = utf8.encode(mydata1);
      String bs64str = base64.encode(mydataint);
      print(bs64str);
      // List<int> decodedint = base64.decode(bs64str);
      // String decodedPassword = utf8.decode(decodedint);
      // print(decodedstring);
      await db
          .collection('users_pasien')
          .where('NIK', isEqualTo: nikController.text)
          .get()
          .then((value) {
        userMap = value.docs[0].data();
        print(userMap);
        setState(() {
          isLoading = false;
          msgErrorNik = "NIK Sudah Terdaftar !";
          msgErrorEmail = "";
          msgErrorPassword = "";
          boolErrokNik = true;
          boolErrokEmail = false;
          boolErrokPassword = false;
        });
      }).catchError((value) async {
        await FirebaseFirestore.instance
            .collection('users_pasien')
            .doc('${namaController.text}_${nikController.text}')
            .set({
          'NIK': nikController.text,
          'email': emailController.text,
          'password': bs64str,
          'namaPasien': namaController.text,
          'waktu': DateTime.now().toString(),
        });
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(
            "token", '${namaController.text}_${nikController.text}');
        prefs.setString(
            'idUser', '${namaController.text}_${nikController.text}');
        prefs.setString('namaUser', namaController.text);
        prefs.setString('nikUser', nikController.text);
        prefs.setString('emailUser', emailController.text);
        setState(() {
          isLoading = false;
        });
        Get.offAll(HasilMCU());

      });
    }
  }
}
