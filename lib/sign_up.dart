
// ignore_for_file: unused_field

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:furniture_app/login_screen.dart';
import 'package:furniture_app/widgets/getTextFromField.dart';
import 'package:furniture_app/widgets/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

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

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();
  final _userName = TextEditingController();
  final _emailController = TextEditingController();
  final _userPassword = TextEditingController();
  final _confirmPassword = TextEditingController();
  bool isUploading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            isUploading == true
                ? const LinearProgressIndicator(
                    color: Colors.purpleAccent,
                  )
                : Container(),
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
              'Бүртгүүлэх хэсэг',
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
            getTextFormField(
              controller: _confirmPassword,
              hintName: "Нууц үг давтах",
              icon: Icons.lock,
              isObscureText: true,
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
                  checkInfo();
                },

                child: const Text(
                  'БҮРТГҮҮЛЭХ',
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
                  'Нэвтрэх хэсэг рүү шилжих үү?',
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.black38,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => Loginscreen()));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkInfo() async {
    if (_emailController.text.isNotEmpty &&
        _userPassword.text.isNotEmpty &&
        _confirmPassword.text.isNotEmpty) {
      if (_confirmPassword.text == _userPassword.text) {
        if (_confirmPassword.text.length >= 6 &&
            _userPassword.text.length >= 6) {
          setState(() {
            isUploading = true;
          });
          saveAndUploadInfo();
        } else {
           Fluttertoast.showToast(msg: "Нууц үг 6 дээш оронтой байх ёстой!");
        }
      } else {
        Fluttertoast.showToast(msg: "Та ижил нууц үг оруулна уу!");
      }
    } else {
      Fluttertoast.showToast(msg: "Та бүх талбарыг бөглөнө үү!");
    }
  }

  saveAndUploadInfo() async {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _userPassword.text.trim());
    } on FirebaseAuthException catch  (e) {
      print(e.message); 

      Utils.showSnackBar(e.message.toString());
    }
    navigatorKey.currentState?.popUntil((route) => route.isFirst);

    Fluttertoast.showToast(msg: "Амжилттай нэмэгдлээ.");
    setState(() {
      isUploading = false;
    });
    Navigator.push(context, MaterialPageRoute(builder: (c) => Loginscreen()));
  }
}
