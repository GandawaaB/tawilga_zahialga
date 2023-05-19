import 'dart:ffi';
import 'dart:math';
import 'dart:developer';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/forgot_password.dart';
import 'package:furniture_app/homeScreen.dart';
import 'package:furniture_app/pages/navbar/navbar.dart';
import 'package:furniture_app/sign_up.dart';
import 'package:furniture_app/widgets/utils.dart';
import './widgets/getTextFromField.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Loginscreen extends StatefulWidget {
  const Loginscreen({Key? key}) : super(key: key);

  @override
  _LoginscreenState createState() => _LoginscreenState();
}

final navigatorKey = GlobalKey<NavigatorState>();

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

class _LoginscreenState extends State<Loginscreen> {
  final _emailController = TextEditingController();
  final _userPassword = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _userPassword.dispose();
    super.dispose();
  }

  Widget loginScreen() {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 100,
            ),
            Container(
              width: 80,
              height: 80,
              alignment: Alignment.center,
              child: Image.asset("assets/profile_login.png"),
            ),
            const SizedBox(
              height: 80,
            ),

            const Text(
              'Нэвтрэх хэсэг',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                color: Color.fromARGB(255, 47, 61, 133),
              ),
            ),
            const SizedBox(
              height: 50,
            ),

            getTextFormField(
              controller: _emailController,
              hintName: "И-майл хаяг",
              icon: Icons.mail,
              isObscureText: false,
            ),
            //insert password
            getTextFormField(
              controller: _userPassword,
              hintName: "Нууц үг",
              icon: Icons.lock,
              isObscureText: true,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: TextButton(
                  child: const Text(
                    'Нууц үгээ мартсан уу?',
                    style: TextStyle(
                      fontSize: 15,
                      // fontWeight: FontWeight.w800,
                      color: Colors.black54,
                    ),
                  ),
                  // repassword
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (c) => ForgotPasswordScreen()));
                  }),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              width: double.infinity,
              child: TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: HexColor.fromHex('#414F81'),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                    side: const BorderSide(
                      width: 0,
                      color: Colors.white,
                    ),
                  ),
                ),
                //to home page
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (c) => const HomeScreen(),
                  //   ),
                  // );
                  authInfo();
                },

                child: const Text(
                  'НЭВТРЭХ',
                  style: TextStyle(
                    fontSize: 20,
                    // color: FvColors.button27FontColor,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              child: TextButton(
                child: const Text(
                  'Бүртгэлтэй данс байхгүй юу?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black38,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => SignUpScreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future authInfo() async {
    if (_emailController.text.isNotEmpty && _userPassword.text.isNotEmpty) {
      if (_userPassword.text.length >= 6) {
        showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context) => const Center(
            child: CircularProgressIndicator(),
          ),
        );

        try {
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: _emailController.text.trim(),
            password: _userPassword.text.trim(),
          );
        } on FirebaseAuthException catch (err) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
          print(err);
          // Utils.showSnackBar(err.message.toString());
        }
        navigatorKey.currentState?.popUntil((route) => route.isFirst);
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => NavigationScreen()));
      } else {
        Fluttertoast.showToast(msg: "Нууц үг 6 дээш оронтой байх ёстой!");
      }
    } else {
      Fluttertoast.showToast(msg: "Талбар хоосон байна!");
    }
  }

  @override
  Widget build(BuildContext context) {
    navigatorKey;

    return Scaffold(
      body: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            // if (snapshot.connectionState == ConnectionState.waiting) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // } else
            if (snapshot.hasError) {
              return const Center(
                child: Text(" Something went wrong"),
              );
            } else if (snapshot.hasData) {
              return const NavigationScreen();
            } else {
              return loginScreen();
            }
          }),
    );
  }
}
