import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../login_screen.dart';
import '../../model/getSetFormLast.dart';
import '../../model/getSettingsForm.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

String userName = 'Zorig';
String userPhone = '89898989';
final user = FirebaseAuth.instance.currentUser!;

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          height: 600,
          width: double.infinity,
          child: Column(
            children: [
              getSettingsForm(
                icon1: Icons.person,
                icon2: Icons.chevron_right,
                name: user.email!.toString(),
                phone: userPhone,
              ),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              getSetForm2(
                icon1: Icons.local_phone,
                icon2: Icons.chevron_right,
                name: "Холбоо барих",
              ),
              const Divider(
                height: 2,
                color: Colors.black,
              ),
              getSetForm2(
                icon1: Icons.description,
                icon2: Icons.chevron_right,
                name: "Үйлчилгээний нөхцөл",
              ),
              const SizedBox(
                height: 40,
              ),
              Container(
                margin: EdgeInsets.all(10.0),
                width: double.infinity,
                child: TextButton(
                  child: Text(
                    "Гарах",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () => logOut(),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1.0, color: Colors.grey),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  logOut() {
    FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: ((context) => Loginscreen())));
  }
}
