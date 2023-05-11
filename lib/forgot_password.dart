import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:furniture_app/widgets/utils.dart';
import './widgets/getTextFromField.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 47, 61, 133),
        elevation: 0,
        title: const Text("Нууц үг солих"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  "Хүлээн авах майл хаягаа оруулна уу",
                  style: TextStyle(fontSize: 15),
                ),
                const SizedBox(height: 20),
                getTextFormField(
                  controller: _emailController,
                  hintName: "И-майл",
                  icon: Icons.mail,
                  isObscureText: false,
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size.fromHeight(50),
                      backgroundColor: Color.fromARGB(255, 72, 86, 148),
                    ),
                    icon: Icon(Icons.mail),
                    label: Text("Нууц үг сэргээх"),
                    onPressed: () {
                      resetPassword();
                    }),
              ],
            )),
      ),
    );
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false, 
        builder: (context) =>const Center(
              child: CircularProgressIndicator(),
            ));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
          // Utils.showSnackBar("Нууц үг сэргээх майл илгээгдсэн.");
          Fluttertoast.showToast(msg: "Нууц үг сэргээх майл илгээгдсэн.");
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message.toString());
      Navigator.of(context).pop();
    }
  }
}
