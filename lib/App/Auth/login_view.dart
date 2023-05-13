// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pasien_arifa_medikal/App/Auth/register_view.dart';
import 'package:pasien_arifa_medikal/App/Components/widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Pasien/hasil_mcu.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obsPass = true;
  bool boolErrokEmail = true;
  bool boolErrokPassword = true;

  String msgErrorEmail = "";
  String msgErrorPassword = "";

  Map<String, dynamic>? userMap;
  String idPasien = "";
  String nikDb = "";
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
            padding: EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 2)]),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      //   onTap: () {
                      //     String mydata1 = "myusername|password";
                      //     List<int> mydataint = utf8.encode(mydata1);
                      //     String bs64str = base64.encode(mydataint);
                      //     print(bs64str);
                      //     List<int> decodedint = base64.decode(bs64str);
                      //     String decodedstring = utf8.decode(decodedint);
                      //     print(decodedstring);
                      //   },
                      child: Container(
                          width: 200,
                          height: 200,
                          child: Image.asset(
                            'assets/images/favicon.png',
                            fit: BoxFit.cover,
                          )),
                    ),
                  ],
                ),
                textDefault("Masuk", 30, Colors.black, FontWeight.bold),
                Divider(
                  thickness: 1,
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
                        onChanged();
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
                        onChanged();
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
                    btnLogin();
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
                              "Masuk", 14, Colors.white, FontWeight.normal),
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
                          text: 'Belum punya akun?',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontFamily: 'poppins'),
                          children: <TextSpan>[
                            TextSpan(
                                text: ' Daftar disini',
                                style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 14,
                                    fontFamily: 'poppins'),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return RegisterView();
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

  onChanged() {
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
        .hasMatch(emailController.text)) {
      setState(() {
        msgErrorEmail = "Email Tidak Valid !";
        msgErrorPassword = "";
        boolErrokEmail = true;
        boolErrokPassword = false;
      });
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(passwordController.text)) {
      setState(() {
        msgErrorPassword =
            "Password minimal 8 karakter dan harus mengandung angka, huruf besar serta huruf kecil";
        msgErrorEmail = "";
        boolErrokEmail = false;
        boolErrokPassword = true;
      });
    } else {
      setState(() {
        msgErrorEmail = "";
        msgErrorPassword = "";
        boolErrokEmail = false;
        boolErrokPassword = false;
      });
    }
  }

  btnLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (boolErrokEmail == false && boolErrokPassword == false) {
      setState(() {
        isLoading = true;
      });
      await db
          .collection('users_pasien')
          .where('email', isEqualTo: emailController.text)
          .get()
          .then((value) async {
        userMap = value.docs[0].data();
        print(userMap!['password']);
        List<int> decodedint = base64.decode(userMap!['password']);
        String decodedPassword = utf8.decode(decodedint);
        if (emailController.text == userMap!['email'] &&
            passwordController.text == decodedPassword) {
          // await db.collection('pasien').where('NIK', isEqualTo: userMap!['NIK']).get().then((value2) {

          // });
          prefs.setString("token", '${userMap!['nama']}_${userMap!['NIK']}');
          prefs.setString('idUser', value.docs[0].id);
          prefs.setString('namaUser', userMap!['namaPasien']);
          prefs.setString('nikUser', userMap!['NIK']);
          prefs.setString('emailUser', emailController.text);
          setState(() {
            isLoading = false;
          });
          Get.offAll(HasilMCU());
        } else {
          setState(() {
            isLoading = false;
            msgErrorPassword = "Password Salah !";
            msgErrorEmail = "";
            boolErrokEmail = false;
            boolErrokPassword = true;
          });
        }
      }).catchError((value) async {
        print("ERROR $value");
        setState(() {
          isLoading = false;
          msgErrorEmail = "Akun Belum Terdaftar !";
          msgErrorPassword = "";
          boolErrokEmail = true;
          boolErrokPassword = false;
        });
      });
    }
  }
}
